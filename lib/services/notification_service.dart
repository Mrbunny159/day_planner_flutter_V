import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:day_planner/shared/models/task_model.dart';
import 'package:day_planner/shared/models/enums.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;

  Future<void> init() async {
    if (_isInitialized) return;

    if (!kIsWeb) {
      tz.initializeTimeZones();
      try {
        final timeZoneInfo = await FlutterTimezone.getLocalTimezone();
        tz.setLocalLocation(tz.getLocation(timeZoneInfo.identifier));
      } catch (e) {
        debugPrint('Could not set local timezone: $e');
      }
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _notificationsPlugin.initialize(initializationSettings);
    
    // Request permissions for Android 13+
    if (!kIsWeb) {
      final androidImplementation =
          _notificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      if (androidImplementation != null) {
        await androidImplementation.requestNotificationsPermission();
        await androidImplementation.requestExactAlarmsPermission();
      }
    }

    _isInitialized = true;
  }

  Future<void> showImmediate(String title, String body, {int id = 0}) async {
    if (!_isInitialized) return;

    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'planner_reminders',
      'Planner Reminders',
      channelDescription: 'Reminders for your tasks and breaks',
      importance: Importance.max,
      priority: Priority.high,
    );
    
    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    await _notificationsPlugin.show(id, title, body, platformDetails);
  }

  Future<void> scheduleReminders(List<Task> tasks, DateTime date) async {
    if (!_isInitialized || kIsWeb) return;

    // Cancel previously scheduled notifications
    await _notificationsPlugin.cancelAll();

    final now = DateTime.now();

    for (final task in tasks) {
      if (task.completed) continue;

      // Calculate task start time
      final taskTime = DateTime(date.year, date.month, date.day, task.startMinute ~/ 60, task.startMinute % 60);
      
      // Calculate 1 hour before
      final reminderTime = taskTime.subtract(const Duration(hours: 1));

      // Schedule only if it's in the future
      if (reminderTime.isAfter(now)) {
        final tz.TZDateTime scheduledDate = tz.TZDateTime.from(reminderTime, tz.local);

        final title = task.type == BlockType.task ? 'Upcoming Task' : 'Upcoming Break';
        final body = '${task.name} starts in 1 hour!';

        try {
          await _notificationsPlugin.zonedSchedule(
            task.id.hashCode,
            title,
            body,
            scheduledDate,
            const NotificationDetails(
              android: AndroidNotificationDetails(
                'planner_reminders',
                'Planner Reminders',
                channelDescription: 'Reminders for your tasks and breaks',
                importance: Importance.max,
                priority: Priority.high,
              ),
              iOS: DarwinNotificationDetails(),
            ),
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime,
          );
        } catch (e) {
          debugPrint('Failed to schedule notification for ${task.name}: $e');
        }
      }
    }
  }
}

final notificationService = NotificationService();
