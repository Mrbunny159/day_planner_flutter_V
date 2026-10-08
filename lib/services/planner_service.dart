import 'package:day_planner/shared/models/planner_model.dart';
import 'package:day_planner/shared/models/task_model.dart';
import 'package:day_planner/shared/models/draft_models.dart';
import 'package:day_planner/core/scheduler/scheduler_engine.dart';
import 'package:day_planner/repositories/planner_repository.dart';
import 'package:day_planner/shared/models/enums.dart';
import 'package:uuid/uuid.dart';
import 'package:day_planner/core/logging/app_logger.dart';
import 'package:day_planner/core/database/exceptions.dart';

/// Service layer that orchestrates the pure SchedulerEngine logic
/// and the PlannerRepository persistence.
class PlannerService {
  final PlannerRepository _repository;

  PlannerService(this._repository);

  /// Loads the planner state from the repository for the given date.
  /// If no date is provided, it defaults to today's date.
  Future<Planner> loadPlanner({DateTime? date}) async {
    final targetDate = date ?? DateTime.now();
    return await _repository.loadPlanner(targetDate);
  }

  Future<void> _safeSave(Planner newPlanner) async {
    try {
      await _repository.savePlanner(newPlanner);
    } catch (e, st) {
      AppLogger.error('Failed to save planner state', e, st);
      throw SaveFailureException(newPlanner);
    }
  }

  /// Generates recurring tasks for a new day if they don't already exist.
  Future<Planner> rolloverToNewDay(DateTime newDate) async {
    final normalizedNewDate = DateTime(newDate.year, newDate.month, newDate.day);
    
    // Check if tasks already exist for this date (Idempotency)
    final existingTasks = await _repository.loadPlanner(normalizedNewDate);
    if (existingTasks.tasks.isNotEmpty) {
      return existingTasks; // Already generated or has manual tasks
    }

    // Find the most recent date with tasks
    final recentDate = await _repository.loadMostRecentTaskDate();
    if (recentDate == null) {
      return existingTasks; // No history to copy from
    }

    // Load tasks from the most recent date
    final recentPlanner = await _repository.loadPlanner(recentDate);
    final recurringTasks = recentPlanner.tasks.where((t) => t.recurring == Repeat.daily).toList();

    if (recurringTasks.isEmpty) {
      return existingTasks; // Nothing to carry over
    }

    // Clone tasks and pass through SchedulerEngine
    List<Task> currentTasks = [];
    final now = DateTime.now();
    const uuid = Uuid();

    for (final task in recurringTasks) {
      final newBlock = Task(
        id: uuid.v4(),
        name: task.name,
        startMinute: task.startMinute,
        duration: task.duration,
        type: task.type,
        recurring: task.recurring,
        colorTag: task.colorTag,
        date: normalizedNewDate,
        createdAt: now,
        updatedAt: now,
        completed: false, // Reset completion
      );

      currentTasks = SchedulerEngine.validateAndApplyPlacement(newBlock, currentTasks);
    }

    final newPlanner = existingTasks.copyWith(
      tasks: currentTasks,
      lastUpdated: now,
    );

    await _safeSave(newPlanner);
    return await _repository.loadPlanner(normalizedNewDate);
  }

  /// Restores an entire planner state directly (used for Undo functionality).
  Future<Planner> restorePlannerState(Planner restoredState) async {
    await _safeSave(restoredState);
    return await _repository.loadPlanner(restoredState.date);
  }

  /// Adds a new block (task or break), finding the next free slot if needed,
  /// resolving conflicts, and saving to the database.
  Future<Planner> addBlock(Planner currentPlanner, BlockDraft draft) async {
    final newBlock = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: draft.name,
      // Task model doesn't have description in the current implementation, ignoring it.
      startMinute: draft.startMinute,
      duration: draft.duration,
      type: draft.type,
      recurring: draft.recurring,
      colorTag: draft.colorTag,
      date: currentPlanner.date,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final updatedTasks = SchedulerEngine.validateAndApplyPlacement(
      newBlock,
      currentPlanner.tasks,
    );

    final newPlanner = currentPlanner.copyWith(
      tasks: updatedTasks,
      lastUpdated: DateTime.now(),
    );

    await _safeSave(newPlanner);
    return await _repository.loadPlanner(currentPlanner.date); // Return fully re-calculated planner
  }

