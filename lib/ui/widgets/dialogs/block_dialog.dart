import 'package:flutter/material.dart';
import 'package:day_planner/shared/models/draft_models.dart';
import 'package:day_planner/shared/models/enums.dart';
import 'package:day_planner/ui/widgets/dialogs/pickers/time_picker_field.dart';
import 'package:day_planner/ui/widgets/dialogs/pickers/duration_picker_field.dart';
import 'package:day_planner/ui/widgets/dialogs/pickers/color_picker_field.dart';
import 'package:day_planner/ui/widgets/dialogs/pickers/repeat_picker_field.dart';

class BlockDialog extends StatefulWidget {
  final BlockDraft initialDraft;
  final bool isEditMode;

  const BlockDialog({
    super.key,
    required this.initialDraft,
    this.isEditMode = false,
  });

  @override
  State<BlockDialog> createState() => _BlockDialogState();
}

class _BlockDialogState extends State<BlockDialog> {
  final _formKey = GlobalKey<FormState>();
  late BlockDraft _draft;

  @override
  void initState() {
    super.initState();
    _draft = widget.initialDraft;
  }

  @override
  Widget build(BuildContext context) {
    // Determine screen width for responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;
    final dialogWidth = screenWidth > 600 ? 500.0 : screenWidth * 0.9;

    return AlertDialog(
      title: Text(widget.isEditMode ? 'Edit Block' : 'Add Block'),
      content: SizedBox(
        width: dialogWidth,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Segmented Control for Task/Break
                SegmentedButton<BlockType>(
                  segments: const [
                    ButtonSegment(
                      value: BlockType.task,
                      label: Text('Task'),
                      icon: Icon(Icons.check_box),
                    ),
                    ButtonSegment(
                      value: BlockType.breakBlock,
                      label: Text('Break'),
                      icon: Icon(Icons.coffee),
                    ),
                  ],
                  selected: {_draft.type},
                  onSelectionChanged: (Set<BlockType> newSelection) {
                    setState(() {
                      _draft = _draft.copyWith(type: newSelection.first);
                    });
                  },
                ),
                const SizedBox(height: 24),

                // 2. Title Field
                TextFormField(
                  initialValue: _draft.name == 'Untitled' ? '' : _draft.name,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    _draft = _draft.copyWith(name: val.trim());
                  },
                ),
                const SizedBox(height: 16),

                // 3. Description Field
                TextFormField(
                  initialValue: _draft.description,
                  decoration: const InputDecoration(
                    labelText: 'Description (Optional)',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  onChanged: (val) {
                    _draft = _draft.copyWith(description: val.trim());
                  },
                ),
                const SizedBox(height: 16),

                // 4. Time and Duration
                Row(
                  children: [
                    Expanded(
                      child: TimePickerField(
                        value: _draft.startMinute,
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _draft = _draft.copyWith(startMinute: val);
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DurationPickerField(
                        value: _draft.duration,
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _draft = _draft.copyWith(duration: val);
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // 5. Color and Repeat
                Row(
                  children: [
                    Expanded(
                      child: ColorPickerField(
                        value: _draft.colorTag,
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _draft = _draft.copyWith(colorTag: val);
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: RepeatPickerField(
                        value: _draft.recurring,
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _draft = _draft.copyWith(recurring: val);
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (_draft.name.isEmpty) {
                _draft = _draft.copyWith(name: 'Untitled');
              }
              Navigator.of(context).pop(_draft);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
