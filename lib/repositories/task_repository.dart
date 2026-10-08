import 'package:drift/drift.dart';
import 'package:day_planner/shared/models/task_model.dart';
import 'package:day_planner/shared/models/enums.dart';
import 'package:day_planner/core/database/database.dart';
import 'package:day_planner/core/logging/app_logger.dart';
import 'package:day_planner/core/database/exceptions.dart';

class TaskRepository {
  final AppDatabase _db;

  TaskRepository(this._db);

  /// Maps a Drift `TaskEntity` to a domain `Task`.
  Task _mapToDomain(TaskEntity entity) {
    return Task(
      id: entity.id,
      name: entity.name,
      startMinute: entity.startMinute,
      duration: entity.duration,
      completed: entity.completed,
      type: BlockType.fromJson(entity.type),
      recurring: Repeat.fromJson(entity.recurring),
      colorTag: ColorTag.fromJson(entity.colorTag),
      date: entity.date,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// Maps a domain `Task` to a Drift `TasksCompanion`.
  TasksCompanion _mapToCompanion(Task task) {
    return TasksCompanion(
      id: Value(task.id),
      name: Value(task.name),
      startMinute: Value(task.startMinute),
      duration: Value(task.duration),
      completed: Value(task.completed),
      type: Value(task.type.toJson()),
      recurring: Value(task.recurring.toJson()),
      colorTag: Value(task.colorTag.toJson()),
      date: Value(task.date),
      createdAt: Value(task.createdAt),
      updatedAt: Value(task.updatedAt),
    );
  }

  /// Loads tasks (including breaks) for a specific date.
  Future<List<Task>> loadTasksForDate(DateTime date) async {
    try {
      final normalizedDate = DateTime(date.year, date.month, date.day);
      final entities = await (_db.select(_db.tasks)
            ..where((t) => t.date.equals(normalizedDate)))
          .get();
      return entities.map(_mapToDomain).toList();
    } catch (e, st) {
      final errString = e.toString().toLowerCase();
      if (errString.contains('corrupt') || errString.contains('malformed') || errString.contains('not a database')) {
        AppLogger.error('Database corruption detected in TaskRepository', e, st);
        throw DatabaseCorruptException();
      }
      
      AppLogger.error('Failed to load or parse tasks for date $date', e, st);
      return [];
    }
  }

  /// Loads the most recent date in the database that has tasks.
  Future<DateTime?> loadMostRecentTaskDate() async {
    final query = _db.select(_db.tasks)
      ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)])
      ..limit(1);
    final result = await query.getSingleOrNull();
    return result?.date;
  }

  /// Saves or replaces a task.
  Future<void> saveTask(Task task) async {
    await _db.into(_db.tasks).insertOnConflictUpdate(_mapToCompanion(task));
  }

  /// Saves multiple tasks in a single transaction.
  Future<void> saveTasks(List<Task> tasks) async {
    await _db.transaction(() async {
      for (final task in tasks) {
        await _db.into(_db.tasks).insertOnConflictUpdate(_mapToCompanion(task));
      }
    });
  }

  /// Deletes a task by ID.
  Future<void> deleteTask(String id) async {
    await (_db.delete(_db.tasks)..where((t) => t.id.equals(id))).go();
  }

  /// Deletes multiple tasks by IDs.
  Future<void> deleteTasks(List<String> ids) async {
    if (ids.isEmpty) return;
    await (_db.delete(_db.tasks)..where((t) => t.id.isIn(ids))).go();
  }

  /// Deletes all tasks from the database for a specific date.
  Future<void> clearTasksForDate(DateTime date) async {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    await (_db.delete(_db.tasks)..where((t) => t.date.equals(normalizedDate))).go();
  }
}
