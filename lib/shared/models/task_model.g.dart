// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Task _$TaskFromJson(Map<String, dynamic> json) => _Task(
  id: json['id'] as String,
  name: json['name'] as String? ?? 'Untitled',
  startMinute: (json['startMinute'] as num).toInt(),
  duration: (json['duration'] as num).toInt(),
  completed: json['completed'] as bool? ?? false,
  type: $enumDecodeNullable(_$BlockTypeEnumMap, json['type']) ?? BlockType.task,
  recurring:
      $enumDecodeNullable(_$RepeatEnumMap, json['recurring']) ?? Repeat.none,
  colorTag:
      $enumDecodeNullable(_$ColorTagEnumMap, json['colorTag']) ?? ColorTag.none,
  date: DateTime.parse(json['date'] as String),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$TaskToJson(_Task instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'startMinute': instance.startMinute,
  'duration': instance.duration,
  'completed': instance.completed,
  'type': instance.type,
  'recurring': instance.recurring,
  'colorTag': instance.colorTag,
  'date': instance.date.toIso8601String(),
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};

const _$BlockTypeEnumMap = {
  BlockType.task: 'task',
  BlockType.breakBlock: 'breakBlock',
};

const _$RepeatEnumMap = {Repeat.none: 'none', Repeat.daily: 'daily'};

const _$ColorTagEnumMap = {
  ColorTag.none: 'none',
  ColorTag.blue: 'blue',
  ColorTag.green: 'green',
  ColorTag.orange: 'orange',
  ColorTag.red: 'red',
};