  /// Edits an existing block, resolving conflicts if it moved or resized,
  /// and saves to the database.
  Future<Planner> editBlock(Planner currentPlanner, BlockDraft draft) async {
    if (draft.id == null) return currentPlanner;

    final existingBlockIndex = currentPlanner.tasks.indexWhere(
      (t) => t.id == draft.id,
    );
    if (existingBlockIndex == -1) return currentPlanner;

    final existingBlock = currentPlanner.tasks[existingBlockIndex];

    final updatedBlock = existingBlock.copyWith(
      name: draft.name,
      startMinute: draft.startMinute,
      duration: draft.duration,
      type: draft.type,
      recurring: draft.recurring,
      colorTag: draft.colorTag,
      date: currentPlanner.date,
      updatedAt: DateTime.now(),
    );

    // We treat edit the same as placement if bounds changed.
    final updatedTasks = SchedulerEngine.validateAndApplyPlacement(
      updatedBlock,
      List<Task>.from(currentPlanner.tasks)
        ..removeWhere((t) => t.id == updatedBlock.id), // Remove old version
    );

    final newPlanner = currentPlanner.copyWith(
      tasks: updatedTasks,
      lastUpdated: DateTime.now(),
    );

    await _safeSave(newPlanner);
    return await _repository.loadPlanner(currentPlanner.date);
  }

  /// Moves a block to a new start minute.
  Future<Planner> moveBlock(
    Planner currentPlanner,
    String blockId,
    int newStartMinute,
  ) async {
    final block = currentPlanner.tasks.firstWhere((t) => t.id == blockId);
    final draft = _taskToDraft(block).copyWith(startMinute: newStartMinute);
    return await editBlock(currentPlanner, draft);
  }

  /// Resizes a block.
  Future<Planner> resizeBlock(
    Planner currentPlanner,
    String blockId,
    int newDuration,
  ) async {
    final block = currentPlanner.tasks.firstWhere((t) => t.id == blockId);
    final draft = _taskToDraft(block).copyWith(duration: newDuration);
    return await editBlock(currentPlanner, draft);
  }

  BlockDraft _taskToDraft(Task t) {
    return BlockDraft(
      id: t.id,
      name: t.name,
      type: t.type,
      startMinute: t.startMinute,
      duration: t.duration,
      colorTag: t.colorTag,
      recurring: t.recurring,
    );
  }

  /// Deletes a block by its ID.
  Future<Planner> deleteBlock(Planner currentPlanner, String blockId) async {
    final updatedTasks = currentPlanner.tasks
        .where((t) => t.id != blockId)
        .toList();
    final newPlanner = currentPlanner.copyWith(
      tasks: updatedTasks,
      lastUpdated: DateTime.now(),
    );
    await _safeSave(newPlanner);
    return await _repository.loadPlanner(currentPlanner.date);
  }

  /// Deletes all completed tasks.
  Future<Planner> deleteAllCompleted(Planner currentPlanner) async {
    final updatedTasks = currentPlanner.tasks
        .where((t) => !t.completed)
        .toList();
    final newPlanner = currentPlanner.copyWith(
      tasks: updatedTasks,
      lastUpdated: DateTime.now(),
    );
    await _safeSave(newPlanner);
    return await _repository.loadPlanner(currentPlanner.date);
  }

  /// Toggles the completion status of a task.
  Future<Planner> toggleCompletion(
    Planner currentPlanner,
    String blockId,
  ) async {
    final updatedTasks = currentPlanner.tasks.map((t) {
      if (t.id == blockId) {
        return t.copyWith(completed: !t.completed);
      }
      return t;
    }).toList();

    final newPlanner = currentPlanner.copyWith(
      tasks: updatedTasks,
      lastUpdated: DateTime.now(),
    );

    await _safeSave(newPlanner);
    return await _repository.loadPlanner(currentPlanner.date);
  }

  /// Executes the auto-planner logic to organize incomplete tasks.
  Future<Planner> autoPlan(Planner currentPlanner) async {
    final plannedTasks = SchedulerEngine.autoPlan(currentPlanner.tasks);

    final newPlanner = currentPlanner.copyWith(
      tasks: plannedTasks,
      lastUpdated: DateTime.now(),
    );

    await _safeSave(newPlanner);
    return await _repository.loadPlanner(currentPlanner.date);
  }

  /// Updates the planner settings.
  Future<Planner> updateSettings(
    Planner currentPlanner,
    SettingsDraft draft,
  ) async {
    final newSettings = currentPlanner.settings.copyWith(
      dayStartMinute: draft.dayStartMinute,
      dayEndMinute: draft.dayEndMinute,
    );

    final newPlanner = currentPlanner.copyWith(
      settings: newSettings,
      lastUpdated: DateTime.now(),
    );
    await _safeSave(newPlanner);
    return await _repository.loadPlanner(currentPlanner.date);
  }

  /// Clears all tasks (leaves settings intact).
  Future<Planner> clearAll(Planner currentPlanner) async {
    final newPlanner = currentPlanner.copyWith(
      tasks: [],
      lastUpdated: DateTime.now(),
    );
    await _safeSave(newPlanner);
    return await _repository.loadPlanner(currentPlanner.date);
  }
}
