// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ThemeModel _$ThemeModelFromJson(Map<String, dynamic> json) => _ThemeModel(
  name: json['name'] as String,
  background: const ColorConverter().fromJson(
    (json['background'] as num).toInt(),
  ),
  timeline: const ColorConverter().fromJson((json['timeline'] as num).toInt()),
  taskFill: const ColorConverter().fromJson((json['taskFill'] as num).toInt()),
  taskBorder: const ColorConverter().fromJson(
    (json['taskBorder'] as num).toInt(),
  ),
  breakFill: const ColorConverter().fromJson(
    (json['breakFill'] as num).toInt(),
  ),
  breakBorder: const ColorConverter().fromJson(
    (json['breakBorder'] as num).toInt(),
  ),
);

Map<String, dynamic> _$ThemeModelToJson(_ThemeModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'background': const ColorConverter().toJson(instance.background),
      'timeline': const ColorConverter().toJson(instance.timeline),
      'taskFill': const ColorConverter().toJson(instance.taskFill),
      'taskBorder': const ColorConverter().toJson(instance.taskBorder),
      'breakFill': const ColorConverter().toJson(instance.breakFill),
      'breakBorder': const ColorConverter().toJson(instance.breakBorder),
    };
