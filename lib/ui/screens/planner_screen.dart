import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:day_planner/providers/planner_provider.dart';
import 'package:day_planner/ui/widgets/timeline_view.dart';
import 'package:day_planner/ui/widgets/summary_bar.dart';
import 'package:day_planner/ui/widgets/dialogs/block_dialog.dart';
import 'package:day_planner/ui/widgets/dialogs/settings_dialog.dart';
import 'package:day_planner/shared/models/draft_models.dart';
import 'package:day_planner/shared/models/enums.dart';
import 'package:day_planner/providers/ui_providers.dart';
import 'package:day_planner/providers/app_error_provider.dart';
import 'package:day_planner/core/database/exceptions.dart';

class UndoIntent extends Intent {
  const UndoIntent();
}

class DeleteIntent extends Intent {
  const DeleteIntent();
}

class EscapeIntent extends Intent {
  const EscapeIntent();
}

class EnterIntent extends Intent {
  const EnterIntent();
}

class PlannerScreen extends ConsumerWidget {
  const PlannerScreen({super.key});

  Future<void> _showAddDialog(
    BuildContext context,
    WidgetRef ref,
    BlockType type,
  ) async {
    final now = DateTime.now();
    final int currentMinutes = now.hour * 60 + now.minute;
    final int roundedMinutes = (currentMinutes / 5).round() * 5;
    
    final draft = BlockDraft(type: type, startMinute: roundedMinutes);
    final result = await showDialog<BlockDraft>(
      context: context,
      builder: (_) => BlockDialog(initialDraft: draft),
    );
    if (result != null) {
      ref.read(plannerProvider.notifier).addBlock(result);
    }
  }

  Future<void> _showSettingsDialog(BuildContext context, WidgetRef ref) async {
    final plannerState = ref.read(plannerProvider);
    plannerState.whenData((planner) async {
      final draft = SettingsDraft(
        dayStartMinute: planner.settings.dayStartMinute,
        dayEndMinute: planner.settings.dayEndMinute,
        use24HourFormat: planner.settings.use24HourFormat,
      );
      final result = await showDialog<SettingsDraft>(
        context: context,
        builder: (_) => SettingsDialog(initialDraft: draft),
      );
      if (result != null) {
        ref.read(plannerProvider.notifier).updateSettings(result);
      }
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plannerState = ref.watch(plannerProvider);
    final hasData = plannerState.value != null;

    return Shortcuts(
      shortcuts: const <ShortcutActivator, Intent>{
        SingleActivator(LogicalKeyboardKey.keyZ, control: true):
            UndoIntent(),
        SingleActivator(LogicalKeyboardKey.keyZ, meta: true):
            UndoIntent(),
        SingleActivator(LogicalKeyboardKey.delete): DeleteIntent(),
        SingleActivator(LogicalKeyboardKey.backspace):
            DeleteIntent(),
        SingleActivator(LogicalKeyboardKey.escape): EscapeIntent(),
        SingleActivator(LogicalKeyboardKey.enter): EnterIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          UndoIntent: CallbackAction<UndoIntent>(
            onInvoke: (UndoIntent intent) {
              ref.read(plannerProvider.notifier).undo();
              return null;
            },
          ),
          DeleteIntent: CallbackAction<DeleteIntent>(
            onInvoke: (DeleteIntent intent) {
              final selectedId = ref.read(selectionProvider);
              if (selectedId != null) {
                ref.read(plannerProvider.notifier).deleteBlock(selectedId);
                ref.read(selectionProvider.notifier).select(null);
              }
              return null;
            },
          ),
          EscapeIntent: CallbackAction<EscapeIntent>(
            onInvoke: (EscapeIntent intent) {
              ref.read(selectionProvider.notifier).select(null);
              return null;
            },
          ),
          EnterIntent: CallbackAction<EnterIntent>(
            onInvoke: (EnterIntent intent) async {
              final selectedId = ref.read(selectionProvider);
              if (selectedId != null) {
                final planner = ref.read(plannerProvider).value;
                if (planner != null) {
                  final task = planner.tasks.firstWhere(
                    (t) => t.id == selectedId,
                    orElse: () => planner.tasks.first,
                  );
                  if (task.id == selectedId) {
                    final draft = BlockDraft(
                      id: task.id,
                      name: task.name,
                      type: task.type,
                      startMinute: task.startMinute,
                      duration: task.duration,
                      colorTag: task.colorTag,
                      recurring: task.recurring,
                    );
                    final result = await showDialog<BlockDraft>(
                      context: context,
                      builder: (_) => BlockDialog(initialDraft: draft, isEditMode: true),
                    );
                    if (result != null) {
                      ref.read(plannerProvider.notifier).editBlock(result);
                    }
                  }
                }
              }
              return null;
            },
          ),
        },
        child: FocusScope(
          autofocus: true,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Day Planner'),
              backgroundColor: Theme.of(context).colorScheme.surface,
              elevation: 0,
            ),
            body: Consumer(
              builder: (context, ref, child) {
                ref.listen<AppErrorState>(appErrorProvider, (previous, next) {
                  if (next.isVisible && next.message != null) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(next.message!),
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 10),
                        action: SnackBarAction(
                          label: 'Retry',
                          onPressed: () {
                            ref.read(appErrorProvider.notifier).dismiss();
                            // Force a save of the current in-memory state
                            ref.read(plannerProvider.notifier).forceSave();
                          },
                        ),
                      ),
                    );
                  }
                });

                return plannerState.when(
                  data: (planner) {
                    return Column(
                      children: [
                        const SummaryBar(),
                        const Divider(height: 1, thickness: 1),
                        Expanded(child: TimelineView(planner: planner)),
                      ],
                    );
                  },
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, stack) {
                    if (error is DatabaseCorruptException) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline, color: Colors.red, size: 48),
                            const SizedBox(height: 16),
                            Text(
                              error.message,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                // TODO: Reset DB logic
                              },
                              child: const Text('Reset Database'),
                            ),
                          ],
                        ),
                      );
                    }
                    return Center(child: Text('Error loading planner: $error'));
                  },
                );
              },
            ),
            bottomNavigationBar: SafeArea(
              bottom: true,
              top: false,
              child: BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.add_task),
                    tooltip: 'Add Task',
                    onPressed: hasData ? () => _showAddDialog(context, ref, BlockType.task) : null,
                  ),
                  IconButton(
                    icon: const Icon(Icons.free_breakfast),
                    tooltip: 'Add Break',
                    onPressed: hasData ? () => _showAddDialog(context, ref, BlockType.breakBlock) : null,
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final selectedId = ref.watch(selectionProvider);
                      return IconButton(
                        icon: const Icon(Icons.delete),
                        tooltip: 'Delete Selected',
                        color: Colors.red,
                        onPressed: selectedId == null
                            ? null
                            : () {
                                ref
                                    .read(plannerProvider.notifier)
                                    .deleteBlock(selectedId);
                                ref
                                    .read(selectionProvider.notifier)
                                    .select(null);
                              },
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.auto_awesome),
                    tooltip: 'Auto Plan',
                    onPressed: () =>
                        ref.read(plannerProvider.notifier).autoPlan(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.clear_all),
                    tooltip: 'Clear All',
                    onPressed: () =>
                        ref.read(plannerProvider.notifier).clearAll(),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    tooltip: 'Settings',
                    onPressed: () => _showSettingsDialog(context, ref),
                  ),
                ],
              ),
            ),
            ),
          ),
        ),
      ),
    );
  }
}
