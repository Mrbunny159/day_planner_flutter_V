import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:day_planner/shared/models/task_model.dart';
import 'package:day_planner/shared/models/planner_settings_model.dart';
import 'package:day_planner/shared/models/summary_model.dart';

part 'planner_model.freezed.dart';
part 'planner_model.g.dart';

@freezed
abstract class Planner with _$Planner {
  const factory Planner({
    required String id,
    required DateTime date,
    @Default([]) List<Task> tasks,
    required PlannerSettings settings,
    required Summary summary,
    required DateTime lastUpdated,
  }) = _Planner;

  factory Planner.fromJson(Map<String, dynamic> json) =>
      _$PlannerFromJson(json);
}
