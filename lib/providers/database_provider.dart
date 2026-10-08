import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:day_planner/core/database/database.dart';
import 'package:day_planner/repositories/task_repository.dart';
import 'package:day_planner/repositories/settings_repository.dart';
import 'package:day_planner/repositories/planner_repository.dart';
import 'package:day_planner/services/planner_service.dart';

/// Singleton provider for the Drift database.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

/// Singleton provider for the TaskRepository.
final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepository(ref.watch(databaseProvider));
});

/// Singleton provider for the SettingsRepository.
final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepository(ref.watch(databaseProvider));
});

/// Singleton provider for the PlannerRepository.
final plannerRepositoryProvider = Provider<PlannerRepository>((ref) {
  return PlannerRepository(
    ref.watch(taskRepositoryProvider),
    ref.watch(settingsRepositoryProvider),
  );
});

/// Singleton provider for the pure PlannerService.
final plannerServiceProvider = Provider<PlannerService>((ref) {
  return PlannerService(ref.watch(plannerRepositoryProvider));
});
