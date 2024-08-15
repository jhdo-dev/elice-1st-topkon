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

final class ReloadRoomInitial extends RoomState {}

final class ReloadRoomLoading extends RoomState {}

final class ReloadRoomLoaded extends RoomState {
  final List<Room> rooms;
  ReloadRoomLoaded(this.rooms);
}

final class ReloadRoomError extends RoomState {
  final String message;

  ReloadRoomError(this.message);
}
