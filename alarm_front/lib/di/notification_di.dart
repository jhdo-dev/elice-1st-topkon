import 'package:alarm_front/data/datasources/notification_datasource.dart';
import 'package:alarm_front/data/repositories/notification_repo_impl.dart';
import 'package:alarm_front/domain/repositories/notification_repo.dart';
import 'package:alarm_front/domain/usecases/notification/cancel_notification_usecase.dart';
import 'package:alarm_front/domain/usecases/notification/notification_usecases.dart';
import 'package:alarm_front/domain/usecases/notification/schedule_notification_usecase.dart';
import 'package:alarm_front/presentation/bloc/notification/notification_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationDi {
  static Future<List<RepositoryProvider>> getRepositoryProvider({
    required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  }) async {
    final notificationDatasource =
        await NotificationDatasource(flutterLocalNotificationsPlugin);
    final notificationRepository = NotificationRepoImpl(notificationDatasource);
    final notificationUsecase = NotificationUsecases(
        scheduleNotificationUseCase:
            ScheduleNotificationUseCase(notificationRepository),
        cancelNotificationUseCase:
            CancelNotificationUseCase(notificationRepository));

    return [
      RepositoryProvider<NotificationDatasource>.value(
          value: notificationDatasource),
      RepositoryProvider<NotificationRepo>.value(value: notificationRepository),
      RepositoryProvider<NotificationUsecases>.value(
          value: notificationUsecase),
    ];
  }

  static BlocProvider getBlocProvider() {
    return BlocProvider<NotificationBloc>(
      create: (context) => NotificationBloc(
        notificationUsecases: RepositoryProvider.of(context),
      ),
    );
  }
}
