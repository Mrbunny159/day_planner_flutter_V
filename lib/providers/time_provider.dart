import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:day_planner/providers/planner_provider.dart';
import 'package:day_planner/services/notification_service.dart';
import 'package:day_planner/shared/models/enums.dart';

/// Exposes the current time as a DateTime object, updating every minute.
class CurrentTimeNotifier extends Notifier<DateTime> {
  Timer? _timer;

  @override
  DateTime build() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      final now = DateTime.now();
      state = now;

      if (kIsWeb) {
        final plannerState = ref.read(plannerProvider).value;
        if (plannerState != null) {
          final currentMin = now.hour * 60 + now.minute;
          for (final task in plannerState.tasks) {
            if (!task.completed && task.startMinute - currentMin == 60) {
              final title = task.type == BlockType.task ? 'Upcoming Task' : 'Upcoming Break';
              notificationService.showImmediate(title, '${task.name} starts in 1 hour!');
            }
          }
        }
      }
    });

    ref.onDispose(() {
      _timer?.cancel();
    });

    return DateTime.now();
  }
}

final timeProvider = NotifierProvider<CurrentTimeNotifier, DateTime>(() {
  return CurrentTimeNotifier();
});

/// A derived provider that converts the current time into `total minutes since midnight`.
final currentMinuteProvider = Provider<int>((ref) {
  final time = ref.watch(timeProvider);
  return time.hour * 60 + time.minute;
});
