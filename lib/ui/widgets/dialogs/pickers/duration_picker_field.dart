import 'package:flutter/material.dart';

class DurationPickerField extends StatelessWidget {
  final int value;
  final ValueChanged<int?> onChanged;
  final String label;

  const DurationPickerField({
    super.key,
    required this.value,
    required this.onChanged,
    this.label = 'Duration',
  });

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<int>> items = [];

    // Generate up to 8 hours (480 minutes) in 15 min increments
    for (int min = 15; min <= 480; min += 15) {
      String textLabel;
      if (min < 60) {
        textLabel = '$min minutes';
      } else {
        final hours = min ~/ 60;
        final mins = min % 60;
        if (mins == 0) {
          textLabel = hours == 1 ? '1 hour' : '$hours hours';
        } else {
          textLabel = '$hours hr $mins min';
        }
      }

      items.add(DropdownMenuItem(value: min, child: Text(textLabel)));
    }

    // Handle edge case where value might not be a multiple of 15
    if (!items.any((item) => item.value == value)) {
      items.insert(
        0,
        DropdownMenuItem(value: value, child: Text('$value min (Custom)')),
      );
    }

    return DropdownButtonFormField<int>(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      initialValue: value,
      items: items,
      menuMaxHeight: 320,
      onChanged: onChanged,
      validator: (val) {
        if (val == null) return 'Please select a duration';
        if (val <= 0) return 'Duration must be positive';
        return null;
      },
    );
  }
}
