import 'package:alarm_front/domain/usecases/room/room_usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final RoomUsecases roomUsecases;

  RoomBloc({required this.roomUsecases}) : super(RoomInitial()) {
    on<CreateRoomEvent>(_onCreateRoom);
  }

  Future<void> _onCreateRoom(
      CreateRoomEvent event, Emitter<RoomState> emit) async {
    emit(CreateRoomLoading());

    final Either<String, Unit> result = await roomUsecases.createRoomUsecase(
      endTime: event.endTime,
      playerId: event.playerId,
      roomName: event.roomName,
      startTime: event.startTime,
      topicId: event.topicId,
    );

    result.fold(
      (failure) => emit(CreateRoomError(errorMsg: failure)),
      (_) {
        emit(CreateRoomSuccess());
      },
    );
  }
}
