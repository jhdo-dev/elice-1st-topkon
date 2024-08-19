import 'package:alarm_front/domain/entities/room.dart';
import 'package:alarm_front/domain/usecases/room/room_usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'room_event.dart';
part 'room_state.dart';

class CreateRoomBloc extends Bloc<RoomEvent, RoomState> {
  final RoomUsecases roomUsecases;

  CreateRoomBloc({required this.roomUsecases}) : super(CreateRoomInitial()) {
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

class LoadRoomBloc extends Bloc<RoomEvent, RoomState> {
  final RoomUsecases roomUsecases;

  LoadRoomBloc({required this.roomUsecases}) : super(GetRoomInitial()) {
    on<LoadRoomEvent>(
      (event, emit) async {
        emit(GetRoomLoading());

        final Either<String, List<Room>> result =
            await roomUsecases.getRoomUsecase(event.topicId, event.offset);

        result.fold(
          (failure) => emit(GetRoomError(failure)),
          (rooms) => emit(GetRoomLoaded(rooms)),
        );
      },
    );
  }
}

class LoadRoomsByIdsBloc extends Bloc<RoomEvent, RoomState> {
  final RoomUsecases roomUsecases;

  LoadRoomsByIdsBloc({required this.roomUsecases})
      : super(GetRoomsByIdsInitial()) {
    on<LoadRoomsByIdsEvent>(
      (event, emit) async {
        emit(GetRoomsByIdsLoading());

        final Either<String, List<Room>> result =
            await roomUsecases.getRoomsByIdsUsecase(event.roomIds);
        print("get rooms by ids -> $result");
        result.fold(
          (failure) => emit(GetRoomsByIdsError(failure)),
          (rooms) => emit(GetRoomsByIdsLoaded(rooms)),
        );
      },
    );
  }
}
