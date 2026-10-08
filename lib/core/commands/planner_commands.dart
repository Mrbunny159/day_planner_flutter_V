import 'package:day_planner/shared/models/planner_model.dart';

/// Base class for all undoable planner commands.
/// Instead of complex reverse logic, we rely on immutable Planner snapshots.
abstract class PlannerCommand {
  final Planner beforeState;
  final Planner afterState;

  PlannerCommand(this.beforeState, this.afterState);
}

class AddBlockCommand extends PlannerCommand {
  AddBlockCommand(super.beforeState, super.afterState);
}

class EditBlockCommand extends PlannerCommand {
  EditBlockCommand(super.beforeState, super.afterState);
}

class MoveBlockCommand extends PlannerCommand {
  MoveBlockCommand(super.beforeState, super.afterState);
}

class ResizeBlockCommand extends PlannerCommand {
  ResizeBlockCommand(super.beforeState, super.afterState);
}

class DeleteBlockCommand extends PlannerCommand {
  DeleteBlockCommand(super.beforeState, super.afterState);
}

class ToggleCompletionCommand extends PlannerCommand {
  ToggleCompletionCommand(super.beforeState, super.afterState);
}

class AutoPlanCommand extends PlannerCommand {
  AutoPlanCommand(super.beforeState, super.afterState);
}

class ClearAllCommand extends PlannerCommand {
  ClearAllCommand(super.beforeState, super.afterState);
}

/// A lightweight history stack for tracking previous planner states.
class CommandHistory {
  final List<PlannerCommand> _undoStack = [];
  static const int maxHistory = 50;

  void push(PlannerCommand command) {
    _undoStack.add(command);
    if (_undoStack.length > maxHistory) {
      _undoStack.removeAt(0);
    }
  }

  PlannerCommand? pop() {
    if (_undoStack.isEmpty) return null;
    return _undoStack.removeLast();
  }

  void clear() {
    _undoStack.clear();
  }

  bool get canUndo => _undoStack.isNotEmpty;
}
