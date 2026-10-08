import 'package:day_planner/shared/models/planner_model.dart';

class DatabaseCorruptException implements Exception {
  final String message;
  DatabaseCorruptException([this.message = 'The planner database appears to be corrupted.']);
  
  @override
  String toString() => message;
}

class SaveFailureException implements Exception {
  final Planner preservedState;
  final String message;
  SaveFailureException(this.preservedState, [this.message = 'Unable to save changes.']);
  
  @override
  String toString() => message;
}
