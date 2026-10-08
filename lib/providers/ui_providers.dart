import 'package:flutter_riverpod/flutter_riverpod.dart';

// ─── Selection ──────────────────────────────────────────────

class TimelineScrollNotifier extends Notifier<double> {
  @override
  double build() => 0.0;
  void update(double value) => state = value;
}

/// Holds the current scroll offset of the timeline.
final timelineScrollProvider = NotifierProvider<TimelineScrollNotifier, double>(
  () => TimelineScrollNotifier(),
);

class SelectionNotifier extends Notifier<String?> {
  @override
  String? build() => null;
  void select(String? id) => state = id;
}

/// Holds the ID of the currently selected block, if any.
final selectionProvider = NotifierProvider<SelectionNotifier, String?>(
  () => SelectionNotifier(),
);

// ─── Drag State ─────────────────────────────────────────────

class DragState {
  final String blockId;
  final int initialStartMinute;
  final int taskDuration;
  final double accumulatedDeltaY;

  DragState({
    required this.blockId,
    required this.initialStartMinute,
    required this.taskDuration,
    required this.accumulatedDeltaY,
  });
}

class DragNotifier extends Notifier<DragState?> {
  @override
  DragState? build() => null;
  void startDrag(DragState drag) => state = drag;
  void updateDrag(double deltaY) {
    if (state != null) {
      state = DragState(
        blockId: state!.blockId,
        initialStartMinute: state!.initialStartMinute,
        taskDuration: state!.taskDuration,
        accumulatedDeltaY: state!.accumulatedDeltaY + deltaY,
      );
    }
  }

  void endDrag() => state = null;
}

/// Holds the state of the currently dragged block.
final dragProvider = NotifierProvider<DragNotifier, DragState?>(
  () => DragNotifier(),
);

// ─── Resize State ───────────────────────────────────────────

class ResizeState {
  final String blockId;
  final int initialDuration;
  final int maxDuration;
  final double accumulatedDeltaY;
  final bool isTopEdge;

  ResizeState({
    required this.blockId,
    required this.initialDuration,
    required this.maxDuration,
    required this.accumulatedDeltaY,
    required this.isTopEdge,
  });
}

class ResizeNotifier extends Notifier<ResizeState?> {
  @override
  ResizeState? build() => null;
  void startResize(ResizeState resize) => state = resize;
  void updateResize(double deltaY) {
    if (state != null) {
      state = ResizeState(
        blockId: state!.blockId,
        initialDuration: state!.initialDuration,
        maxDuration: state!.maxDuration,
        accumulatedDeltaY: state!.accumulatedDeltaY + deltaY,
        isTopEdge: state!.isTopEdge,
      );
    }
  }

  void endResize() => state = null;
}

/// Holds the state of the block currently being resized.
final resizeProvider = NotifierProvider<ResizeNotifier, ResizeState?>(
  () => ResizeNotifier(),
);

// ─── Dialog State ───────────────────────────────────────────

enum AppDialog { addTask, addBreak, editTask, settings, summary }

class DialogState {
  final AppDialog type;
  final String? targetBlockId;

  DialogState(this.type, {this.targetBlockId});
}

class DialogNotifier extends Notifier<DialogState?> {
  @override
  DialogState? build() => null;
  void show(AppDialog type, {String? targetBlockId}) {
    state = DialogState(type, targetBlockId: targetBlockId);
  }

  void hide() => state = null;
}

/// Holds the state for declaratively showing dialogs.
final dialogProvider = NotifierProvider<DialogNotifier, DialogState?>(
  () => DialogNotifier(),
);
