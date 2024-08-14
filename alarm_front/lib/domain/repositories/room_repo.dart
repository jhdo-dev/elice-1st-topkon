import 'package:dartz/dartz.dart';

abstract class RoomRepo {
  Future<Either<String, Unit>> createRoom({
    required int topicId,
    required String roomName,
    required int playerId,
    required String startTime,
    required String endTime,
  });
}
