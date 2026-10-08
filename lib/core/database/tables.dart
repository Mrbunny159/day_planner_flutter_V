import 'package:drift/drift.dart';

@DataClassName('TaskEntity')
class Tasks extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  IntColumn get startMinute => integer()();
  IntColumn get duration => integer()();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();

  // Enums and Custom Types are stored as Text/Int
  TextColumn get type => text()();
  TextColumn get recurring => text()();
  TextColumn get colorTag => text()();

  DateTimeColumn get date => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SettingsEntity')
class Settings extends Table {
  IntColumn get id => integer().clientDefault(() => 1)();

  TextColumn get theme => text().withDefault(const Constant('Default'))();

  // Storing RGB lists as JSON strings
  TextColumn get taskColor => text()();
  TextColumn get taskBorderColor => text()();
  TextColumn get breakColor => text()();
  TextColumn get breakBorderColor => text()();

  IntColumn get dayStartMinute => integer()();
  IntColumn get dayEndMinute => integer()();

  RealColumn get timeFontSize => real()();
  BoolColumn get timeFontBold => boolean()();
  BoolColumn get use24HourFormat => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
