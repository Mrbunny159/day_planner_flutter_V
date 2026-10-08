import 'package:freezed_annotation/freezed_annotation.dart';

part 'summary_model.freezed.dart';
part 'summary_model.g.dart';

@freezed
abstract class Summary with _$Summary {
  const factory Summary({
    required int completedMinutes,
    required int breakMinutes,
    required int freeMinutes,
  }) = _Summary;

  factory Summary.fromJson(Map<String, dynamic> json) =>
      _$SummaryFromJson(json);

  const Summary._(); // Added for custom getters in Freezed

  int get totalPlannedMinutes => (24 * 60) - freeMinutes;
  double get utilizationPercentage =>
      totalPlannedMinutes == 0 ? 0.0 : completedMinutes / totalPlannedMinutes;
}
