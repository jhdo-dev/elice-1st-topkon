import 'package:alarm_front/domain/repositories/notification_repo.dart';

class CancelNotificationUseCase {
  final NotificationRepo repository;

  CancelNotificationUseCase(this.repository);

  Future<void> call(int id) async {
    await repository.cancelNotification(id);
  }
}
