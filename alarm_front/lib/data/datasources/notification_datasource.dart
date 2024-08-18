import 'package:alarm_front/domain/entities/notification_schedule.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationDatasource {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationDatasource(this.flutterLocalNotificationsPlugin);

  Future<void> scheduleNotification(
      NotificationSchedule notificationSchedule) async {
    final tz.TZDateTime scheduledDate = tz.TZDateTime.from(
      notificationSchedule.scheduleDate,
      tz.local,
    );

    final NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      notificationSchedule.id,
      notificationSchedule.title,
      notificationSchedule.body,
      scheduledDate,
      notificationDetails,
      // androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
