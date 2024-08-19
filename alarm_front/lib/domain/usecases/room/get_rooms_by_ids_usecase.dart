import 'package:alarm_front/domain/entities/room.dart';
import 'package:alarm_front/domain/repositories/room_repo.dart';
import 'package:dartz/dartz.dart';

class GetRoomsByIdsUsecase {
  final RoomRepo repo;
  GetRoomsByIdsUsecase({
    required this.repo,
  });

  Future<Either<String, List<Room>>> call(List<int> roomIds) async {
    if (roomIds.isEmpty) {
      // 빈 리스트인 경우 즉시 빈 결과를 반환
      return Right([]);
    }
    return await repo.getRoomsByIds(roomIds);
  }
}
