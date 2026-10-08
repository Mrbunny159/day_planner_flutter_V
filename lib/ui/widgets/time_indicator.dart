import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:day_planner/app/constants/app_layout.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:day_planner/providers/planner_provider.dart';

class TimeIndicator extends ConsumerWidget {
  final int hour;
  final double? fontSize;
  final bool isBold;

  const TimeIndicator({
    super.key,
    required this.hour,
    this.fontSize,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plannerSettings = ref.watch(plannerProvider).value?.settings;
    final is24Hour = plannerSettings?.use24HourFormat ?? false;

    final format = DateFormat(is24Hour ? 'HH:mm' : 'h:mm a');
    final timeStr = format.format(DateTime(2000, 1, 1, hour, 0));
    final halfTimeStr = format.format(DateTime(2000, 1, 1, hour, 30));

    final dividerColor = Theme.of(context).dividerColor;

    final baseTextStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
      color: Theme.of(
        context,
      ).textTheme.bodyMedium?.color?.withValues(alpha: 0.5),
    );

    final textStyle = baseTextStyle?.copyWith(
      fontSize: fontSize,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    );

    final halfTextStyle = baseTextStyle?.copyWith(
      fontSize: (fontSize ?? 12.0) - 2.0,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
    );

    return SizedBox(
      height: 60 * AppLayout.pixelsPerMinute,
      child: Stack(
        children: [
          // Full Hour Line
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: AppLayout.timeColumnWidth,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, top: 0.0),
                    child: Text(
                      timeStr,
                      textAlign: TextAlign.right,
                      style: textStyle,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Divider(
                      color: dividerColor,
                      thickness: 1,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Half Hour Line
          Positioned(
            top: 30 * AppLayout.pixelsPerMinute,
            left: 0,
            right: 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: AppLayout.timeColumnWidth,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, top: 0.0),
                    child: Text(
                      halfTimeStr,
                      textAlign: TextAlign.right,
                      style: halfTextStyle,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Divider(
                      color: dividerColor.withValues(alpha: 0.3),
                      thickness: 1,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
