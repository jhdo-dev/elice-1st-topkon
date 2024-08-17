import 'package:alarm_front/data/datasources/notification_datasource.dart';
import 'package:alarm_front/domain/entities/notification_schedule.dart';
import 'package:alarm_front/domain/repositories/notification_repo.dart';

class NotificationRepoImpl implements NotificationRepo {
  final NotificationDatasource dataSource;

  NotificationRepoImpl(this.dataSource);

  @override
  Future<void> scheduleNotification(NotificationSchedule notificationSchedule) {
    return dataSource.scheduleNotification(notificationSchedule);
  }

  @override
  Future<void> cancelNotification(int id) {
    return dataSource.cancelNotification(id);
  }
}
