// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TasksTable extends Tasks with TableInfo<$TasksTable, TaskEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startMinuteMeta = const VerificationMeta(
    'startMinute',
  );
  @override
  late final GeneratedColumn<int> startMinute = GeneratedColumn<int>(
    'start_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMeta = const VerificationMeta(
    'duration',
  );
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
    'duration',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recurringMeta = const VerificationMeta(
    'recurring',
  );
  @override
  late final GeneratedColumn<String> recurring = GeneratedColumn<String>(
    'recurring',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorTagMeta = const VerificationMeta(
    'colorTag',
  );
  @override
  late final GeneratedColumn<String> colorTag = GeneratedColumn<String>(
    'color_tag',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    startMinute,
    duration,
    completed,
    type,
    recurring,
    colorTag,
    date,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<TaskEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('start_minute')) {
      context.handle(
        _startMinuteMeta,
        startMinute.isAcceptableOrUnknown(
          data['start_minute']!,
          _startMinuteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startMinuteMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(
        _durationMeta,
        duration.isAcceptableOrUnknown(data['duration']!, _durationMeta),
      );
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('recurring')) {
      context.handle(
        _recurringMeta,
        recurring.isAcceptableOrUnknown(data['recurring']!, _recurringMeta),
      );
    } else if (isInserting) {
      context.missing(_recurringMeta);
    }
    if (data.containsKey('color_tag')) {
      context.handle(
        _colorTagMeta,
        colorTag.isAcceptableOrUnknown(data['color_tag']!, _colorTagMeta),
      );
    } else if (isInserting) {
      context.missing(_colorTagMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TaskEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      startMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_minute'],
      )!,
      duration: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration'],
      )!,
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      recurring: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recurring'],
      )!,
      colorTag: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_tag'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class TaskEntity extends DataClass implements Insertable<TaskEntity> {
  final String id;
  final String name;
  final int startMinute;
  final int duration;
  final bool completed;
  final String type;
  final String recurring;
  final String colorTag;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;
  const TaskEntity({
    required this.id,
    required this.name,
    required this.startMinute,
    required this.duration,
    required this.completed,
    required this.type,
    required this.recurring,
    required this.colorTag,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['start_minute'] = Variable<int>(startMinute);
    map['duration'] = Variable<int>(duration);
    map['completed'] = Variable<bool>(completed);
    map['type'] = Variable<String>(type);
    map['recurring'] = Variable<String>(recurring);
    map['color_tag'] = Variable<String>(colorTag);
    map['date'] = Variable<DateTime>(date);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      name: Value(name),
      startMinute: Value(startMinute),
      duration: Value(duration),
      completed: Value(completed),
      type: Value(type),
      recurring: Value(recurring),
      colorTag: Value(colorTag),
      date: Value(date),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory TaskEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskEntity(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      startMinute: serializer.fromJson<int>(json['startMinute']),
      duration: serializer.fromJson<int>(json['duration']),
      completed: serializer.fromJson<bool>(json['completed']),
      type: serializer.fromJson<String>(json['type']),
      recurring: serializer.fromJson<String>(json['recurring']),
      colorTag: serializer.fromJson<String>(json['colorTag']),
      date: serializer.fromJson<DateTime>(json['date']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'startMinute': serializer.toJson<int>(startMinute),
      'duration': serializer.toJson<int>(duration),
      'completed': serializer.toJson<bool>(completed),
      'type': serializer.toJson<String>(type),
      'recurring': serializer.toJson<String>(recurring),
      'colorTag': serializer.toJson<String>(colorTag),
      'date': serializer.toJson<DateTime>(date),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TaskEntity copyWith({
    String? id,
    String? name,
    int? startMinute,
    int? duration,
    bool? completed,
    String? type,
    String? recurring,
    String? colorTag,
    DateTime? date,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => TaskEntity(
    id: id ?? this.id,
    name: name ?? this.name,
    startMinute: startMinute ?? this.startMinute,
    duration: duration ?? this.duration,
    completed: completed ?? this.completed,
    type: type ?? this.type,
    recurring: recurring ?? this.recurring,
    colorTag: colorTag ?? this.colorTag,
    date: date ?? this.date,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  TaskEntity copyWithCompanion(TasksCompanion data) {
    return TaskEntity(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      startMinute: data.startMinute.present
          ? data.startMinute.value
          : this.startMinute,
      duration: data.duration.present ? data.duration.value : this.duration,
      completed: data.completed.present ? data.completed.value : this.completed,
      type: data.type.present ? data.type.value : this.type,
      recurring: data.recurring.present ? data.recurring.value : this.recurring,
      colorTag: data.colorTag.present ? data.colorTag.value : this.colorTag,
      date: data.date.present ? data.date.value : this.date,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskEntity(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('startMinute: $startMinute, ')
          ..write('duration: $duration, ')
          ..write('completed: $completed, ')
          ..write('type: $type, ')
          ..write('recurring: $recurring, ')
          ..write('colorTag: $colorTag, ')
          ..write('date: $date, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    startMinute,
    duration,
    completed,
    type,
    recurring,
    colorTag,
    date,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskEntity &&
          other.id == this.id &&
          other.name == this.name &&
          other.startMinute == this.startMinute &&
          other.duration == this.duration &&
          other.completed == this.completed &&
          other.type == this.type &&
          other.recurring == this.recurring &&
          other.colorTag == this.colorTag &&
          other.date == this.date &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TasksCompanion extends UpdateCompanion<TaskEntity> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> startMinute;
  final Value<int> duration;
  final Value<bool> completed;
  final Value<String> type;
  final Value<String> recurring;
  final Value<String> colorTag;
  final Value<DateTime> date;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.startMinute = const Value.absent(),
    this.duration = const Value.absent(),
    this.completed = const Value.absent(),
    this.type = const Value.absent(),
    this.recurring = const Value.absent(),
    this.colorTag = const Value.absent(),
    this.date = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TasksCompanion.insert({
    required String id,
    required String name,
    required int startMinute,
    required int duration,
    this.completed = const Value.absent(),
    required String type,
    required String recurring,
    required String colorTag,
    required DateTime date,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       startMinute = Value(startMinute),
       duration = Value(duration),
       type = Value(type),
       recurring = Value(recurring),
       colorTag = Value(colorTag),
       date = Value(date),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<TaskEntity> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? startMinute,
    Expression<int>? duration,
    Expression<bool>? completed,
    Expression<String>? type,
    Expression<String>? recurring,
    Expression<String>? colorTag,
    Expression<DateTime>? date,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (startMinute != null) 'start_minute': startMinute,
      if (duration != null) 'duration': duration,
      if (completed != null) 'completed': completed,
      if (type != null) 'type': type,
      if (recurring != null) 'recurring': recurring,
      if (colorTag != null) 'color_tag': colorTag,
      if (date != null) 'date': date,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TasksCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? startMinute,
    Value<int>? duration,
    Value<bool>? completed,
    Value<String>? type,
    Value<String>? recurring,
    Value<String>? colorTag,
    Value<DateTime>? date,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return TasksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      startMinute: startMinute ?? this.startMinute,
      duration: duration ?? this.duration,
      completed: completed ?? this.completed,
      type: type ?? this.type,
      recurring: recurring ?? this.recurring,
      colorTag: colorTag ?? this.colorTag,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (startMinute.present) {
      map['start_minute'] = Variable<int>(startMinute.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (recurring.present) {
      map['recurring'] = Variable<String>(recurring.value);
    }
    if (colorTag.present) {
      map['color_tag'] = Variable<String>(colorTag.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('startMinute: $startMinute, ')
          ..write('duration: $duration, ')
          ..write('completed: $completed, ')
          ..write('type: $type, ')
          ..write('recurring: $recurring, ')
          ..write('colorTag: $colorTag, ')
          ..write('date: $date, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings
    with TableInfo<$SettingsTable, SettingsEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    clientDefault: () => 1,
  );
  static const VerificationMeta _themeMeta = const VerificationMeta('theme');
  @override
  late final GeneratedColumn<String> theme = GeneratedColumn<String>(
    'theme',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Default'),
  );
  static const VerificationMeta _taskColorMeta = const VerificationMeta(
    'taskColor',
  );
  @override
  late final GeneratedColumn<String> taskColor = GeneratedColumn<String>(
    'task_color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taskBorderColorMeta = const VerificationMeta(
    'taskBorderColor',
  );
  @override
  late final GeneratedColumn<String> taskBorderColor = GeneratedColumn<String>(
    'task_border_color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _breakColorMeta = const VerificationMeta(
    'breakColor',
  );
  @override
  late final GeneratedColumn<String> breakColor = GeneratedColumn<String>(
    'break_color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _breakBorderColorMeta = const VerificationMeta(
    'breakBorderColor',
  );
  @override
  late final GeneratedColumn<String> breakBorderColor = GeneratedColumn<String>(
    'break_border_color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dayStartMinuteMeta = const VerificationMeta(
    'dayStartMinute',
  );
  @override
  late final GeneratedColumn<int> dayStartMinute = GeneratedColumn<int>(
    'day_start_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dayEndMinuteMeta = const VerificationMeta(
    'dayEndMinute',
  );
  @override
  late final GeneratedColumn<int> dayEndMinute = GeneratedColumn<int>(
    'day_end_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeFontSizeMeta = const VerificationMeta(
    'timeFontSize',
  );
  @override
  late final GeneratedColumn<double> timeFontSize = GeneratedColumn<double>(
    'time_font_size',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeFontBoldMeta = const VerificationMeta(
    'timeFontBold',
  );
  @override
  late final GeneratedColumn<bool> timeFontBold = GeneratedColumn<bool>(
    'time_font_bold',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("time_font_bold" IN (0, 1))',
    ),
  );
  static const VerificationMeta _use24HourFormatMeta = const VerificationMeta(
    'use24HourFormat',
  );
  @override
  late final GeneratedColumn<bool> use24HourFormat = GeneratedColumn<bool>(
    'use24_hour_format',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("use24_hour_format" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    theme,
    taskColor,
    taskBorderColor,
    breakColor,
    breakBorderColor,
    dayStartMinute,
    dayEndMinute,
    timeFontSize,
    timeFontBold,
    use24HourFormat,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingsEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('theme')) {
      context.handle(
        _themeMeta,
        theme.isAcceptableOrUnknown(data['theme']!, _themeMeta),
      );
    }
    if (data.containsKey('task_color')) {
      context.handle(
        _taskColorMeta,
        taskColor.isAcceptableOrUnknown(data['task_color']!, _taskColorMeta),
      );
    } else if (isInserting) {
      context.missing(_taskColorMeta);
    }
    if (data.containsKey('task_border_color')) {
      context.handle(
        _taskBorderColorMeta,
        taskBorderColor.isAcceptableOrUnknown(
          data['task_border_color']!,
          _taskBorderColorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_taskBorderColorMeta);
    }
    if (data.containsKey('break_color')) {
      context.handle(
        _breakColorMeta,
        breakColor.isAcceptableOrUnknown(data['break_color']!, _breakColorMeta),
      );
    } else if (isInserting) {
      context.missing(_breakColorMeta);
    }
    if (data.containsKey('break_border_color')) {
      context.handle(
        _breakBorderColorMeta,
        breakBorderColor.isAcceptableOrUnknown(
          data['break_border_color']!,
          _breakBorderColorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_breakBorderColorMeta);
    }
    if (data.containsKey('day_start_minute')) {
      context.handle(
        _dayStartMinuteMeta,
        dayStartMinute.isAcceptableOrUnknown(
          data['day_start_minute']!,
          _dayStartMinuteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dayStartMinuteMeta);
    }
    if (data.containsKey('day_end_minute')) {
      context.handle(
        _dayEndMinuteMeta,
        dayEndMinute.isAcceptableOrUnknown(
          data['day_end_minute']!,
          _dayEndMinuteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dayEndMinuteMeta);
    }
    if (data.containsKey('time_font_size')) {
      context.handle(
        _timeFontSizeMeta,
        timeFontSize.isAcceptableOrUnknown(
          data['time_font_size']!,
          _timeFontSizeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timeFontSizeMeta);
    }
    if (data.containsKey('time_font_bold')) {
      context.handle(
        _timeFontBoldMeta,
        timeFontBold.isAcceptableOrUnknown(
          data['time_font_bold']!,
          _timeFontBoldMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_timeFontBoldMeta);
    }
    if (data.containsKey('use24_hour_format')) {
      context.handle(
        _use24HourFormatMeta,
        use24HourFormat.isAcceptableOrUnknown(
          data['use24_hour_format']!,
          _use24HourFormatMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SettingsEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      theme: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme'],
      )!,
      taskColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_color'],
      )!,
      taskBorderColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_border_color'],
      )!,
      breakColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}break_color'],
      )!,
      breakBorderColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}break_border_color'],
      )!,
      dayStartMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_start_minute'],
      )!,
      dayEndMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_end_minute'],
      )!,
      timeFontSize: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}time_font_size'],
      )!,
      timeFontBold: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}time_font_bold'],
      )!,
      use24HourFormat: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}use24_hour_format'],
      )!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class SettingsEntity extends DataClass implements Insertable<SettingsEntity> {
  final int id;
  final String theme;
  final String taskColor;
  final String taskBorderColor;
  final String breakColor;
  final String breakBorderColor;
  final int dayStartMinute;
  final int dayEndMinute;
  final double timeFontSize;
  final bool timeFontBold;
  final bool use24HourFormat;
  const SettingsEntity({
    required this.id,
    required this.theme,
    required this.taskColor,
    required this.taskBorderColor,
    required this.breakColor,
    required this.breakBorderColor,
    required this.dayStartMinute,
    required this.dayEndMinute,
    required this.timeFontSize,
    required this.timeFontBold,
    required this.use24HourFormat,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['theme'] = Variable<String>(theme);
    map['task_color'] = Variable<String>(taskColor);
    map['task_border_color'] = Variable<String>(taskBorderColor);
    map['break_color'] = Variable<String>(breakColor);
    map['break_border_color'] = Variable<String>(breakBorderColor);
    map['day_start_minute'] = Variable<int>(dayStartMinute);
    map['day_end_minute'] = Variable<int>(dayEndMinute);
    map['time_font_size'] = Variable<double>(timeFontSize);
    map['time_font_bold'] = Variable<bool>(timeFontBold);
    map['use24_hour_format'] = Variable<bool>(use24HourFormat);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      id: Value(id),
      theme: Value(theme),
      taskColor: Value(taskColor),
      taskBorderColor: Value(taskBorderColor),
      breakColor: Value(breakColor),
      breakBorderColor: Value(breakBorderColor),
      dayStartMinute: Value(dayStartMinute),
      dayEndMinute: Value(dayEndMinute),
      timeFontSize: Value(timeFontSize),
      timeFontBold: Value(timeFontBold),
      use24HourFormat: Value(use24HourFormat),
    );
  }

  factory SettingsEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingsEntity(
      id: serializer.fromJson<int>(json['id']),
      theme: serializer.fromJson<String>(json['theme']),
      taskColor: serializer.fromJson<String>(json['taskColor']),
      taskBorderColor: serializer.fromJson<String>(json['taskBorderColor']),
      breakColor: serializer.fromJson<String>(json['breakColor']),
      breakBorderColor: serializer.fromJson<String>(json['breakBorderColor']),
      dayStartMinute: serializer.fromJson<int>(json['dayStartMinute']),
      dayEndMinute: serializer.fromJson<int>(json['dayEndMinute']),
      timeFontSize: serializer.fromJson<double>(json['timeFontSize']),
      timeFontBold: serializer.fromJson<bool>(json['timeFontBold']),
      use24HourFormat: serializer.fromJson<bool>(json['use24HourFormat']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'theme': serializer.toJson<String>(theme),
      'taskColor': serializer.toJson<String>(taskColor),
      'taskBorderColor': serializer.toJson<String>(taskBorderColor),
      'breakColor': serializer.toJson<String>(breakColor),
      'breakBorderColor': serializer.toJson<String>(breakBorderColor),
      'dayStartMinute': serializer.toJson<int>(dayStartMinute),
      'dayEndMinute': serializer.toJson<int>(dayEndMinute),
      'timeFontSize': serializer.toJson<double>(timeFontSize),
      'timeFontBold': serializer.toJson<bool>(timeFontBold),
      'use24HourFormat': serializer.toJson<bool>(use24HourFormat),
    };
  }

  SettingsEntity copyWith({
    int? id,
    String? theme,
    String? taskColor,
    String? taskBorderColor,
    String? breakColor,
    String? breakBorderColor,
    int? dayStartMinute,
    int? dayEndMinute,
    double? timeFontSize,
    bool? timeFontBold,
    bool? use24HourFormat,
  }) => SettingsEntity(
    id: id ?? this.id,
    theme: theme ?? this.theme,
    taskColor: taskColor ?? this.taskColor,
    taskBorderColor: taskBorderColor ?? this.taskBorderColor,
    breakColor: breakColor ?? this.breakColor,
    breakBorderColor: breakBorderColor ?? this.breakBorderColor,
    dayStartMinute: dayStartMinute ?? this.dayStartMinute,
    dayEndMinute: dayEndMinute ?? this.dayEndMinute,
    timeFontSize: timeFontSize ?? this.timeFontSize,
    timeFontBold: timeFontBold ?? this.timeFontBold,
    use24HourFormat: use24HourFormat ?? this.use24HourFormat,
  );
  SettingsEntity copyWithCompanion(SettingsCompanion data) {
    return SettingsEntity(
      id: data.id.present ? data.id.value : this.id,
      theme: data.theme.present ? data.theme.value : this.theme,
      taskColor: data.taskColor.present ? data.taskColor.value : this.taskColor,
      taskBorderColor: data.taskBorderColor.present
          ? data.taskBorderColor.value
          : this.taskBorderColor,
      breakColor: data.breakColor.present
          ? data.breakColor.value
          : this.breakColor,
      breakBorderColor: data.breakBorderColor.present
          ? data.breakBorderColor.value
          : this.breakBorderColor,
      dayStartMinute: data.dayStartMinute.present
          ? data.dayStartMinute.value
          : this.dayStartMinute,
      dayEndMinute: data.dayEndMinute.present
          ? data.dayEndMinute.value
          : this.dayEndMinute,
      timeFontSize: data.timeFontSize.present
          ? data.timeFontSize.value
          : this.timeFontSize,
      timeFontBold: data.timeFontBold.present
          ? data.timeFontBold.value
          : this.timeFontBold,
      use24HourFormat: data.use24HourFormat.present
          ? data.use24HourFormat.value
          : this.use24HourFormat,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingsEntity(')
          ..write('id: $id, ')
          ..write('theme: $theme, ')
          ..write('taskColor: $taskColor, ')
          ..write('taskBorderColor: $taskBorderColor, ')
          ..write('breakColor: $breakColor, ')
          ..write('breakBorderColor: $breakBorderColor, ')
          ..write('dayStartMinute: $dayStartMinute, ')
          ..write('dayEndMinute: $dayEndMinute, ')
          ..write('timeFontSize: $timeFontSize, ')
          ..write('timeFontBold: $timeFontBold, ')
          ..write('use24HourFormat: $use24HourFormat')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    theme,
    taskColor,
    taskBorderColor,
    breakColor,
    breakBorderColor,
    dayStartMinute,
    dayEndMinute,
    timeFontSize,
    timeFontBold,
    use24HourFormat,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsEntity &&
          other.id == this.id &&
          other.theme == this.theme &&
          other.taskColor == this.taskColor &&
          other.taskBorderColor == this.taskBorderColor &&
          other.breakColor == this.breakColor &&
          other.breakBorderColor == this.breakBorderColor &&
          other.dayStartMinute == this.dayStartMinute &&
          other.dayEndMinute == this.dayEndMinute &&
          other.timeFontSize == this.timeFontSize &&
          other.timeFontBold == this.timeFontBold &&
          other.use24HourFormat == this.use24HourFormat);
}

class SettingsCompanion extends UpdateCompanion<SettingsEntity> {
  final Value<int> id;
  final Value<String> theme;
  final Value<String> taskColor;
  final Value<String> taskBorderColor;
  final Value<String> breakColor;
  final Value<String> breakBorderColor;
  final Value<int> dayStartMinute;
  final Value<int> dayEndMinute;
  final Value<double> timeFontSize;
  final Value<bool> timeFontBold;
  final Value<bool> use24HourFormat;
  const SettingsCompanion({
    this.id = const Value.absent(),
    this.theme = const Value.absent(),
    this.taskColor = const Value.absent(),
    this.taskBorderColor = const Value.absent(),
    this.breakColor = const Value.absent(),
    this.breakBorderColor = const Value.absent(),
    this.dayStartMinute = const Value.absent(),
    this.dayEndMinute = const Value.absent(),
    this.timeFontSize = const Value.absent(),
    this.timeFontBold = const Value.absent(),
    this.use24HourFormat = const Value.absent(),
  });
  SettingsCompanion.insert({
    this.id = const Value.absent(),
    this.theme = const Value.absent(),
    required String taskColor,
    required String taskBorderColor,
    required String breakColor,
    required String breakBorderColor,
    required int dayStartMinute,
    required int dayEndMinute,
    required double timeFontSize,
    required bool timeFontBold,
    this.use24HourFormat = const Value.absent(),
  }) : taskColor = Value(taskColor),
       taskBorderColor = Value(taskBorderColor),
       breakColor = Value(breakColor),
       breakBorderColor = Value(breakBorderColor),
       dayStartMinute = Value(dayStartMinute),
       dayEndMinute = Value(dayEndMinute),
       timeFontSize = Value(timeFontSize),
       timeFontBold = Value(timeFontBold);
  static Insertable<SettingsEntity> custom({
    Expression<int>? id,
    Expression<String>? theme,
    Expression<String>? taskColor,
    Expression<String>? taskBorderColor,
    Expression<String>? breakColor,
    Expression<String>? breakBorderColor,
    Expression<int>? dayStartMinute,
    Expression<int>? dayEndMinute,
    Expression<double>? timeFontSize,
    Expression<bool>? timeFontBold,
    Expression<bool>? use24HourFormat,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (theme != null) 'theme': theme,
      if (taskColor != null) 'task_color': taskColor,
      if (taskBorderColor != null) 'task_border_color': taskBorderColor,
      if (breakColor != null) 'break_color': breakColor,
      if (breakBorderColor != null) 'break_border_color': breakBorderColor,
      if (dayStartMinute != null) 'day_start_minute': dayStartMinute,
      if (dayEndMinute != null) 'day_end_minute': dayEndMinute,
      if (timeFontSize != null) 'time_font_size': timeFontSize,
      if (timeFontBold != null) 'time_font_bold': timeFontBold,
      if (use24HourFormat != null) 'use24_hour_format': use24HourFormat,
    });
  }

  SettingsCompanion copyWith({
    Value<int>? id,
    Value<String>? theme,
    Value<String>? taskColor,
    Value<String>? taskBorderColor,
    Value<String>? breakColor,
    Value<String>? breakBorderColor,
    Value<int>? dayStartMinute,
    Value<int>? dayEndMinute,
    Value<double>? timeFontSize,
    Value<bool>? timeFontBold,
    Value<bool>? use24HourFormat,
  }) {
    return SettingsCompanion(
      id: id ?? this.id,
      theme: theme ?? this.theme,
      taskColor: taskColor ?? this.taskColor,
      taskBorderColor: taskBorderColor ?? this.taskBorderColor,
      breakColor: breakColor ?? this.breakColor,
      breakBorderColor: breakBorderColor ?? this.breakBorderColor,
      dayStartMinute: dayStartMinute ?? this.dayStartMinute,
      dayEndMinute: dayEndMinute ?? this.dayEndMinute,
      timeFontSize: timeFontSize ?? this.timeFontSize,
      timeFontBold: timeFontBold ?? this.timeFontBold,
      use24HourFormat: use24HourFormat ?? this.use24HourFormat,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (theme.present) {
      map['theme'] = Variable<String>(theme.value);
    }
    if (taskColor.present) {
      map['task_color'] = Variable<String>(taskColor.value);
    }
    if (taskBorderColor.present) {
      map['task_border_color'] = Variable<String>(taskBorderColor.value);
    }
    if (breakColor.present) {
      map['break_color'] = Variable<String>(breakColor.value);
    }
    if (breakBorderColor.present) {
      map['break_border_color'] = Variable<String>(breakBorderColor.value);
    }
    if (dayStartMinute.present) {
      map['day_start_minute'] = Variable<int>(dayStartMinute.value);
    }
    if (dayEndMinute.present) {
      map['day_end_minute'] = Variable<int>(dayEndMinute.value);
    }
    if (timeFontSize.present) {
      map['time_font_size'] = Variable<double>(timeFontSize.value);
    }
    if (timeFontBold.present) {
      map['time_font_bold'] = Variable<bool>(timeFontBold.value);
    }
    if (use24HourFormat.present) {
      map['use24_hour_format'] = Variable<bool>(use24HourFormat.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('id: $id, ')
          ..write('theme: $theme, ')
          ..write('taskColor: $taskColor, ')
          ..write('taskBorderColor: $taskBorderColor, ')
          ..write('breakColor: $breakColor, ')
          ..write('breakBorderColor: $breakBorderColor, ')
          ..write('dayStartMinute: $dayStartMinute, ')
          ..write('dayEndMinute: $dayEndMinute, ')
          ..write('timeFontSize: $timeFontSize, ')
          ..write('timeFontBold: $timeFontBold, ')
          ..write('use24HourFormat: $use24HourFormat')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tasks, settings];
}

typedef $$TasksTableCreateCompanionBuilder =
    TasksCompanion Function({
      required String id,
      required String name,
      required int startMinute,
      required int duration,
      Value<bool> completed,
      required String type,
      required String recurring,
      required String colorTag,
      required DateTime date,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$TasksTableUpdateCompanionBuilder =
    TasksCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> startMinute,
      Value<int> duration,
      Value<bool> completed,
      Value<String> type,
      Value<String> recurring,
      Value<String> colorTag,
      Value<DateTime> date,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$TasksTableFilterComposer extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startMinute => $composableBuilder(
    column: $table.startMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recurring => $composableBuilder(
    column: $table.recurring,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorTag => $composableBuilder(
    column: $table.colorTag,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TasksTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startMinute => $composableBuilder(
    column: $table.startMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recurring => $composableBuilder(
    column: $table.recurring,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorTag => $composableBuilder(
    column: $table.colorTag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get startMinute => $composableBuilder(
    column: $table.startMinute,
    builder: (column) => column,
  );

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get recurring =>
      $composableBuilder(column: $table.recurring, builder: (column) => column);

  GeneratedColumn<String> get colorTag =>
      $composableBuilder(column: $table.colorTag, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$TasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TasksTable,
          TaskEntity,
          $$TasksTableFilterComposer,
          $$TasksTableOrderingComposer,
          $$TasksTableAnnotationComposer,
          $$TasksTableCreateCompanionBuilder,
          $$TasksTableUpdateCompanionBuilder,
          (TaskEntity, BaseReferences<_$AppDatabase, $TasksTable, TaskEntity>),
          TaskEntity,
          PrefetchHooks Function()
        > {
  $$TasksTableTableManager(_$AppDatabase db, $TasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> startMinute = const Value.absent(),
                Value<int> duration = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> recurring = const Value.absent(),
                Value<String> colorTag = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TasksCompanion(
                id: id,
                name: name,
                startMinute: startMinute,
                duration: duration,
                completed: completed,
                type: type,
                recurring: recurring,
                colorTag: colorTag,
                date: date,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required int startMinute,
                required int duration,
                Value<bool> completed = const Value.absent(),
                required String type,
                required String recurring,
                required String colorTag,
                required DateTime date,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => TasksCompanion.insert(
                id: id,
                name: name,
                startMinute: startMinute,
                duration: duration,
                completed: completed,
                type: type,
                recurring: recurring,
                colorTag: colorTag,
                date: date,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TasksTable,
      TaskEntity,
      $$TasksTableFilterComposer,
      $$TasksTableOrderingComposer,
      $$TasksTableAnnotationComposer,
      $$TasksTableCreateCompanionBuilder,
      $$TasksTableUpdateCompanionBuilder,
      (TaskEntity, BaseReferences<_$AppDatabase, $TasksTable, TaskEntity>),
      TaskEntity,
      PrefetchHooks Function()
    >;
typedef $$SettingsTableCreateCompanionBuilder =
    SettingsCompanion Function({
      Value<int> id,
      Value<String> theme,
      required String taskColor,
      required String taskBorderColor,
      required String breakColor,
      required String breakBorderColor,
      required int dayStartMinute,
      required int dayEndMinute,
      required double timeFontSize,
      required bool timeFontBold,
      Value<bool> use24HourFormat,
    });
typedef $$SettingsTableUpdateCompanionBuilder =
    SettingsCompanion Function({
      Value<int> id,
      Value<String> theme,
      Value<String> taskColor,
      Value<String> taskBorderColor,
      Value<String> breakColor,
      Value<String> breakBorderColor,
      Value<int> dayStartMinute,
      Value<int> dayEndMinute,
      Value<double> timeFontSize,
      Value<bool> timeFontBold,
      Value<bool> use24HourFormat,
    });

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get theme => $composableBuilder(
    column: $table.theme,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taskColor => $composableBuilder(
    column: $table.taskColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taskBorderColor => $composableBuilder(
    column: $table.taskBorderColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get breakColor => $composableBuilder(
    column: $table.breakColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get breakBorderColor => $composableBuilder(
    column: $table.breakBorderColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayStartMinute => $composableBuilder(
    column: $table.dayStartMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayEndMinute => $composableBuilder(
    column: $table.dayEndMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get timeFontSize => $composableBuilder(
    column: $table.timeFontSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get timeFontBold => $composableBuilder(
    column: $table.timeFontBold,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get use24HourFormat => $composableBuilder(
    column: $table.use24HourFormat,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get theme => $composableBuilder(
    column: $table.theme,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taskColor => $composableBuilder(
    column: $table.taskColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taskBorderColor => $composableBuilder(
    column: $table.taskBorderColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get breakColor => $composableBuilder(
    column: $table.breakColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get breakBorderColor => $composableBuilder(
    column: $table.breakBorderColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayStartMinute => $composableBuilder(
    column: $table.dayStartMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayEndMinute => $composableBuilder(
    column: $table.dayEndMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get timeFontSize => $composableBuilder(
    column: $table.timeFontSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get timeFontBold => $composableBuilder(
    column: $table.timeFontBold,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get use24HourFormat => $composableBuilder(
    column: $table.use24HourFormat,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get theme =>
      $composableBuilder(column: $table.theme, builder: (column) => column);

  GeneratedColumn<String> get taskColor =>
      $composableBuilder(column: $table.taskColor, builder: (column) => column);

  GeneratedColumn<String> get taskBorderColor => $composableBuilder(
    column: $table.taskBorderColor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get breakColor => $composableBuilder(
    column: $table.breakColor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get breakBorderColor => $composableBuilder(
    column: $table.breakBorderColor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dayStartMinute => $composableBuilder(
    column: $table.dayStartMinute,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dayEndMinute => $composableBuilder(
    column: $table.dayEndMinute,
    builder: (column) => column,
  );

  GeneratedColumn<double> get timeFontSize => $composableBuilder(
    column: $table.timeFontSize,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get timeFontBold => $composableBuilder(
    column: $table.timeFontBold,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get use24HourFormat => $composableBuilder(
    column: $table.use24HourFormat,
    builder: (column) => column,
  );
}

class $$SettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTable,
          SettingsEntity,
          $$SettingsTableFilterComposer,
          $$SettingsTableOrderingComposer,
          $$SettingsTableAnnotationComposer,
          $$SettingsTableCreateCompanionBuilder,
          $$SettingsTableUpdateCompanionBuilder,
          (
            SettingsEntity,
            BaseReferences<_$AppDatabase, $SettingsTable, SettingsEntity>,
          ),
          SettingsEntity,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> theme = const Value.absent(),
                Value<String> taskColor = const Value.absent(),
                Value<String> taskBorderColor = const Value.absent(),
                Value<String> breakColor = const Value.absent(),
                Value<String> breakBorderColor = const Value.absent(),
                Value<int> dayStartMinute = const Value.absent(),
                Value<int> dayEndMinute = const Value.absent(),
                Value<double> timeFontSize = const Value.absent(),
                Value<bool> timeFontBold = const Value.absent(),
                Value<bool> use24HourFormat = const Value.absent(),
              }) => SettingsCompanion(
                id: id,
                theme: theme,
                taskColor: taskColor,
                taskBorderColor: taskBorderColor,
                breakColor: breakColor,
                breakBorderColor: breakBorderColor,
                dayStartMinute: dayStartMinute,
                dayEndMinute: dayEndMinute,
                timeFontSize: timeFontSize,
                timeFontBold: timeFontBold,
                use24HourFormat: use24HourFormat,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> theme = const Value.absent(),
                required String taskColor,
                required String taskBorderColor,
                required String breakColor,
                required String breakBorderColor,
                required int dayStartMinute,
                required int dayEndMinute,
                required double timeFontSize,
                required bool timeFontBold,
                Value<bool> use24HourFormat = const Value.absent(),
              }) => SettingsCompanion.insert(
                id: id,
                theme: theme,
                taskColor: taskColor,
                taskBorderColor: taskBorderColor,
                breakColor: breakColor,
                breakBorderColor: breakBorderColor,
                dayStartMinute: dayStartMinute,
                dayEndMinute: dayEndMinute,
                timeFontSize: timeFontSize,
                timeFontBold: timeFontBold,
                use24HourFormat: use24HourFormat,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTable,
      SettingsEntity,
      $$SettingsTableFilterComposer,
      $$SettingsTableOrderingComposer,
      $$SettingsTableAnnotationComposer,
      $$SettingsTableCreateCompanionBuilder,
      $$SettingsTableUpdateCompanionBuilder,
      (
        SettingsEntity,
        BaseReferences<_$AppDatabase, $SettingsTable, SettingsEntity>,
      ),
      SettingsEntity,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
}
