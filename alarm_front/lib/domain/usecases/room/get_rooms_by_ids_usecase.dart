import 'package:alarm_front/domain/entities/room.dart';
import 'package:alarm_front/domain/repositories/room_repo.dart';
import 'package:dartz/dartz.dart';

class GetRoomsByIdsUsecase {
  final RoomRepo repo;
  GetRoomsByIdsUsecase({
    required this.repo,
  });

  Future<Either<String, List<Room>>> call(List<int> roomIds) async {
    return await repo.getRoomsByIds(roomIds);
  }
}
