part of 'room_bloc.dart';

@immutable
sealed class RoomState {}

final class RoomInitial extends RoomState {}

final class CreateRoomLoading extends RoomState {}

final class CreateRoomSuccess extends RoomState {}

final class CreateRoomError extends RoomState {
  final String errorMsg;

  CreateRoomError({required this.errorMsg});
}
