import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:day_planner/shared/models/summary_model.dart';
import 'package:day_planner/providers/planner_provider.dart';

/// Derived provider that exposes the current Planner Summary.
final summaryProvider = Provider<Summary?>((ref) {
  final plannerState = ref.watch(plannerProvider);
  return plannerState.value?.summary;
});
