import 'package:drift/drift.dart';
import 'package:day_planner/core/database/connection/database_connection.dart';
import 'package:day_planner/core/database/tables.dart';
import 'package:day_planner/core/logging/app_logger.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Tasks, Settings])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        // Insert default settings
        await into(settings).insert(
          const SettingsCompanion(
            id: Value(1),
            theme: Value('Default'),
            taskColor: Value('[60, 100, 200, 180]'),
            taskBorderColor: Value('[100, 150, 220]'),
            breakColor: Value('[60, 120, 80, 180]'),
            breakBorderColor: Value('[100, 200, 120]'),
            dayStartMinute: Value(540),
            dayEndMinute: Value(1080),
            timeFontSize: Value(10.0),
            timeFontBold: Value(true),
            use24HourFormat: Value(false),
          ),
        );
      },
      onUpgrade: (Migrator m, int from, int to) async {
        try {
          if (from < 2) {
            await m.addColumn(settings, settings.use24HourFormat);
          }
          if (from < 3) {
            await m.addColumn(tasks, tasks.date);
            
            // Fallback to today for existing tasks
            final now = DateTime.now();
            final today = DateTime(now.year, now.month, now.day);
            await customStatement(
              'UPDATE tasks SET date = ? WHERE date IS NULL',
              [today.millisecondsSinceEpoch ~/ 1000],
            );
          }
        } catch (e, st) {
          AppLogger.error('Schema migration failed. Recovering by resetting DB.', e, st);
          // Drop tables and recreate them if migration catastrophically fails
          for (final table in allTables) {
            await m.deleteTable(table.actualTableName);
          }
          await m.createAll();
        }
      },
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}

