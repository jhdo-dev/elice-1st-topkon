import 'package:alarm_front/domain/entities/notification_schedule.dart';
import 'package:alarm_front/domain/repositories/notification_repo.dart';

class ScheduleNotificationUseCase {
  final NotificationRepo repository;

  ScheduleNotificationUseCase(this.repository);

  Future<void> call(NotificationSchedule notificationSchedule) {
    return repository.scheduleNotification(notificationSchedule);
  }
}
