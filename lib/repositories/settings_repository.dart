import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:day_planner/shared/models/planner_settings_model.dart';
import 'package:day_planner/core/database/database.dart';
import 'package:day_planner/core/logging/app_logger.dart';
import 'package:day_planner/core/database/exceptions.dart';

class SettingsRepository {
  final AppDatabase _db;

  SettingsRepository(this._db);

  /// Loads the planner settings from the database.
  /// The database migrations guarantee id=1 exists.
  Future<PlannerSettings> loadSettings() async {
    try {
      final entity = await (_db.select(
        _db.settings,
      )..where((s) => s.id.equals(1))).getSingle();

      return PlannerSettings(
        theme: entity.theme,
        taskColor: List<int>.from(jsonDecode(entity.taskColor)),
        taskBorderColor: List<int>.from(jsonDecode(entity.taskBorderColor)),
        breakColor: List<int>.from(jsonDecode(entity.breakColor)),
        breakBorderColor: List<int>.from(jsonDecode(entity.breakBorderColor)),
        dayStartMinute: entity.dayStartMinute,
        dayEndMinute: entity.dayEndMinute,
        timeFontSize: entity.timeFontSize,
        timeFontBold: entity.timeFontBold,
        use24HourFormat: entity.use24HourFormat,
      );
    } catch (e, st) {
      final errString = e.toString().toLowerCase();
      if (errString.contains('corrupt') || errString.contains('malformed') || errString.contains('not a database')) {
        AppLogger.error('Database corruption detected in SettingsRepository', e, st);
        throw DatabaseCorruptException();
      }

      AppLogger.error('Failed to load or parse settings from database. Self-healing...', e, st);
      const defaultSettings = PlannerSettings();
      // Fire-and-forget self heal
      saveSettings(defaultSettings).catchError((err) {
        AppLogger.error('Settings self-heal failed', err);
      });
      return defaultSettings;
    }
  }

  /// Saves the planner settings to the database.
  Future<void> saveSettings(PlannerSettings settings) async {
    final companion = SettingsCompanion(
      id: const Value(1),
      theme: Value(settings.theme),
      taskColor: Value(jsonEncode(settings.taskColor)),
      taskBorderColor: Value(jsonEncode(settings.taskBorderColor)),
      breakColor: Value(jsonEncode(settings.breakColor)),
      breakBorderColor: Value(jsonEncode(settings.breakBorderColor)),
      dayStartMinute: Value(settings.dayStartMinute),
      dayEndMinute: Value(settings.dayEndMinute),
      timeFontSize: Value(settings.timeFontSize),
      timeFontBold: Value(settings.timeFontBold),
      use24HourFormat: Value(settings.use24HourFormat),
    );

    await _db.into(_db.settings).insert(companion, mode: InsertMode.insertOrReplace);
  }
}
