// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Summary _$SummaryFromJson(Map<String, dynamic> json) => _Summary(
  completedMinutes: (json['completedMinutes'] as num).toInt(),
  breakMinutes: (json['breakMinutes'] as num).toInt(),
  freeMinutes: (json['freeMinutes'] as num).toInt(),
);

Map<String, dynamic> _$SummaryToJson(_Summary instance) => <String, dynamic>{
  'completedMinutes': instance.completedMinutes,
  'breakMinutes': instance.breakMinutes,
  'freeMinutes': instance.freeMinutes,
};
