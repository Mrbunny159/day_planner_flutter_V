// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planner_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlannerSettings _$PlannerSettingsFromJson(Map<String, dynamic> json) =>
    _PlannerSettings(
      theme: json['theme'] as String? ?? 'Default',
      taskColor:
          (json['taskColor'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [60, 100, 200, 180],
      taskBorderColor:
          (json['taskBorderColor'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [100, 150, 220],
      breakColor:
          (json['breakColor'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [60, 120, 80, 180],
      breakBorderColor:
          (json['breakBorderColor'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [100, 200, 120],
      dayStartMinute:
          (json['dayStartMinute'] as num?)?.toInt() ??
          AppConstants.defaultDayStartMinute,
      dayEndMinute:
          (json['dayEndMinute'] as num?)?.toInt() ??
          AppConstants.defaultDayEndMinute,
      timeFontSize:
          (json['timeFontSize'] as num?)?.toDouble() ??
          AppConstants.defaultTimeFontSize,
      timeFontBold:
          json['timeFontBold'] as bool? ?? AppConstants.defaultTimeFontBold,
      use24HourFormat: json['use24HourFormat'] as bool? ?? false,
    );

Map<String, dynamic> _$PlannerSettingsToJson(_PlannerSettings instance) =>
    <String, dynamic>{
      'theme': instance.theme,
      'taskColor': instance.taskColor,
      'taskBorderColor': instance.taskBorderColor,
      'breakColor': instance.breakColor,
      'breakBorderColor': instance.breakBorderColor,
      'dayStartMinute': instance.dayStartMinute,
      'dayEndMinute': instance.dayEndMinute,
      'timeFontSize': instance.timeFontSize,
      'timeFontBold': instance.timeFontBold,
      'use24HourFormat': instance.use24HourFormat,
    };
