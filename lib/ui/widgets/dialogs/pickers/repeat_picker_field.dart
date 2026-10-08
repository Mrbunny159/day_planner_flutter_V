import 'package:flutter/material.dart';
import 'package:day_planner/shared/models/enums.dart';

class RepeatPickerField extends StatelessWidget {
  final Repeat value;
  final ValueChanged<Repeat?> onChanged;
  final String label;

  const RepeatPickerField({
    super.key,
    required this.value,
    required this.onChanged,
    this.label = 'Recurring',
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Repeat>(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      initialValue: value,
      items: Repeat.values.map((repeat) {
        return DropdownMenuItem(
          value: repeat,
          child: Text(_getLabelForRepeat(repeat)),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  String _getLabelForRepeat(Repeat repeat) {
    switch (repeat) {
      case Repeat.none:
        return 'None';
      case Repeat.daily:
        return 'Daily';
    }
  }
}
