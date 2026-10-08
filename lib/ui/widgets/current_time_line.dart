import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:day_planner/providers/time_provider.dart';
import 'package:day_planner/app/constants/app_layout.dart';
import 'package:day_planner/app/theme/app_colors.dart';
import 'package:day_planner/app/constants/app_animation.dart';
import 'package:day_planner/providers/planner_provider.dart';

class CurrentTimeLine extends ConsumerWidget {
  final int offsetMinute;
  final double? fontSize;
  final bool isBold;

  const CurrentTimeLine({
    super.key,
    this.offsetMinute = 0,
    this.fontSize,
    this.isBold = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMinute = ref.watch(currentMinuteProvider);
    final topPosition =
        (currentMinute - offsetMinute) * AppLayout.pixelsPerMinute;

    final plannerSettings = ref.watch(plannerProvider).value?.settings;
    final is24Hour = plannerSettings?.use24HourFormat ?? false;

    final hours = (currentMinute ~/ 60) % 24;
    final mins = currentMinute % 60;
    
    String timeStr;
    if (is24Hour) {
      timeStr = '${hours.toString().padLeft(2, '0')}:${mins.toString().padLeft(2, '0')}';
    } else {
      final ampm = hours >= 12 ? 'PM' : 'AM';
      final h12 = hours == 0 ? 12 : (hours > 12 ? hours - 12 : hours);
      timeStr = '$h12:${mins.toString().padLeft(2, '0')} $ampm';
    }

    final displayText = '● $timeStr';

    return Stack(
      children: [
        AnimatedPositioned(
          duration: AppAnimation.slow,
          curve: AppAnimation.currentTime,
          top: topPosition - 6.0, // Center vertically
          left: 0,
          right: 0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: AppLayout.timeColumnWidth,
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    displayText,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppColors.currentTimeLine,
                      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                      fontSize: fontSize ?? 12,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(height: 2, color: AppColors.currentTimeLine),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
