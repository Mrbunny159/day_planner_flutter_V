import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:day_planner/shared/models/task_model.dart';
import 'package:day_planner/shared/models/enums.dart';
import 'package:day_planner/providers/ui_providers.dart';
import 'package:day_planner/app/theme/app_colors.dart';
import 'package:day_planner/providers/planner_provider.dart';
import 'package:day_planner/shared/models/draft_models.dart';
import 'package:day_planner/ui/widgets/dialogs/block_dialog.dart';
import 'package:day_planner/ui/widgets/color_tag_picker_row.dart';
import 'package:day_planner/app/constants/app_layout.dart';

class TaskCard extends ConsumerWidget {
  final Task task;
  final bool isDragging;
  final bool isResizingTop;
  final bool isResizingBottom;
  final int? previewDuration;

  const TaskCard({
    super.key,
    required this.task,
    this.isDragging = false,
    this.isResizingTop = false,
    this.isResizingBottom = false,
    this.previewDuration,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedId = ref.watch(selectionProvider);
    final isSelected = selectedId == task.id;

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final plannerSettings = ref.watch(plannerProvider).value?.settings;

    final isBreak = task.type == BlockType.breakBlock;

    Color? getCustomColor(List<int>? rgb, List<int> defaultRgb) {
      if (rgb == null || rgb.isEmpty) return null;
      if (listEquals(rgb, defaultRgb)) {
        return null; // Use design system instead of PyQt defaults
      }
      if (rgb.length == 3) return Color.fromARGB(255, rgb[0], rgb[1], rgb[2]);
      if (rgb.length == 4) {
        return Color.fromARGB(rgb[3], rgb[0], rgb[1], rgb[2]);
      }
      return null;
    }

    final Color? customFill = isBreak
        ? getCustomColor(plannerSettings?.breakColor, [60, 120, 80, 180])
        : getCustomColor(plannerSettings?.taskColor, [60, 100, 200, 180]);

    final Color? customBorder = isBreak
        ? getCustomColor(plannerSettings?.breakBorderColor, [100, 200, 120])
        : getCustomColor(plannerSettings?.taskBorderColor, [100, 150, 220]);

    final Color fillColor;
    final Color borderColor;
    final Color textColor;
    final Color durationBadgeColor;
    final Color timeColor;

    if (task.colorTag != ColorTag.none && task.colorTag.color != null) {
      fillColor = task.colorTag.color!;
      final baseBorder = isDark
          ? task.colorTag.color!.withValues(alpha: 0.5)
          : task.colorTag.color!.withValues(alpha: 0.8);
      borderColor = isSelected ? AppColors.selectionHighlight : baseBorder;
      textColor = AppColors.cardTextPrimary;
      durationBadgeColor = isDark ? Colors.black54 : Colors.black12;
      timeColor = AppColors.cardTextSecondary;
    } else {
      if (isBreak) {
        fillColor = customFill ?? (isDark ? const Color(0xFF3B2F2F) : const Color(0xFFFFF4E6));
        borderColor = isSelected ? AppColors.selectionHighlight : (customBorder ?? (isDark ? const Color(0xFF5E4545) : const Color(0xFFFBE4C6)));
        textColor = isDark ? const Color(0xFFBCA6F1) : const Color(0xFF7C3AED);
        durationBadgeColor = textColor;
        timeColor = textColor.withValues(alpha: 0.8);
      } else {
        fillColor = customFill ?? (isDark ? const Color(0xFF1E2E22) : const Color(0xFFE6F6EB));
        borderColor = isSelected ? AppColors.selectionHighlight : (customBorder ?? (isDark ? const Color(0xFF2D4533) : const Color(0xFFC3E8D1)));
        textColor = isDark ? const Color(0xFF86D6A2) : const Color(0xFF166534);
        durationBadgeColor = textColor;
        timeColor = textColor.withValues(alpha: 0.8);
      }
    }

    final renderDuration = previewDuration ?? task.duration;

    final is24Hour = plannerSettings?.use24HourFormat ?? false;

    final startTimeStr = _formatTime(task.startMinute, is24Hour);
    final endTimeStr = _formatTime(task.startMinute + renderDuration, is24Hour);
    final timeRange = '$startTimeStr - $endTimeStr';

    final scale = isDragging ? 1.02 : 1.0;

    return GestureDetector(
      onTap: () {
        ref.read(selectionProvider.notifier).select(task.id);
      },
      onSecondaryTapDown: (details) {
        ref.read(selectionProvider.notifier).select(task.id);
        final isMobile =
            !kIsWeb &&
            (defaultTargetPlatform == TargetPlatform.iOS ||
                defaultTargetPlatform == TargetPlatform.android);
        if (!isMobile) {
          _showDesktopMenu(context, ref, details.globalPosition);
        }
      },
      onLongPress: () {
        ref.read(selectionProvider.notifier).select(task.id);
        final isMobile =
            !kIsWeb &&
            (defaultTargetPlatform == TargetPlatform.iOS ||
                defaultTargetPlatform == TargetPlatform.android);
        if (isMobile) {
          _showMobileMenu(context, ref);
        }
      },
      onDoubleTap: () async {
        final draft = BlockDraft(
          id: task.id,
          name: task.name,
          // description is not in the model right now, it will be empty
          type: task.type,
          startMinute: task.startMinute,
          duration: task.duration,
          colorTag: task.colorTag,
          recurring: task.recurring,
        );

        final result = await showDialog<BlockDraft>(
          context: context,
          builder: (_) => BlockDialog(initialDraft: draft, isEditMode: true),
        );

        if (result != null) {
          ref.read(plannerProvider.notifier).editBlock(result);
        }
      },
      onPanStart: (details) {
        if (isBreak) return;
        ref
            .read(dragProvider.notifier)
            .startDrag(
              DragState(
                blockId: task.id,
                initialStartMinute: task.startMinute,
                taskDuration: task.duration,
                accumulatedDeltaY: 0,
              ),
            );
      },
      onPanUpdate: (details) {
        ref.read(dragProvider.notifier).updateDrag(details.delta.dy);
      },
      onPanEnd: (details) {
        final dragState = ref.read(dragProvider);
        if (dragState != null && dragState.blockId == task.id) {
          final totalPixels =
              (dragState.initialStartMinute * AppLayout.pixelsPerMinute) +
              dragState.accumulatedDeltaY;
          final rawMinutes = totalPixels / AppLayout.pixelsPerMinute;
          int snapped = (rawMinutes / 15.0).round() * 15;
          snapped = snapped.clamp(0, 1440 - task.duration);

          ref.read(plannerProvider.notifier).moveBlock(task.id, snapped);
          ref.read(dragProvider.notifier).endDrag();
        }
      },
      child: Transform.scale(
        scale: scale,
        child: Opacity(
          opacity: task.completed ? 0.4 : 1.0,
          child: Stack(
            children: [
            Positioned.fill(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final totalHeight = constraints.maxHeight;
                  final availableHeight =
                      totalHeight - (isSelected ? 4.0 : 2.0); // Border space

                  bool showTime = false;
                  bool showIcons = false;
                  double vertPadding = 0.0;

                  // Minimum heights required for contents
                  const titleHeight = 18.0;
                  const timeHeight = 16.0;
                  const spacing = 4.0;
                  const titleAndTimeHeight =
                      titleHeight + spacing + timeHeight; // 38.0

                  if (availableHeight >= titleAndTimeHeight + 16.0) {
                    showTime = true;
                    showIcons = true;
                    vertPadding = 8.0;
                  } else if (availableHeight >= titleAndTimeHeight + 2.0) {
                    showTime = true;
                    showIcons = true;
                    vertPadding = 1.0;
                  } else if (availableHeight >= titleHeight + 8.0) {
                    showTime = false;
                    showIcons = true;
                    vertPadding = 4.0;
                  } else {
                    showTime = false;
                    showIcons = false;
                    vertPadding = 0.0;
                  }

                  return MouseRegion(
                    cursor: isDragging
                        ? SystemMouseCursors.grabbing
                        : (isBreak
                              ? SystemMouseCursors.basic
                              : SystemMouseCursors.grab),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: fillColor,
                        border: Border.all(
                          color: borderColor,
                          width: isSelected ? 2.0 : (isBreak ? 0.0 : 1.0),
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: isDragging
                            ? [
                                const BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 12.0,
                                  spreadRadius: 2.0,
                                ),
                              ]
                            : (isSelected
                                  ? [
                                      BoxShadow(
                                        color: AppColors.selectionHighlight
                                            .withValues(alpha: 0.3),
                                        blurRadius: 8.0,
                                        spreadRadius: 1.0,
                                      ),
                                    ]
                                  : null),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: vertPadding,
                      ),
                      child: OverflowBox(
                        minHeight: 0,
                        maxHeight: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (showIcons && !isBreak)
                                GestureDetector(
                                  onTap: () {
                                    ref.read(plannerProvider.notifier).toggleCompletion(task.id);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Container(
                                      width: 24.0,
                                      height: 24.0,
                                      decoration: BoxDecoration(
                                        color: task.completed ? AppColors.success : (isDark ? Colors.black26 : Colors.white),
                                        borderRadius: BorderRadius.circular(6.0),
                                        border: Border.all(
                                          color: task.completed ? AppColors.success : textColor.withValues(alpha: 0.5),
                                          width: 2.0,
                                        ),
                                      ),
                                      child: task.completed
                                          ? const Icon(Icons.check, size: 18.0, color: Colors.white)
                                          : null,
                                    ),
                                  ),
                                ),
                              if (isBreak)
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Icon(
                                    Icons.local_cafe,
                                    size: 18.0,
                                    color: textColor,
                                  ),
                                ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      task.name,
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    if (showTime) ...[
                                      const SizedBox(height: 2.0),
                                      Text(
                                        timeRange,
                                        style: TextStyle(
                                          color: timeColor,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                  decoration: BoxDecoration(
                                    color: durationBadgeColor,
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: Text(
                                    _formatDurationBadge(renderDuration),
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              if (showIcons && task.recurring != Repeat.none)
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Icon(
                                    Icons.replay,
                                    size: 18.0,
                                    color: isBreak ? textColor : const Color(0xFF7C3AED),
                                  ),
                                ),
                              if (showIcons)
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Icon(
                                    Icons.more_horiz,
                                    size: 20.0,
                                    color: textColor.withValues(alpha: 0.6),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      ),
                    ),
                  );
                },
              ),
            ),
            if (!isBreak) // Top edge resize handle
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 16,
                child: MouseRegion(
                  cursor: SystemMouseCursors.resizeUpDown,
                  child: GestureDetector(
                    onPanStart: (details) {
                      ref
                          .read(resizeProvider.notifier)
                          .startResize(
                            ResizeState(
                              blockId: task.id,
                              initialDuration: task.duration,
                              maxDuration: task.duration + task.startMinute,
                              accumulatedDeltaY: 0,
                              isTopEdge: true,
                            ),
                          );
                    },
                    onPanUpdate: (details) {
                      ref
                          .read(resizeProvider.notifier)
                          .updateResize(details.delta.dy);
                    },
                    onPanEnd: (details) {
                      final resizeState = ref.read(resizeProvider);
                      if (resizeState != null &&
                          resizeState.blockId == task.id) {
                        final totalPixels =
                            (resizeState.initialDuration *
                                AppLayout.pixelsPerMinute) -
                            resizeState.accumulatedDeltaY;
                        final rawMinutes =
                            totalPixels / AppLayout.pixelsPerMinute;
                        int snapped = (rawMinutes / 15.0).round() * 15;
                        snapped = snapped.clamp(15, resizeState.maxDuration);

                        final draft = BlockDraft(
                          id: task.id,
                          name: task.name,
                          type: task.type,
                          startMinute:
                              task.startMinute + (task.duration - snapped),
                          duration: snapped,
                          colorTag: task.colorTag,
                          recurring: task.recurring,
                        );
                        ref.read(plannerProvider.notifier).editBlock(draft);
                        ref.read(resizeProvider.notifier).endResize();
                      }
                    },
                    child: Center(
                      child: Container(
                        width: 32,
                        height: 4,
                        decoration: BoxDecoration(
                          color: isResizingTop
                              ? AppColors.selectionHighlight
                              : Colors.transparent, // Invisible by default
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (!isBreak) // Bottom edge resize handle
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: 16,
                child: MouseRegion(
                  cursor: SystemMouseCursors.resizeUpDown,
                  child: GestureDetector(
                    onPanStart: (details) {
                      ref
                          .read(resizeProvider.notifier)
                          .startResize(
                            ResizeState(
                              blockId: task.id,
                              initialDuration: task.duration,
                              maxDuration: 1440 - task.startMinute,
                              accumulatedDeltaY: 0,
                              isTopEdge: false,
                            ),
                          );
                    },
                    onPanUpdate: (details) {
                      ref
                          .read(resizeProvider.notifier)
                          .updateResize(details.delta.dy);
                    },
                    onPanEnd: (details) {
                      final resizeState = ref.read(resizeProvider);
                      if (resizeState != null &&
                          resizeState.blockId == task.id) {
                        final totalPixels =
                            (resizeState.initialDuration *
                                AppLayout.pixelsPerMinute) +
                            resizeState.accumulatedDeltaY;
                        final rawMinutes =
                            totalPixels / AppLayout.pixelsPerMinute;
                        int snapped = (rawMinutes / 15.0).round() * 15;
                        snapped = snapped.clamp(15, resizeState.maxDuration);

                        ref
                            .read(plannerProvider.notifier)
                            .resizeBlock(task.id, snapped);
                        ref.read(resizeProvider.notifier).endResize();
                      }
                    },
                    child: Center(
                      child: Container(
                        width: 32,
                        height: 4,
                        decoration: BoxDecoration(
                          color: isResizingBottom
                              ? AppColors.selectionHighlight
                              : Colors.grey.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      ),
    );
  }

  String _formatDurationBadge(int minutes) {
    if (minutes < 60) return '${minutes}m';
    final h = minutes ~/ 60;
    final m = minutes % 60;
    return m == 0 ? '${h}h' : '${h}h ${m}m';
  }

  String _formatTime(int totalMinutes, bool is24Hour) {
    final hours = (totalMinutes ~/ 60) % 24;
    final mins = totalMinutes % 60;

    if (is24Hour) {
      return '${hours.toString().padLeft(2, '0')}:${mins.toString().padLeft(2, '0')}';
    } else {
      final ampm = hours >= 12 ? 'PM' : 'AM';
      final h12 = hours == 0 ? 12 : (hours > 12 ? hours - 12 : hours);
      return '$h12:${mins.toString().padLeft(2, '0')} $ampm';
    }
  }

  void _showDesktopMenu(
    BuildContext context,
    WidgetRef ref,
    Offset position,
  ) async {
    final result = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx,
        position.dy,
      ),
      items: [
        const PopupMenuItem(value: 'edit', child: Text('Edit')),
        if (task.type == BlockType.task)
          PopupMenuItem(
            value: 'toggle_completion',
            child: Text(task.completed ? 'Mark Incomplete' : 'Mark Complete'),
          ),
        const PopupMenuDivider(),
        const PopupMenuItem(
          enabled: false,
          child: Text(
            'Set Color:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        PopupMenuItem(
          enabled: false,
          child: ColorTagPickerRow(
            selectedTag: task.colorTag,
            onColorSelected: (tag) {
              final draft = _taskToDraft(task).copyWith(colorTag: tag);
              ref.read(plannerProvider.notifier).editBlock(draft);
              Navigator.of(context).pop();
            },
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem(
          value: 'delete',
          child: Text('Delete', style: TextStyle(color: Colors.red)),
        ),
      ],
    );

    if (!context.mounted) return;
    _handleMenuAction(context, ref, result);
  }

  void _showMobileMenu(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit'),
                onTap: () {
                  Navigator.of(ctx).pop();
                  _handleMenuAction(context, ref, 'edit');
                },
              ),
              if (task.type == BlockType.task)
                ListTile(
                  leading: Icon(
                    task.completed ? Icons.remove_done : Icons.done,
                  ),
                  title: Text(
                    task.completed ? 'Mark Incomplete' : 'Mark Complete',
                  ),
                  onTap: () {
                    Navigator.of(ctx).pop();
                    _handleMenuAction(context, ref, 'toggle_completion');
                  },
                ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Set Color',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ColorTagPickerRow(
                    selectedTag: task.colorTag,
                    onColorSelected: (tag) {
                      final draft = _taskToDraft(task).copyWith(colorTag: tag);
                      ref.read(plannerProvider.notifier).editBlock(draft);
                      Navigator.of(ctx).pop();
                    },
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.of(ctx).pop();
                  _handleMenuAction(context, ref, 'delete');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _handleMenuAction(
    BuildContext context,
    WidgetRef ref,
    String? action,
  ) async {
    if (action == null) return;

    switch (action) {
      case 'edit':
        final draft = _taskToDraft(task);
        if (!context.mounted) return;
        final result = await showDialog<BlockDraft>(
          context: context,
          builder: (_) => BlockDialog(initialDraft: draft, isEditMode: true),
        );
        if (result != null) {
          ref.read(plannerProvider.notifier).editBlock(result);
        }
        break;
      case 'toggle_completion':
        ref.read(plannerProvider.notifier).toggleCompletion(task.id);
        break;
      case 'delete':
        ref.read(plannerProvider.notifier).deleteBlock(task.id);
        break;
    }
  }

  BlockDraft _taskToDraft(Task t) {
    return BlockDraft(
      id: t.id,
      name: t.name,
      type: t.type,
      startMinute: t.startMinute,
      duration: t.duration,
      colorTag: t.colorTag,
      recurring: t.recurring,
    );
  }
}
