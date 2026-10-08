import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:day_planner/providers/planner_provider.dart';

class TimePickerField extends ConsumerWidget {
  final int value;
  final ValueChanged<int?> onChanged;
  final String label;

  const TimePickerField({
    super.key,
    required this.value,
    required this.onChanged,
    this.label = 'Start Time',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final is24Hour = ref.watch(plannerProvider).value?.settings.use24HourFormat ?? false;
    
    final hours = (value ~/ 60) % 24;
    final mins = value % 60;
    
    final String timeStr;
    if (is24Hour) {
      timeStr = '${hours.toString().padLeft(2, '0')}:${mins.toString().padLeft(2, '0')}';
    } else {
      final ampm = hours >= 12 ? 'PM' : 'AM';
      final h12 = hours == 0 ? 12 : (hours > 12 ? hours - 12 : hours);
      timeStr = '${h12.toString().padLeft(2, '0')}:${mins.toString().padLeft(2, '0')} $ampm';
    }

    return TextFormField(
      readOnly: true,
      controller: TextEditingController(text: timeStr),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        suffixIcon: const Icon(Icons.access_time),
      ),
      onTap: () async {
        final initialTime = TimeOfDay(hour: hours, minute: mins);
        final picked = await showTimePicker(
          context: context,
          initialTime: initialTime,
          builder: (BuildContext context, Widget? child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: is24Hour),
              child: child!,
            );
          },
        );
        if (picked != null) {
          onChanged(picked.hour * 60 + picked.minute);
        }
      },
    );
  }
}
