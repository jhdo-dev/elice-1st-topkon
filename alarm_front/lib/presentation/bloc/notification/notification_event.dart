part of 'notification_bloc.dart';

@immutable
sealed class NotificationEvent {}

class ScheduleNotificationEvent extends NotificationEvent {
  final NotificationSchedule notificationSchedule;

  ScheduleNotificationEvent(this.notificationSchedule);
}

class CancelNotificationEvent extends NotificationEvent {
  final int id;
  CancelNotificationEvent(this.id);
}
