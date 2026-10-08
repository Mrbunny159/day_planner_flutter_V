import 'package:flutter/material.dart';
import 'package:day_planner/shared/models/enums.dart';

class ColorPickerField extends StatelessWidget {
  final ColorTag value;
  final ValueChanged<ColorTag?> onChanged;
  final String label;

  const ColorPickerField({
    super.key,
    required this.value,
    required this.onChanged,
    this.label = 'Color Tag',
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<ColorTag>(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      initialValue: value,
      items: ColorTag.values.map((tag) {
        return DropdownMenuItem(
          value: tag,
          child: Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: _getColorForTag(tag),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.withValues(alpha: 0.5)),
                ),
              ),
              const SizedBox(width: 8),
              Text(_getLabelForTag(tag)),
            ],
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Color _getColorForTag(ColorTag tag) {
    switch (tag) {
      case ColorTag.none:
        return Colors.transparent;
      case ColorTag.red:
        return Colors.red;
      case ColorTag.blue:
        return Colors.blue;
      case ColorTag.green:
        return Colors.green;
      case ColorTag.orange:
        return Colors.orange;
    }
  }

  String _getLabelForTag(ColorTag tag) {
    switch (tag) {
      case ColorTag.none:
        return 'None';
      case ColorTag.red:
        return 'Red';
      case ColorTag.blue:
        return 'Blue';
      case ColorTag.green:
        return 'Green';
      case ColorTag.orange:
        return 'Orange';
    }
  }
}
