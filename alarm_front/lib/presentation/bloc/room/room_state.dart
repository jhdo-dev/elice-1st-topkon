part of 'room_bloc.dart';

@immutable
sealed class RoomState {}

final class CreateRoomInitial extends RoomState {}

final class CreateRoomLoading extends RoomState {}

final class CreateRoomSuccess extends RoomState {}

final class CreateRoomError extends RoomState {
  final String errorMsg;

  CreateRoomError({required this.errorMsg});
}

final class GetRoomInitial extends RoomState {}

final class GetRoomLoading extends RoomState {}

final class GetRoomLoaded extends RoomState {
  final List<Room> rooms;
  GetRoomLoaded(this.rooms);
}

final class GetRoomError extends RoomState {
  final String message;

  GetRoomError(this.message);
}

final class GetRoomsByIdsInitial extends RoomState {}

final class GetRoomsByIdsLoading extends RoomState {}

final class GetRoomsByIdsLoaded extends RoomState {
  final List<Room> rooms;
  GetRoomsByIdsLoaded(this.rooms);
}

final class GetRoomsByIdsError extends RoomState {
  final String message;

  GetRoomsByIdsError(this.message);
}
