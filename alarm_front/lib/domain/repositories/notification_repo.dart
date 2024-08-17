import 'package:alarm_front/domain/entities/notification_schedule.dart';

abstract class NotificationRepo {
  Future<void> scheduleNotification(NotificationSchedule notificationSchedule);
  Future<void> cancelNotification(int id);
}
