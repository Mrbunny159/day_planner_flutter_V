import 'package:flutter/material.dart';
import 'package:day_planner/shared/models/draft_models.dart';
import 'package:day_planner/ui/widgets/dialogs/pickers/time_picker_field.dart';

class SettingsDialog extends StatefulWidget {
  final SettingsDraft initialDraft;

  const SettingsDialog({super.key, required this.initialDraft});

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  final _formKey = GlobalKey<FormState>();
  late SettingsDraft _draft;

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
      title: const Text('Settings'),
      content: SizedBox(
        width: dialogWidth,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Working Hours',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TimePickerField(
                        label: 'Start Time',
                        value: _draft.dayStartMinute,
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _draft = _draft.copyWith(dayStartMinute: val);
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TimePickerField(
                        label: 'End Time',
                        value: _draft.dayEndMinute,
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _draft = _draft.copyWith(dayEndMinute: val);
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Time Format',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SwitchListTile(
                  title: const Text('Use 12-Hour Format (AM/PM)'),
                  contentPadding: EdgeInsets.zero,
                  value: !_draft.use24HourFormat,
                  onChanged: (val) {
                    setState(() {
                      _draft = _draft.copyWith(use24HourFormat: !val);
                    });
                  },
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
              if (_draft.dayEndMinute <= _draft.dayStartMinute) {
                // Using a local SnackBar isn't great inside an AlertDialog context,
                // but setting a small error text locally is better.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('End time must be after start time'),
                  ),
                );
                return;
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
