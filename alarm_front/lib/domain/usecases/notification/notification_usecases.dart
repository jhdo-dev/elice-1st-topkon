import 'package:alarm_front/domain/usecases/notification/cancel_notification_usecase.dart';
import 'package:alarm_front/domain/usecases/notification/schedule_notification_usecase.dart';

class NotificationUsecases {
  final ScheduleNotificationUseCase scheduleNotificationUseCase;
  final CancelNotificationUseCase cancelNotificationUseCase;

  NotificationUsecases({
    required this.scheduleNotificationUseCase,
    required this.cancelNotificationUseCase,
  });
}
