import 'package:flutter/material.dart';
import 'package:day_planner/shared/models/task_model.dart';
import 'package:day_planner/shared/models/enums.dart';
import 'package:day_planner/core/constants/app_constants.dart';

/// Pure Dart implementation of the day planner scheduling algorithms.
///
/// This engine is completely UI-independent. It receives current state
/// and returns new state. It implements all algorithms defined in the ASD.
class SchedulerEngine {
  SchedulerEngine._();

  // ─── ALGORITHM 1: FIND NEXT FREE SLOT ────────────────────────────────

  /// Returns the start minute of the next free slot that can fit [durationMin].
  /// Returns null if no slot can be found.
  static int? findNextFreeSlot({
    required int durationMin,
    required List<Task> allBlocks,
    int? startFrom,
    int direction = 1,
  }) {
    int currentMinute;
    if (startFrom != null) {
      currentMinute = startFrom;
    } else {
      final now = TimeOfDay.now();
      // Round up to nearest 15 mins
      final alignedMin = ((now.minute + 14) ~/ 15) * 15;
      currentMinute = (now.hour * 60) + alignedMin;
    }

    // Clamp bottom bounds only, let the loop naturally reject too-high values
    if (currentMinute < 0) currentMinute = 0;

    // Align to grid
    if (currentMinute % AppConstants.gridResolution != 0) {
      currentMinute +=
          AppConstants.gridResolution -
          (currentMinute % AppConstants.gridResolution);
    }

    // Build occupied list (tasks + breaks)
    final occupied =
        allBlocks
            .map((b) => (start: b.startMinute, end: b.startMinute + b.duration))
            .toList()
          ..sort((a, b) => a.start.compareTo(b.start));

    while (currentMinute >= 0 &&
        currentMinute <= AppConstants.totalDayMinutes - durationMin) {
      final startMinute = currentMinute;
      final endMinute = startMinute + durationMin;

      // Check conflict
      bool hasConflict = false;
      for (final occ in occupied) {
        // Two blocks conflict if they strictly overlap
        if (endMinute > occ.start && startMinute < occ.end) {
          hasConflict = true;
          break;
        }
      }

      if (!hasConflict) {
        return startMinute;
      }

      currentMinute += AppConstants.gridResolution * direction;
    }

    return null;
  }

  // ─── ALGORITHM 12: ENSURE TIMELINE BOUNDARY ──────────────────────────

  /// Clamps/wraps the start minute so the block stays inside the timeline.
  static int ensureInsideTimeline(int startMinute, int duration) {
    final int endMinute = startMinute + duration;
    if (endMinute > AppConstants.totalDayMinutes) {
      return (startMinute + duration) % AppConstants.totalDayMinutes;
    } else if (startMinute < 0) {
      return (startMinute + AppConstants.totalDayMinutes) % AppConstants.totalDayMinutes;
    }
    return startMinute;
  }

  // ─── ALGORITHM 10: PUSH FORWARD CONFLICT RESOLUTION ──────────────────

  /// Resolves conflicts when [movedBlock] is placed by pushing intersecting tasks forward.
  /// Returns a new list of all blocks with updated positions.
  static List<Task> resolveConflicts(Task movedBlock, List<Task> allBlocks) {
    // Copy the list to avoid mutating the original
    final updatedBlocks = List<Task>.from(allBlocks);

    // Replace the moved block in the list with its new state
    final index = updatedBlocks.indexWhere((t) => t.id == movedBlock.id);
    if (index != -1) {
      updatedBlocks[index] = movedBlock;
    } else {
      updatedBlocks.add(movedBlock);
    }

    int movedEnd = movedBlock.startMinute + movedBlock.duration;

    // Only look at blocks starting at or after movedBlock
    final forwardBlocks =
        updatedBlocks
            .where(
              (b) =>
                  b.id != movedBlock.id &&
                  (b.startMinute + b.duration) > movedBlock.startMinute,
            )
            .toList()
          ..sort((a, b) => a.startMinute.compareTo(b.startMinute));

    for (final block in forwardBlocks) {
      if (block.startMinute < movedEnd) {
        if (block.type == BlockType.task) {
          // Push task forward
          final duration = block.duration;

          // But wait, what if pushing it forward makes it overlap a break?
          // ASD Algorithm 11: Break Avoidance. Breaks are never moved.
          int newStart = movedEnd;

          // Apply Break Avoidance
          newStart = _avoidBreaks(newStart, duration, updatedBlocks, block.id);

          final blockIndex = updatedBlocks.indexWhere((t) => t.id == block.id);
          updatedBlocks[blockIndex] = block.copyWith(startMinute: newStart);

          movedEnd = newStart + duration;
        } else if (block.type == BlockType.breakBlock) {
          // Break blocks cannot be moved.
          // The python source just skips moving it: `break`
          // but we still need to check if the moved block overlaps it.
          // In the python implementation of resolve_conflicts, breaks stop the chain if they are reached,
          // but actually, we should just not push breaks.
          // We handled break avoidance above for tasks.
        }
      } else {
        // If the next block starts after the current movedEnd, the chain is broken
        break;
      }
    }

    return updatedBlocks;
  }

