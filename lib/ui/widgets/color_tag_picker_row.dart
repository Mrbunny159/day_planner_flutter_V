import 'package:flutter/material.dart';
import 'package:day_planner/shared/models/enums.dart';

class ColorTagPickerRow extends StatelessWidget {
  final ColorTag selectedTag;
  final ValueChanged<ColorTag> onColorSelected;

  const ColorTagPickerRow({
    super.key,
    required this.selectedTag,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    // We only display the visual color tags
    final tags = [
      ColorTag.none,
      ColorTag.red,
      ColorTag.orange,
      ColorTag.green,
      ColorTag.blue,
    ];

    return Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: tags.map((tag) {
        final isSelected = tag == selectedTag;
        final color = tag.color ?? Colors.transparent;

        return GestureDetector(
          onTap: () => onColorSelected(tag),
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: tag == ColorTag.none ? Colors.grey : Colors.transparent,
                width: 1.5,
              ),
              boxShadow: isSelected
                  ? [
                      const BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
            ),
            child: isSelected
                ? Icon(
                    Icons.check,
                    size: 18,
                    color: tag == ColorTag.none ? Colors.black : Colors.white,
                  )
                : null,
          ),
        );
      }).toList(),
    );
  }
}
