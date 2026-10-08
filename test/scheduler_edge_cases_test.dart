import 'package:flutter_test/flutter_test.dart';
import 'package:day_planner/shared/models/task_model.dart';
import 'package:day_planner/shared/models/enums.dart';
import 'package:day_planner/core/scheduler/scheduler_engine.dart';

void main() {
  group('Scheduler Edge Cases - Milestone 16', () {
    test('Midnight wrapping (Algorithm 12)', () {
      // Crossing midnight downward
      final start1 = SchedulerEngine.ensureInsideTimeline(1430, 30);
      expect(start1, 20); // (1430 + 30) % 1440 = 20

      // Crossing midnight upward
      final start2 = SchedulerEngine.ensureInsideTimeline(-15, 30);
      expect(start2, 1425); // (-15 + 1440) % 1440 = 1425
    });

    test('Cascading push limits', () {
      final task1 = Task(date: DateTime(2026, 1, 1),id: 'A', name: 'A', type: BlockType.task, startMinute: 600, duration: 30, colorTag: ColorTag.blue, createdAt: DateTime.now(), updatedAt: DateTime.now());
      final task2 = Task(date: DateTime(2026, 1, 1),id: 'B', name: 'B', type: BlockType.task, startMinute: 630, duration: 30, colorTag: ColorTag.blue, createdAt: DateTime.now(), updatedAt: DateTime.now());
      final task3 = Task(date: DateTime(2026, 1, 1),id: 'C', name: 'C', type: BlockType.task, startMinute: 660, duration: 30, colorTag: ColorTag.blue, createdAt: DateTime.now(), updatedAt: DateTime.now());
      
      // Move task1 to 615, should push B to 645, and C to 675
      final movedTask = task1.copyWith(startMinute: 615);
      final result = SchedulerEngine.resolveConflicts(movedTask, [movedTask, task2, task3]);
      
      final resB = result.firstWhere((t) => t.id == 'B');
      final resC = result.firstWhere((t) => t.id == 'C');
      
      expect(resB.startMinute, 645);
      expect(resC.startMinute, 675);
    });

    test('Overlapping breaks edge cases (Algorithm 11)', () {
      final task = Task(date: DateTime(2026, 1, 1),id: 'T', name: 'T', type: BlockType.task, startMinute: 600, duration: 60, colorTag: ColorTag.blue, createdAt: DateTime.now(), updatedAt: DateTime.now());
      final break1 = Task(date: DateTime(2026, 1, 1),id: 'B1', name: 'B1', type: BlockType.breakBlock, startMinute: 630, duration: 30, colorTag: ColorTag.none, createdAt: DateTime.now(), updatedAt: DateTime.now());
      
      // If we move T to 615, end is 675, overlaps break B1 (630-660)
      // Break avoidance should push T to start after the break -> 660
      final movedTask = task.copyWith(startMinute: 615);
      final result = SchedulerEngine.validateAndApplyPlacement(movedTask, [movedTask, break1]);
      
      final resT = result.firstWhere((t) => t.id == 'T');
      // Actually, wait, validateAndApplyPlacement first applies Break Avoidance.
      // So T should be moved to 660 (the end of B1).
      expect(resT.startMinute, 660);
    });
  });
}
