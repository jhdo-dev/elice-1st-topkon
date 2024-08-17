part of 'room_bloc.dart';

@immutable
sealed class RoomEvent extends Equatable {}

class CreateRoomEvent extends RoomEvent {
  final int topicId;
  final String roomName;
  final int playerId;
  final String startTime;
  final String endTime;

  CreateRoomEvent({
    required this.topicId,
    required this.roomName,
    required this.playerId,
    required this.startTime,
    required this.endTime,
  });

  @override
  List<Object> get props => [topicId, roomName, playerId, startTime, endTime];
}

final class LoadRoomEvent extends RoomEvent {
  final int? topicId;

  LoadRoomEvent({this.topicId});
  @override
  List<Object?> get props => [topicId];
}

final class ReloadRoomEvent extends RoomEvent {
  final int topicId;

  ReloadRoomEvent(this.topicId);
  @override
  List<Object> get props => [topicId];
}
