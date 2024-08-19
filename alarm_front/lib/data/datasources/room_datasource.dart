import 'package:alarm_front/config/constants.dart';
import 'package:alarm_front/data/models/room_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class RoomDatasource {
  final Dio dio;
  RoomDatasource({required this.dio});

  Future<Either<String, Unit>> createRoom({
    required int topicId,
    required String roomName,
    required int playerId,
    required String startTime,
    required String endTime,
  }) async {
    try {
      final response =
          await dio.post("${Constants.baseUrl}/room/create", data: {
        "topicId": topicId,
        "roomName": roomName,
        "playerId": playerId,
        "startTime": startTime,
        "endTime": endTime,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(unit);
      } else {
        return Left('${response.statusCode} :: room 데이터를 추가하는데 실패했습니다.');
      }
    } catch (e) {
      return Left('${e.toString()}');
    }
  }

  Future<Either<String, List<RoomModel>>> getRoom(
      int? topicId, int? offset) async {
    try {
      final response = await dio.post("${Constants.baseUrl}/room/list", data: {
        "limit": 10,
        "offset": offset,
        "topicId": topicId == -1 ? null : topicId,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        final roomList = data['rooms'] as List<dynamic>;
        // return Right(rooms);
        final List<RoomModel> rooms =
            roomList.map((item) => RoomModel.fromJson(item)).toList();
        return Right(rooms);
      } else {
        return Left('${response.statusCode} :: 방 정보를 가져오는 데 실패했습니다.');
      }
    } catch (e) {
      return Left('${e.toString()}');
    }
  }

  Future<Either<String, List<RoomModel>>> getRoomsByIds(
      List<int> roomIds) async {
    try {
      final response = await dio.post("${Constants.baseUrl}/room/ids", data: {
        "roomIds": roomIds,
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final roomList = response.data as List<dynamic>;
        final List<RoomModel> rooms =
            roomList.map((item) => RoomModel.fromJson(item)).toList();
        print('rooms ------> $rooms');
        return Right(rooms);
      } else {
        return Left('${response.statusCode} :: 방 정보를 가져오는 데 실패했습니다.');
      }
    } catch (e) {
      return Left('${e.toString()}');
    }
  }
}
