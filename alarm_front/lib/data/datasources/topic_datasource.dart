import 'package:alarm_front/config/constants.dart';
import 'package:alarm_front/data/models/topic_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class TopicDatasource {
  final Dio dio;
  TopicDatasource({
    required this.dio,
  });

  Future<Either<String, List<TopicModel>>> getAllTopic() async {
    try {
      final response = await dio.get("${Constants.baseUrl}/topic/list");

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data as List<dynamic>;

        final topics = data.map((item) => TopicModel.fromJson(item)).toList();
        return Right(topics);
      } else {
        return Left('${response.statusCode} :: topic 데이터를 불러오는데 실패했습니다.');
      }
    } catch (e) {
      return Left('${e.toString()}');
    }
  }

  Future<Either<String, TopicModel>> createTopic(
      {required String topicName}) async {
    try {
      final response = await dio.post(
        "${Constants.baseUrl}/topic/create",
        data: {
          "topicName": topicName,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data['topic'] as Map<String, dynamic>;

        final topic = TopicModel.fromJson(data);

        return Right(topic);
      } else {
        return Left('${response.statusCode} :: topic 데이터를 추가하는데 실패했습니다.');
      }
    } catch (e) {
      return Left('${e.toString()}');
    }
  }

  Future<Either<String, Unit>> deleteTopic({required int topicId}) async {
    try {
      final response = await dio.delete(
        "${Constants.baseUrl}/topic/delete",
        data: {
          "topicId": topicId,
        },
      );

      if (response.statusCode == 200) {
        return Right(unit);
      } else {
        return Left('${response.statusCode} :: topic 데이터를 삭제하는데 실패했습니다.');
      }
    } catch (e) {
      return Left('${e.toString()}');
    }
  }
}
