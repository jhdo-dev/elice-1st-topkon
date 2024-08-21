import 'package:alarm_front/data/datasources/room_datasource.dart';
import 'package:alarm_front/domain/entities/room.dart';
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
    required String playerPhotoUrl,
  }) async {
    final result = await datasource.createRoom(
      topicId: topicId,
      roomName: roomName,
      playerId: playerId,
      startTime: startTime,
      endTime: endTime,
      player_photoUrl: playerPhotoUrl,
    );

    return result.fold(
      (error) => Left(error),
      (unit) => Right(unit),
    );
  }

  @override
  Future<Either<String, List<Room>>> getRoom(int? topicId, int? offset) async {
    final result = await datasource.getRoom(topicId, offset);
    return result.fold(
      (error) => Left(error),
      (topics) => Right(topics.map((model) => model.toEntity()).toList()),
    );
  }

  @override
  Future<Either<String, List<Room>>> getRoomsByIds(List<int> roomIds) async {
    final result = await datasource.getRoomsByIds(roomIds);
    return result.fold(
      (error) => Left(error),
      (topics) => Right(topics.map((model) => model.toEntity()).toList()),
    );
  }
}
