import 'package:flutter_test/flutter_test.dart';
import 'package:day_planner/shared/models/planner_model.dart';
import 'package:day_planner/shared/models/task_model.dart';
import 'package:day_planner/shared/models/draft_models.dart';
import 'package:day_planner/shared/models/planner_settings_model.dart';
import 'package:day_planner/shared/models/summary_model.dart';
import 'package:day_planner/shared/models/enums.dart';
import 'package:day_planner/services/planner_service.dart';
import 'package:day_planner/repositories/planner_repository.dart';

// Mock Repository for testing
class MockPlannerRepository implements PlannerRepository {
  final Map<DateTime, Planner> _storage = {};
  DateTime? _mostRecentDate;
  PlannerSettings _settings = const PlannerSettings();

  @override
  Future<void> clearPlannerTasks(DateTime date) async {
    if (_storage.containsKey(date)) {
      _storage[date] = _storage[date]!.copyWith(tasks: []);
    }
  }

  @override
  Future<DateTime?> loadMostRecentTaskDate() async {
    return _mostRecentDate;
  }

  @override
  Future<Planner> loadPlanner(DateTime date) async {
    if (_storage.containsKey(date)) {
      return _storage[date]!;
    }
    return Planner(
      id: 'mock_planner',
      date: date,
      tasks: [],
      settings: _settings,
      summary: const Summary(completedMinutes: 0, breakMinutes: 0, freeMinutes: 0),
      lastUpdated: DateTime.now(),
    );
  }

  @override
  Future<void> savePlanner(Planner planner) async {
    _storage[planner.date] = planner;
    _settings = planner.settings;
    if (_mostRecentDate == null || planner.date.isAfter(_mostRecentDate!)) {
      _mostRecentDate = planner.date;
    }
  }
}

