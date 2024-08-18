import 'package:alarm_front/domain/entities/room.dart';
import 'package:alarm_front/domain/repositories/room_repo.dart';
import 'package:dartz/dartz.dart';

class GetRoomUsecase {
  final RoomRepo repo;
  GetRoomUsecase({
    required this.repo,
  });

  Future<Either<String, List<Room>>> call(int? topicId, int? offset) async {
    return await repo.getRoom(topicId, offset);
  }
}
