import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:day_planner/shared/models/planner_model.dart';
import 'package:day_planner/shared/models/draft_models.dart';
import 'package:day_planner/providers/database_provider.dart';
import 'package:day_planner/providers/app_error_provider.dart';
import 'package:day_planner/core/commands/planner_commands.dart';
import 'package:day_planner/core/database/exceptions.dart';
import 'package:flutter/widgets.dart';
import 'package:day_planner/services/notification_service.dart';

/// The main state provider for the Day Planner application.
/// Uses `PlannerService` to handle domain logic and persistence.
class PlannerNotifier extends AsyncNotifier<Planner> with WidgetsBindingObserver {
  final CommandHistory _commandHistory = CommandHistory();
  Timer? _rolloverTimer;

  bool get canUndo => _commandHistory.canUndo;

  Future<void> undo() async {
    if (!canUndo) return;
    final command = _commandHistory.pop();
    if (command != null) {
      await _executeAction(
        () => ref.read(plannerServiceProvider).restorePlannerState(command.beforeState),
        (oldState, newState) {}, // Undo doesn't push a new command
      );
    }
  }

  Future<void> _executeAction(
    Future<Planner> Function() action, 
    void Function(Planner, Planner) logCommand
  ) async {
    final current = state.value;
    if (current == null) return;

    state = await AsyncValue.guard(() async {
      try {
        final newState = await action();
        logCommand(current, newState);
        // Sync notifications with new tasks state
        notificationService.scheduleReminders(newState.tasks, newState.date);
        return newState;
      } on SaveFailureException catch (e) {
        ref.read(appErrorProvider.notifier).showError(e.message);
        logCommand(current, e.preservedState);
        return e.preservedState;
      }
    });
  }

  @override
  FutureOr<Planner> build() async {
    WidgetsBinding.instance.addObserver(this);
    
    // Start rollover timer (checks every minute)
    _rolloverTimer = Timer.periodic(const Duration(minutes: 1), (_) {
      _checkRollover();
    });

    ref.onDispose(() {
      WidgetsBinding.instance.removeObserver(this);
      _rolloverTimer?.cancel();
    });

    final service = ref.watch(plannerServiceProvider);
    
    // Perform initial rollover check
    final now = DateTime.now();
    final planner = await service.rolloverToNewDay(now);
    
    // Schedule reminders for the loaded tasks
    notificationService.scheduleReminders(planner.tasks, planner.date);
    
    return planner;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkRollover();
    }
  }

  Future<void> _checkRollover() async {
    final current = state.value;
    if (current == null) return;

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final currentPlannerDate = DateTime(current.date.year, current.date.month, current.date.day);

    if (currentPlannerDate.isBefore(today)) {
      state = await AsyncValue.guard(() async {
        final newState = await ref.read(plannerServiceProvider).rolloverToNewDay(now);
        notificationService.scheduleReminders(newState.tasks, newState.date);
        return newState;
      });
    }
  }

  /// Adds a new block (task or break).
  Future<void> addBlock(BlockDraft draft) async {
    final current = state.value;
    if (current == null) return;
    
    await _executeAction(
      () => ref.read(plannerServiceProvider).addBlock(current, draft),
      (oldState, newState) => _commandHistory.push(AddBlockCommand(oldState, newState)),
    );
  }

  /// Edits an existing block.
  Future<void> editBlock(BlockDraft draft) async {
    final current = state.value;
    if (current == null) return;

    await _executeAction(
      () => ref.read(plannerServiceProvider).editBlock(current, draft),
      (oldState, newState) => _commandHistory.push(EditBlockCommand(oldState, newState)),
    );
  }

  /// Moves a block to a new start time.
  Future<void> moveBlock(String blockId, int newStartMinute) async {
    final current = state.value;
    if (current == null) return;

    await _executeAction(
      () => ref.read(plannerServiceProvider).moveBlock(current, blockId, newStartMinute),
      (oldState, newState) => _commandHistory.push(MoveBlockCommand(oldState, newState)),
    );
  }

  /// Resizes a block.
  Future<void> resizeBlock(String blockId, int newDuration) async {
    final current = state.value;
    if (current == null) return;

    await _executeAction(
      () => ref.read(plannerServiceProvider).resizeBlock(current, blockId, newDuration),
      (oldState, newState) => _commandHistory.push(ResizeBlockCommand(oldState, newState)),
    );
  }

  /// Deletes a block.
  Future<void> deleteBlock(String blockId) async {
    final current = state.value;
    if (current == null) return;

    await _executeAction(
      () => ref.read(plannerServiceProvider).deleteBlock(current, blockId),
      (oldState, newState) => _commandHistory.push(DeleteBlockCommand(oldState, newState)),
    );
  }

  /// Toggles completion status of a task.
  Future<void> toggleCompletion(String blockId) async {
    final current = state.value;
    if (current == null) return;

    await _executeAction(
      () => ref.read(plannerServiceProvider).toggleCompletion(current, blockId),
      (oldState, newState) => _commandHistory.push(ToggleCompletionCommand(oldState, newState)),
    );
  }

  /// Deletes all completed tasks.
  Future<void> deleteAllCompleted() async {
    final current = state.value;
    if (current == null) return;

    await _executeAction(
      () => ref.read(plannerServiceProvider).deleteAllCompleted(current),
      (oldState, newState) => _commandHistory.push(DeleteBlockCommand(oldState, newState)),
    );
  }

  /// Runs the auto-planner engine.
  Future<void> autoPlan() async {
    final current = state.value;
    if (current == null) return;

    await _executeAction(
      () => ref.read(plannerServiceProvider).autoPlan(current),
      (oldState, newState) => _commandHistory.push(AutoPlanCommand(oldState, newState)),
    );
  }

  /// Updates application settings.
  Future<void> updateSettings(SettingsDraft draft) async {
    final current = state.value;
    if (current == null) return;

    await _executeAction(
      () => ref.read(plannerServiceProvider).updateSettings(current, draft),
      (oldState, newState) {},
    );
  }

  /// Clears all tasks from the planner.
  Future<void> clearAll() async {
    final current = state.value;
    if (current == null) return;

    await _executeAction(
      () => ref.read(plannerServiceProvider).clearAll(current),
      (oldState, newState) => _commandHistory.push(ClearAllCommand(oldState, newState)),
    );
  }

  /// Forces a save of the current in-memory state.
  Future<void> forceSave() async {
    final current = state.value;
    if (current == null) return;

    await _executeAction(
      () => ref.read(plannerServiceProvider).restorePlannerState(current),
      (oldState, newState) {},
    );
  }
}

final plannerProvider = AsyncNotifierProvider<PlannerNotifier, Planner>(() {
  return PlannerNotifier();
});
