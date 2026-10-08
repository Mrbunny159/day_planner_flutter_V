import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:day_planner/providers/summary_provider.dart';

class SummaryBar extends ConsumerWidget {
  const SummaryBar({super.key});

  String _formatDuration(int totalMinutes) {
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    }
    return '${minutes}m';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(summaryProvider);

    if (summary == null) {
      return const SizedBox(height: 48);
    }

    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _SummaryItem(
            label: 'Planned',
            value: _formatDuration(summary.totalPlannedMinutes),
            style: textTheme.bodyMedium,
          ),
          _SummaryItem(
            label: 'Completed',
            value: _formatDuration(summary.completedMinutes),
            style: textTheme.bodyMedium?.copyWith(color: Colors.green.shade400),
          ),
          _SummaryItem(
            label: 'Free',
            value: _formatDuration(summary.freeMinutes),
            style: textTheme.bodyMedium,
          ),
          _SummaryItem(
            label: 'Utilization',
            value:
                '${(summary.utilizationPercentage * 100).toStringAsFixed(1)}%',
            style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? style;

  const _SummaryItem({required this.label, required this.value, this.style});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$label: ', style: Theme.of(context).textTheme.bodySmall),
        Text(value, style: style),
      ],
    );
  }
}