  /// Helper for Break Avoidance (Algorithm 11).
  /// If placing a task at [startMinute] with [duration] overlaps a break,
  /// it searches for the next available slot strictly after the break.
  static int _avoidBreaks(
    int startMinute,
    int duration,
    List<Task> allBlocks,
    String selfId,
  ) {
    int currentStart = startMinute;
    bool hasBreakConflict = true;

    while (hasBreakConflict) {
      hasBreakConflict = false;
      final int endMinute = currentStart + duration;

      for (final block in allBlocks) {
        if (block.type == BlockType.breakBlock && block.id != selfId) {
          if (endMinute > block.startMinute &&
              currentStart < block.startMinute + block.duration) {
            // Conflict with a break! Jump the task to the end of the break.
            currentStart = block.startMinute + block.duration;
            hasBreakConflict = true;
          }
        }
      }
    }

    // Grid snap after break jump
    if (currentStart % AppConstants.gridResolution != 0) {
      currentStart +=
          AppConstants.gridResolution -
          (currentStart % AppConstants.gridResolution);
    }

    return currentStart;
  }

  // ─── VALIDATION PIPELINE (Algorithm 4) ───────────────────────────────────

  /// Ensures a task placement is valid, snaps to grid, applies bounds,
  /// avoids breaks, and pushes conflicting tasks forward.
  /// Used for Drag, Resize, and Create operations.
  static List<Task> validateAndApplyPlacement(
    Task taskToPlace,
    List<Task> allBlocks,
  ) {
    // 1. Grid Snap
    int snappedStart = taskToPlace.startMinute;
    if (snappedStart % AppConstants.gridResolution != 0) {
      snappedStart =
          (snappedStart / AppConstants.gridResolution).round() *
          AppConstants.gridResolution;
    }

    // 2. Boundary Check
    snappedStart = ensureInsideTimeline(snappedStart, taskToPlace.duration);

    // 3. Break Check / Avoidance (Only tasks jump over breaks)
    if (taskToPlace.type == BlockType.task) {
      snappedStart = _avoidBreaks(
        snappedStart,
        taskToPlace.duration,
        allBlocks,
        taskToPlace.id,
      );
    }

    // Boundary check again in case break jump pushed it off the timeline
    snappedStart = ensureInsideTimeline(snappedStart, taskToPlace.duration);

    // Update the task with valid position
    final placedTask = taskToPlace.copyWith(startMinute: snappedStart);

    // 4. Resolve Conflicts (Task Check / Push Forward)
    return resolveConflicts(placedTask, allBlocks);
  }

  // ─── ALGORITHM 14: AUTO PLANNER ──────────────────────────────────────────

  /// Auto plans uncompleted tasks by placing them after the current time,
  /// packing them without gaps, and skipping breaks.
  static List<Task> autoPlan(
    List<Task> allBlocks, {
    int? currentMinuteOverride,
  }) {
    int currentMinute;
    if (currentMinuteOverride != null) {
      currentMinute = currentMinuteOverride;
    } else {
      final now = TimeOfDay.now();
      currentMinute = now.hour * 60 + now.minute;
    }
    // Align to grid
    currentMinute = ((currentMinute + 14) ~/ 15) * 15;

    final completedTasks = allBlocks
        .where((t) => t.completed && t.type == BlockType.task)
        .toList();
    final incompleteTasks = allBlocks
        .where((t) => !t.completed && t.type == BlockType.task)
        .toList();
    final breaks = allBlocks
        .where((t) => t.type == BlockType.breakBlock)
        .toList();

    // The output state
    final plannedBlocks = <Task>[...breaks];

    // ASD FR-063: Completed tasks scheduled after current time relocate before current time if possible.
    // ASD FR-064: Completed tasks before current time remain in place.
    completedTasks.sort(
      (a, b) => b.startMinute.compareTo(a.startMinute),
    ); // reverse chronological

    int pastMinute = currentMinute - 5;
    for (var task in completedTasks) {
      if (task.startMinute >= currentMinute ||
          task.startMinute + task.duration > currentMinute) {
        // Task overlaps or is in the future. Push it before current time.
        int newStart = pastMinute - task.duration;
        if (newStart < 0) newStart = 0;

        newStart = ensureInsideTimeline(newStart, task.duration);

        // Align to grid (round down to avoid pushing forward into current time)
        newStart =
            (newStart ~/ AppConstants.gridResolution) *
            AppConstants.gridResolution;

        plannedBlocks.add(task.copyWith(startMinute: newStart));
        pastMinute = newStart - 1;
      } else {
        // Historically completed, keep in place.
        plannedBlocks.add(task);
      }
    }

    // Sort incomplete tasks chronologically
    incompleteTasks.sort((a, b) => a.startMinute.compareTo(b.startMinute));

    int futureMinute = currentMinute;

    for (var task in incompleteTasks) {
      // Find the next free slot starting from futureMinute
      int? nextSlot = findNextFreeSlot(
        durationMin: task.duration,
        allBlocks: plannedBlocks,
        startFrom: futureMinute,
      );

      if (nextSlot != null) {
        plannedBlocks.add(task.copyWith(startMinute: nextSlot));
        // Next task searches from the end of this task
        futureMinute = nextSlot + task.duration;
      } else {
        // If we wrapped or failed to find a slot, wrap to 0 and search again
        nextSlot = findNextFreeSlot(
          durationMin: task.duration,
          allBlocks: plannedBlocks,
          startFrom: 0,
        );
        if (nextSlot != null) {
          plannedBlocks.add(task.copyWith(startMinute: nextSlot));
          futureMinute = nextSlot + task.duration;
        } else {
          // Extreme edge case: timeline completely full.
          // Force place at current bounds and let resolveConflicts push it if possible.
          final forcedTask = task.copyWith(
            startMinute: ensureInsideTimeline(futureMinute, task.duration),
          );
          final resolved = resolveConflicts(forcedTask, plannedBlocks);
          plannedBlocks.clear();
          plannedBlocks.addAll(resolved);
          futureMinute = forcedTask.startMinute + forcedTask.duration;
        }
      }
    }

    return plannedBlocks;
  }
}
