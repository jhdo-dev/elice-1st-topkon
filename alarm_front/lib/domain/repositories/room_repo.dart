import 'package:alarm_front/domain/entities/room.dart';
import 'package:dartz/dartz.dart';

abstract class RoomRepo {
  Future<Either<String, Unit>> createRoom({
    required int topicId,
    required String roomName,
    required int playerId,
    required String startTime,
    required String endTime,
    required String playerPhotoUrl,
  });
  Future<Either<String, List<Room>>> getRoom(int? topicId, int? offset);
  Future<Either<String, List<Room>>> getRoomsByIds(List<int> roomIds);
}
