import 'package:day_planner/shared/models/planner_model.dart';
import 'package:day_planner/shared/models/summary_model.dart';
import 'package:day_planner/shared/models/enums.dart';
import 'package:day_planner/repositories/task_repository.dart';
import 'package:day_planner/repositories/settings_repository.dart';

/// Aggregates settings and tasks into the single Planner domain root.
class PlannerRepository {
  final TaskRepository _taskRepository;
  final SettingsRepository _settingsRepository;

  PlannerRepository(this._taskRepository, this._settingsRepository);

  /// Loads the entire planner state for a specific date.
  Future<Planner> loadPlanner(DateTime date) async {
    final settings = await _settingsRepository.loadSettings();
    final tasks = await _taskRepository.loadTasksForDate(date);

    // Summary is computed on the fly, not stored
    int completedMins = 0;
    int breakMins = 0;

    for (final task in tasks) {
      if (task.type == BlockType.breakBlock) {
        breakMins += task.duration;
      } else if (task.completed) {
        completedMins += task.duration;
      }
    }

    final totalDay = (settings.dayEndMinute - settings.dayStartMinute).clamp(
      1,
      1440,
    );
    final plannedTaskMins = tasks
        .where((t) => t.type == BlockType.task)
        .fold<int>(0, (sum, t) => sum + t.duration);
    final freeMins = (totalDay - plannedTaskMins - breakMins).clamp(0, 1440);

    final summary = Summary(
      completedMinutes: completedMins,
      breakMinutes: breakMins,
      freeMinutes: freeMins,
    );

    return Planner(
      id: 'singleton_planner',
      date: date,
      tasks: tasks,
      settings: settings,
      summary: summary,
      lastUpdated: DateTime.now(),
    );
  }

  /// Full save of the planner (tasks and settings).
  Future<void> savePlanner(Planner planner) async {
    await _settingsRepository.saveSettings(planner.settings);
    // Overwrite tasks for this specific date
    await _taskRepository.clearTasksForDate(planner.date);
    await _taskRepository.saveTasks(planner.tasks);
  }

  /// Clears tasks for a specific date. Settings are kept.
  Future<void> clearPlannerTasks(DateTime date) async {
    await _taskRepository.clearTasksForDate(date);
  }

  /// Loads the most recent date in the database that has tasks.
  Future<DateTime?> loadMostRecentTaskDate() async {
    return await _taskRepository.loadMostRecentTaskDate();
  }
}
