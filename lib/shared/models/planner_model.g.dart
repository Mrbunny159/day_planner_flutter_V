// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Planner _$PlannerFromJson(Map<String, dynamic> json) => _Planner(
  id: json['id'] as String,
  date: DateTime.parse(json['date'] as String),
  tasks:
      (json['tasks'] as List<dynamic>?)
          ?.map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  settings: PlannerSettings.fromJson(json['settings'] as Map<String, dynamic>),
  summary: Summary.fromJson(json['summary'] as Map<String, dynamic>),
  lastUpdated: DateTime.parse(json['lastUpdated'] as String),
);

Map<String, dynamic> _$PlannerToJson(_Planner instance) => <String, dynamic>{
  'id': instance.id,
  'date': instance.date.toIso8601String(),
  'tasks': instance.tasks,
  'settings': instance.settings,
  'summary': instance.summary,
  'lastUpdated': instance.lastUpdated.toIso8601String(),
};
