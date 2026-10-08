import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:day_planner/shared/models/planner_model.dart';
import 'package:day_planner/app/constants/app_layout.dart';
import 'package:day_planner/ui/widgets/time_indicator.dart';
import 'package:day_planner/ui/widgets/current_time_line.dart';
import 'package:day_planner/providers/ui_providers.dart';
import 'package:day_planner/ui/widgets/task_card.dart';

class TimelineView extends ConsumerStatefulWidget {
  final Planner planner;

  const TimelineView({super.key, required this.planner});

  @override
  ConsumerState<TimelineView> createState() => _TimelineViewState();
}

class _TimelineViewState extends ConsumerState<TimelineView> {
  late ScrollController _scrollController;
  bool _isAutoScrolling = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Sync scroll offset to provider
    _scrollController.addListener(() {
      if (!_isAutoScrolling) {
        ref
            .read(timelineScrollProvider.notifier)
            .update(_scrollController.offset);
      }
    });

    // Auto-scroll to current time on first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentTime();
    });
  }

  void _scrollToCurrentTime() {
    final now = DateTime.now();
    final currentMinute = now.hour * 60 + now.minute;

    // Target offset: current time centered in the view
    final targetY = currentMinute * AppLayout.pixelsPerMinute;

    if (!_scrollController.hasClients) return;

    final halfScreen = MediaQuery.of(context).size.height / 2;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final targetScroll = (targetY - halfScreen).clamp(0.0, maxScroll);

    _isAutoScrolling = true;
    _scrollController
        .animateTo(
          targetScroll,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCubic,
        )
        .then((_) {
          if (mounted) {
            _isAutoScrolling = false;
            ref
                .read(timelineScrollProvider.notifier)
                .update(_scrollController.offset);
          }
        });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = widget.planner.settings;
    int earliestStart = settings.dayStartMinute;
    int latestEnd = settings.dayEndMinute;

    for (final task in widget.planner.tasks) {
      if (task.startMinute < earliestStart) earliestStart = task.startMinute;
      if (task.startMinute + task.duration > latestEnd) {
        latestEnd = task.startMinute + task.duration;
      }
    }

    if (earliestStart < 0) earliestStart = 0;
    if (latestEnd > 1440) latestEnd = 1440;

    final startHour = earliestStart ~/ 60;
    final endHour = (latestEnd / 60).ceil();
    final totalMinutes = latestEnd - earliestStart;
    final totalHeight = totalMinutes * AppLayout.pixelsPerMinute;

    final dragState = ref.watch(dragProvider);
    final resizeState = ref.watch(resizeProvider);

    return SingleChildScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      child: GestureDetector(
        onTap: () {
          ref.read(selectionProvider.notifier).select(null);
        },
        behavior: HitTestBehavior.translucent,
        child: SizedBox(
          height: totalHeight,
          child: Stack(
            children: [
              // 0. Non-working hour overlays
              if (earliestStart < settings.dayStartMinute)
                Positioned(
                  top: 0,
                  left: AppLayout.timeColumnWidth,
                  right: 0,
                  height:
                      (settings.dayStartMinute - earliestStart) *
                      AppLayout.pixelsPerMinute,
                  child: Container(
                    color: Theme.of(
                      context,
                    ).dividerColor.withValues(alpha: 0.1),
                  ),
                ),
              if (latestEnd > settings.dayEndMinute)
                Positioned(
                  top:
                      (settings.dayEndMinute - earliestStart) *
                      AppLayout.pixelsPerMinute,
                  left: AppLayout.timeColumnWidth,
                  right: 0,
                  height:
                      (latestEnd - settings.dayEndMinute) *
                      AppLayout.pixelsPerMinute,
                  child: Container(
                    color: Theme.of(
                      context,
                    ).dividerColor.withValues(alpha: 0.1),
                  ),
                ),

              // 1. Background Time Grid
              for (int hour = startHour; hour <= endHour; hour++)
                Positioned(
                  top: (hour * 60 - earliestStart) * AppLayout.pixelsPerMinute,
                  left: 0,
                  right: 0,
                  child: TimeIndicator(
                    hour: hour,
                    fontSize: settings.timeFontSize,
                    isBold: settings.timeFontBold,
                  ),
                ),

              // 2. Tasks and Breaks
              for (final task in widget.planner.tasks)
                if (dragState?.blockId != task.id)
                  Builder(
                    builder: (context) {
                      final isResizing = resizeState?.blockId == task.id;
                      final isTopEdge = isResizing && (resizeState?.isTopEdge ?? false);
                      int renderDuration = task.duration;
                      int renderStartMinute = task.startMinute;

                      if (isResizing) {
                        final totalPixels = (resizeState!.initialDuration * AppLayout.pixelsPerMinute) +
                            (isTopEdge ? -resizeState.accumulatedDeltaY : resizeState.accumulatedDeltaY);
                        final rawMinutes = totalPixels / AppLayout.pixelsPerMinute;
                        renderDuration = (rawMinutes / 15.0).round() * 15;
                        renderDuration = renderDuration.clamp(
                          15,
                          resizeState.maxDuration,
                        );

                        if (isTopEdge) {
                          renderStartMinute = task.startMinute + (task.duration - renderDuration);
                        }
                      }

                      return AnimatedPositioned(
                        duration: isResizing ? Duration.zero : const Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic,
                        top:
                            (renderStartMinute - earliestStart) *
                            AppLayout.pixelsPerMinute,
                        left: AppLayout.timeColumnWidth + 12.0,
                        right: 12.0,
                        height: renderDuration * AppLayout.pixelsPerMinute,
                        child: TaskCard(
                          task: task,
                          isDragging: false,
                          isResizingTop: isTopEdge,
                          isResizingBottom: isResizing && !isTopEdge,
                          previewDuration: isResizing ? renderDuration : null,
                        ),
                      );
                    },
                  ),

              // 3. Current Time Indicator
              Positioned.fill(
                child: CurrentTimeLine(
                  offsetMinute: earliestStart,
                  fontSize: settings.timeFontSize,
                  isBold: settings.timeFontBold,
                ),
              ),

              // 4. Drag Preview (On Top)
              if (dragState != null)
                Builder(
                  builder: (context) {
                    final task = widget.planner.tasks.firstWhere(
                      (t) => t.id == dragState.blockId,
                      orElse: () => widget.planner.tasks.first,
                    );

                    final totalPixels =
                        (dragState.initialStartMinute *
                            AppLayout.pixelsPerMinute) +
                        dragState.accumulatedDeltaY;
                    final rawMinutes = totalPixels / AppLayout.pixelsPerMinute;
                    int renderStartMinute = (rawMinutes / 15.0).round() * 15;
                    renderStartMinute = renderStartMinute.clamp(
                      0,
                      1440 - task.duration,
                    );

                    return AnimatedPositioned(
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeOutCubic,
                      top:
                          (renderStartMinute - earliestStart) *
                          AppLayout.pixelsPerMinute,
                      left: AppLayout.timeColumnWidth + 12.0,
                      right: 12.0,
                      height: task.duration * AppLayout.pixelsPerMinute,
                      child: TaskCard(task: task, isDragging: true),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
