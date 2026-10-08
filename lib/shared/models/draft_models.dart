import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:day_planner/shared/models/enums.dart';

part 'draft_models.freezed.dart';

@freezed
abstract class BlockDraft with _$BlockDraft {
  const factory BlockDraft({
    String? id, // null for new blocks
    @Default('Untitled') String name,
    @Default('') String description,
    @Default(BlockType.task) BlockType type,
    @Default(540) int startMinute, // Default 9:00 AM
    @Default(60) int duration, // Default 1 hr
    @Default(ColorTag.none) ColorTag colorTag,
    @Default(Repeat.none) Repeat recurring,
  }) = _BlockDraft;
}

@freezed
abstract class SettingsDraft with _$SettingsDraft {
  const factory SettingsDraft({
    @Default(540) int dayStartMinute,
    @Default(1020) int dayEndMinute,
    @Default(false) bool use24HourFormat,
  }) = _SettingsDraft;
}
