import 'package:alarm_front/domain/entities/notification_schedule.dart';
import 'package:alarm_front/domain/usecases/notification/notification_usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationUsecases notificationUsecases;

  NotificationBloc({
    required this.notificationUsecases,
  }) : super(NotificationInitial()) {
    on<ScheduleNotificationEvent>((event, emit) async {
      await notificationUsecases
          .scheduleNotificationUseCase(event.notificationSchedule);
      emit(NotificationScheduled());
    });

    on<CancelNotificationEvent>((event, emit) async {
      await notificationUsecases.cancelNotificationUseCase(event.id);
      emit(NotificationInitial());
    });
  }
}
