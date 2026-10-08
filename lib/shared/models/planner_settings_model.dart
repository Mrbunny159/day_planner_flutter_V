import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:day_planner/core/constants/app_constants.dart';

part 'planner_settings_model.freezed.dart';
part 'planner_settings_model.g.dart';

@freezed
abstract class PlannerSettings with _$PlannerSettings {
  const factory PlannerSettings({
    @Default('Default') String theme,
    @Default([60, 100, 200, 180]) List<int> taskColor,
    @Default([100, 150, 220]) List<int> taskBorderColor,
    @Default([60, 120, 80, 180]) List<int> breakColor,
    @Default([100, 200, 120]) List<int> breakBorderColor,
    @Default(AppConstants.defaultDayStartMinute) int dayStartMinute,
    @Default(AppConstants.defaultDayEndMinute) int dayEndMinute,
    @Default(AppConstants.defaultTimeFontSize) double timeFontSize,
    @Default(AppConstants.defaultTimeFontBold) bool timeFontBold,
    @Default(false) bool use24HourFormat,
  }) = _PlannerSettings;

  factory PlannerSettings.fromJson(Map<String, dynamic> json) =>
      _$PlannerSettingsFromJson(json);
}
