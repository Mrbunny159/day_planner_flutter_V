import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:day_planner/shared/models/task_model.dart';
import 'package:day_planner/core/scheduler/scheduler_engine.dart';

void main() {
  test('Overlap resolution when dragging block upwards', () {
    final taskA = Task(date: DateTime(2026, 1, 1),
      id: 'A',
      name: 'Task A',
      startMinute: 600, // 10:00
      duration: 60,     // 10:00 - 11:00
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    
    final taskB = Task(date: DateTime(2026, 1, 1),
      id: 'B',
      name: 'Task B',
      startMinute: 720, // 12:00
      duration: 60,     // 12:00 - 13:00
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final allBlocks = [taskA, taskB];

    // User drags taskB to 630 (10:30)
    final movedTaskB = taskB.copyWith(startMinute: 630);

    final updatedBlocks = SchedulerEngine.validateAndApplyPlacement(movedTaskB, allBlocks);

    for (final block in updatedBlocks) {
      debugPrint('id: ${block.id}, start: ${block.startMinute}, end: ${block.startMinute + block.duration}');
    }

    // Check for overlap
    final a = updatedBlocks.firstWhere((b) => b.id == 'A');
    final b = updatedBlocks.firstWhere((b) => b.id == 'B');
    final overlaps = a.startMinute < (b.startMinute + b.duration) && b.startMinute < (a.startMinute + a.duration);
    
    expect(overlaps, isFalse, reason: 'Tasks should not overlap');
  });
}
