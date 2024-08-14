import 'package:alarm_front/data/datasources/room_datasource.dart';
import 'package:alarm_front/domain/repositories/room_repo.dart';
import 'package:dartz/dartz.dart';

class RoomRepoImpl extends RoomRepo {
  final RoomDatasource datasource;

  RoomRepoImpl({required this.datasource});

  @override
  Future<Either<String, Unit>> createRoom({
    required int topicId,
    required String roomName,
    required int playerId,
    required String startTime,
    required String endTime,
  }) async {
    final result = await datasource.cerateRoom(
      topicId: topicId,
      roomName: roomName,
      playerId: playerId,
      startTime: startTime,
      endTime: endTime,
    );

    return result.fold(
      (error) => Left(error),
      (unit) => Right(unit),
    );
  }
}
