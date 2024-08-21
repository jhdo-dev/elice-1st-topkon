import 'package:alarm_front/domain/repositories/room_repo.dart';
import 'package:dartz/dartz.dart';

class CreateRoomUsecase {
  final RoomRepo repo;

  CreateRoomUsecase({required this.repo});

  Future<Either<String, Unit>> call({
    required int topicId,
    required String roomName,
    required int playerId,
    required String startTime,
    required String endTime,
    required String playerPhotoUrl,
  }) async {
    return await await repo.createRoom(
      topicId: topicId,
      roomName: roomName,
      playerId: playerId,
      startTime: startTime,
      endTime: endTime,
      playerPhotoUrl: playerPhotoUrl,
    );
  }
}
