import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:day_planner/shared/models/enums.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
abstract class Task with _$Task {
  const Task._();

  const factory Task({
    required String id,
    @Default('Untitled') String name,
    required int startMinute,
    required int duration,
    @Default(false) bool completed,
    @Default(BlockType.task) BlockType type,
    @Default(Repeat.none) Repeat recurring,
    @Default(ColorTag.none) ColorTag colorTag,
    required DateTime date,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  /// Computed end minute based on start and duration.
  int get endMinute => startMinute + duration;
}
