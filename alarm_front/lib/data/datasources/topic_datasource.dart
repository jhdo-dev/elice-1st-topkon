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
        return Left('${response.statusCode} :: 데이터를 불러오는데 실패했습니다.');
      }
    } catch (e) {
      return Left('${e.toString()}');
    }
  }
}
