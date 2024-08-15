import 'package:dartz/dartz.dart';
import 'package:alarm_front/domain/entities/room.dart';

abstract class RoomRepo {
  Future<Either<String, Unit>> createRoom({
    required int topicId,
    required String roomName,
    required int playerId,
    required String startTime,
    required String endTime,
  });
  Future<Either<String, List<Room>>> getRoom(int? topicId);
}
