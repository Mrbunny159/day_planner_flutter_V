import 'package:flutter_test/flutter_test.dart';
import 'package:day_planner/shared/models/task_model.dart';
import 'package:day_planner/shared/models/enums.dart';
import 'package:day_planner/core/scheduler/scheduler_engine.dart';

void main() {
  group('SchedulerEngine.autoPlan invariants', () {
    // Helper to generate a basic task
    Task makeTask({
      required String id,
      required int startMinute,
      required int duration,
      bool completed = false,
      BlockType type = BlockType.task,
    }) {
      return Task(date: DateTime(2026, 1, 1),
        id: id,
        name: 'Task $id',
        startMinute: startMinute,
        duration: duration,
        completed: completed,
        type: type,
        recurring: Repeat.none,
        colorTag: ColorTag.blue,
        createdAt: DateTime(2023),
        updatedAt: DateTime(2023),
      );
    }

    void assertInvariants(List<Task> input, List<Task> output) {
      // The number of tasks before and after is identical.
      expect(output.length, input.length, reason: 'Task count changed');

      // Every task ID is preserved.
      final inputIds = input.map((t) => t.id).toSet();
      final outputIds = output.map((t) => t.id).toSet();
      expect(outputIds, inputIds, reason: 'Task IDs changed');

      for (var task in output) {
        final original = input.firstWhere((t) => t.id == task.id);

        // Every task starts on a 15-minute boundary.
        expect(
          task.startMinute % 15,
          0,
          reason: 'Task ${task.id} not on 15m boundary',
        );

        // Every task duration is unchanged.
        expect(
          task.duration,
          original.duration,
          reason: 'Task ${task.id} duration changed',
        );

        // Completed tasks remain completed.
        expect(
          task.completed,
          original.completed,
          reason: 'Task ${task.id} completion changed',
        );

        // Every task stays within valid timeline bounds.
        expect(task.startMinute, greaterThanOrEqualTo(0));
        expect(task.startMinute + task.duration, lessThanOrEqualTo(1440));
      }

      // No two tasks overlap.
      // No task overlaps a break.
      for (int i = 0; i < output.length; i++) {
        for (int j = i + 1; j < output.length; j++) {
          final a = output[i];
          final b = output[j];
          final aEnd = a.startMinute + a.duration;
          final bEnd = b.startMinute + b.duration;

          final overlaps = (a.startMinute < bEnd) && (aEnd > b.startMinute);
          expect(overlaps, false, reason: 'Blocks ${a.id} and ${b.id} overlap');
        }
      }
    }

    test(
      '1. Completed Tasks - Historically completed tasks remain unchanged',
      () {
        final input = [
          makeTask(
            id: '1',
            startMinute: 60,
            duration: 60,
            completed: true,
          ), // 1:00 - 2:00
        ];
        final output = SchedulerEngine.autoPlan(
          input,
          currentMinuteOverride: 300,
        ); // Current: 5:00
        assertInvariants(input, output);
        expect(
          output.first.startMinute,
          60,
          reason: 'Historically completed task moved',
        );
      },
    );

    test('1. Completed Tasks - Overlapping future compacted correctly', () {
      final input = [
        makeTask(
          id: '1',
          startMinute: 240,
          duration: 60,
          completed: true,
        ), // 4:00 - 5:00
        makeTask(
          id: '2',
          startMinute: 300,
          duration: 60,
          completed: true,
        ), // 5:00 - 6:00
      ];
      // Current: 270 (4:30). Align to grid -> 270
      final output = SchedulerEngine.autoPlan(
        input,
        currentMinuteOverride: 270,
      );
      assertInvariants(input, output);

      final t1 = output.firstWhere((t) => t.id == '1');
      final t2 = output.firstWhere((t) => t.id == '2');

      expect(
        t2.startMinute < 270,
        true,
        reason: 'Future task not compacted before current time',
      );
      expect(
        t1.startMinute < t2.startMinute,
        true,
        reason: 'Relative ordering not preserved',
      );
    });

    test('2. Incomplete Tasks - Reinserted without overlap', () {
      final input = [
        makeTask(id: '1', startMinute: 0, duration: 60),
        makeTask(id: '2', startMinute: 60, duration: 30),
      ];
      final output = SchedulerEngine.autoPlan(
        input,
        currentMinuteOverride: 120,
      ); // 2:00
      assertInvariants(input, output);

      final t1 = output.firstWhere((t) => t.id == '1');
      final t2 = output.firstWhere((t) => t.id == '2');

      expect(t1.startMinute, 120);
      expect(t2.startMinute, 180);
    });

    test('3. Break Handling - Tasks never overlap breaks', () {
      final input = [
        makeTask(id: 't1', startMinute: 0, duration: 60),
        makeTask(
          id: 'b1',
          startMinute: 150,
          duration: 60,
          type: BlockType.breakBlock,
        ), // 2:30 - 3:30
      ];
      final output = SchedulerEngine.autoPlan(
        input,
        currentMinuteOverride: 120,
      ); // 2:00
      assertInvariants(input, output);

      final t1 = output.firstWhere((t) => t.id == 't1');
      final b1 = output.firstWhere((t) => t.id == 'b1');

      expect(b1.startMinute, 150, reason: 'Break moved');
      // Task needs 60 mins. If it starts at 120, it ends at 180, which overlaps break (150-210).
      // So it should be pushed AFTER the break -> 210.
      expect(t1.startMinute, 210, reason: 'Task did not avoid break correctly');
    });

    test('6. Empty Planner - unchanged', () {
      final output = SchedulerEngine.autoPlan([], currentMinuteOverride: 120);
      assertInvariants([], output);
    });

    test('8. Fully Empty Timeline - Tasks pack from current point', () {
      final input = [
        makeTask(id: '1', startMinute: 0, duration: 30),
        makeTask(id: '2', startMinute: 0, duration: 30),
        makeTask(id: '3', startMinute: 0, duration: 30),
      ];
      final output = SchedulerEngine.autoPlan(
        input,
        currentMinuteOverride: 60,
      ); // 1:00
      assertInvariants(input, output);

      expect(output.firstWhere((t) => t.id == '1').startMinute, 60);
      expect(output.firstWhere((t) => t.id == '2').startMinute, 90);
      expect(output.firstWhere((t) => t.id == '3').startMinute, 120);
    });

    test(
      '9. Boundary Conditions - Very long tasks push past boundary wraps',
      () {
        // current is 1400 (23:20). Grid aligns to 1410 (23:30).
        // Task is 60 minutes long. Cannot fit from 1410 (ends 1470).
        // It must wrap to 00:00.
        final input = [makeTask(id: '1', startMinute: 0, duration: 60)];
        final output = SchedulerEngine.autoPlan(
          input,
          currentMinuteOverride: 1400,
        );
        assertInvariants(input, output);

        expect(output.firstWhere((t) => t.id == '1').startMinute, 0);
      },
    );

    test('10. Boundary Conditions - Zero incomplete tasks', () {
      final input = [
        makeTask(id: '1', startMinute: 0, duration: 60, completed: true),
      ];
      final output = SchedulerEngine.autoPlan(
        input,
        currentMinuteOverride: 1400,
      );
      assertInvariants(input, output);
    });
  });
}