void main() {
  late MockPlannerRepository repository;
  late PlannerService service;
  
  final yesterday = DateTime(2026, 1, 1);
  final today = DateTime(2026, 1, 2);
  final now = DateTime.now();

  setUp(() {
    repository = MockPlannerRepository();
    service = PlannerService(repository);
  });

  Task makeTask({
    required String id, 
    required int startMinute, 
    required int duration, 
    Repeat repeat = Repeat.none,
    BlockType type = BlockType.task,
    bool completed = false,
    DateTime? date,
  }) {
    return Task(
      id: id,
      startMinute: startMinute,
      duration: duration,
      recurring: repeat,
      type: type,
      completed: completed,
      date: date ?? yesterday,
      createdAt: now,
      updatedAt: now,
    );
  }

  test('Test 1 - Daily Task Creation & Test 6 - Completion Reset', () async {
    final initialPlanner = await service.loadPlanner(date: yesterday);
    const taskDraft = BlockDraft(
      name: 'Daily Task',
      startMinute: 600,
      duration: 60,
      type: BlockType.task,
      recurring: Repeat.daily,
    );
    
    var plannerWithTask = await service.addBlock(initialPlanner, taskDraft);
    plannerWithTask = await service.toggleCompletion(plannerWithTask, plannerWithTask.tasks.first.id);
    expect(plannerWithTask.tasks.first.completed, isTrue);

    final newPlanner = await service.rolloverToNewDay(today);
    
    expect(newPlanner.tasks.length, 1);
    final rolledOverTask = newPlanner.tasks.first;
    expect(rolledOverTask.name, 'Daily Task');
    expect(rolledOverTask.startMinute, 600);
    expect(rolledOverTask.duration, 60);
    expect(rolledOverTask.recurring, Repeat.daily);
    expect(rolledOverTask.completed, isFalse, reason: 'Completion status must reset');
    expect(rolledOverTask.date, today, reason: 'Task must belong to new day');
  });

  test('Test 2 - Daily Break Creation', () async {
    final initialPlanner = await service.loadPlanner(date: yesterday);
    const breakDraft = BlockDraft(
      name: 'Lunch Break',
      startMinute: 720,
      duration: 60,
      type: BlockType.breakBlock,
      recurring: Repeat.daily,
    );
    await service.addBlock(initialPlanner, breakDraft);

    final newPlanner = await service.rolloverToNewDay(today);
    
    expect(newPlanner.tasks.length, 1);
    final rolledOverBreak = newPlanner.tasks.first;
    expect(rolledOverBreak.type, BlockType.breakBlock);
    expect(rolledOverBreak.startMinute, 720);
    expect(rolledOverBreak.recurring, Repeat.daily);
  });

  test('Test 3 - One-Time Tasks', () async {
    final initialPlanner = await service.loadPlanner(date: yesterday);
    const oneTimeDraft = BlockDraft(
      name: 'One-off Task',
      startMinute: 600,
      duration: 60,
      type: BlockType.task,
      recurring: Repeat.none,
    );
    await service.addBlock(initialPlanner, oneTimeDraft);

    final newPlanner = await service.rolloverToNewDay(today);
    expect(newPlanner.tasks.isEmpty, isTrue, reason: 'One-time task should not recreate');
  });

  test('Test 4 - Duplicate Prevention (Idempotency)', () async {
    final initialPlanner = await service.loadPlanner(date: yesterday);
    const taskDraft = BlockDraft(
      name: 'Daily Task',
      startMinute: 600,
      duration: 60,
      type: BlockType.task,
      recurring: Repeat.daily,
    );
    await service.addBlock(initialPlanner, taskDraft);

    await service.rolloverToNewDay(today);
    await service.rolloverToNewDay(today);
    final newPlanner = await service.rolloverToNewDay(today);
    
    expect(newPlanner.tasks.length, 1, reason: 'Only one recurring copy should exist');
  });

  test('Test 5 - Historical Integrity', () async {
    final initialPlanner = await service.loadPlanner(date: yesterday);
    const taskDraft = BlockDraft(
      name: 'Daily Task',
      startMinute: 600,
      duration: 60,
      type: BlockType.task,
      recurring: Repeat.daily,
    );
    await service.addBlock(initialPlanner, taskDraft);

    final todayPlanner = await service.rolloverToNewDay(today);
    
    await service.addBlock(todayPlanner, const BlockDraft(
      name: 'New Today Task',
      startMinute: 700,
      duration: 30,
      type: BlockType.task,
      recurring: Repeat.none,
    ));

    final yesterdayPlannerCheck = await repository.loadPlanner(yesterday);
    expect(yesterdayPlannerCheck.tasks.length, 1);
    expect(yesterdayPlannerCheck.tasks.first.name, 'Daily Task');
  });

  test('Test 7 - Scheduler Validation', () async {
    final initialPlanner = await service.loadPlanner(date: yesterday);
    var p = await service.addBlock(initialPlanner, const BlockDraft(
      startMinute: 600, duration: 60, type: BlockType.task, recurring: Repeat.daily,
    ));
    final badTask = makeTask(id: 'bad', startMinute: 610, duration: 30, repeat: Repeat.daily, date: yesterday);
    p = p.copyWith(tasks: [...p.tasks, badTask]);
    await repository.savePlanner(p);

    final todayPlanner = await service.rolloverToNewDay(today);
    
    final t1 = todayPlanner.tasks[0];
    final t2 = todayPlanner.tasks[1];
    
    final overlap = (t1.startMinute < t2.endMinute) && (t2.startMinute < t1.endMinute);
    expect(overlap, isFalse, reason: 'Scheduler validation should fix overlaps');
  });
  
  test('Test 8 - Auto Planner Compatibility', () async {
    final initialPlanner = await service.loadPlanner(date: yesterday);
    const taskDraft = BlockDraft(
      name: 'Daily Task',
      startMinute: 600,
      duration: 60,
      type: BlockType.task,
      recurring: Repeat.daily,
    );
    await service.addBlock(initialPlanner, taskDraft);

    var newPlanner = await service.rolloverToNewDay(today);
    
    // Run auto-plan
    newPlanner = await service.autoPlan(newPlanner);
    
    expect(newPlanner.tasks.length, 1);
  });
  
  test('Test 9 - Undo Compatibility', () async {
    // Note: PlannerService directly executes commands but Undo is managed by PlannerNotifier.
    // So we test if PlannerService restorePlannerState restores correctly.
    final initialPlanner = await service.loadPlanner(date: yesterday);
    const taskDraft = BlockDraft(
      name: 'Daily Task',
      startMinute: 600,
      duration: 60,
      type: BlockType.task,
      recurring: Repeat.daily,
    );
    await service.addBlock(initialPlanner, taskDraft);

    final newPlanner = await service.rolloverToNewDay(today);
    
    final afterEdit = await service.editBlock(newPlanner, BlockDraft(
      id: newPlanner.tasks.first.id,
      name: 'Edited Task',
      startMinute: 600,
      duration: 60,
      type: BlockType.task,
      recurring: Repeat.daily,
    ));
    expect(afterEdit.tasks.first.name, 'Edited Task');
    
    final restored = await service.restorePlannerState(newPlanner);
    expect(restored.tasks.first.name, 'Daily Task');
  });
}
