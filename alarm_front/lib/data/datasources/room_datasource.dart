import 'package:alarm_front/config/constants.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class RoomDatasource {
  final Dio dio;
  RoomDatasource({required this.dio});

  Future<Either<String, Unit>> cerateRoom({
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
}
