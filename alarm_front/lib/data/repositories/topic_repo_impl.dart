import 'package:alarm_front/data/datasources/topic_datasource.dart';
import 'package:alarm_front/domain/entities/topic.dart';
import 'package:alarm_front/domain/repositories/topic_repo.dart';
import 'package:dartz/dartz.dart';

class TopicRepoImpl implements TopicRepo {
  final TopicDatasource datasource;
  TopicRepoImpl({
    required this.datasource,
  });

  @override
  Future<Either<String, List<Topic>>> getAllTopics() async {
    final result = await datasource.getAllTopic();
    return result.fold(
      (error) => Left(error),
      (topics) => Right(topics.map((model) => model.toEntity()).toList()),
    );
  }

  @override
  Future<Either<String, Topic>> createTopic({required String topicName}) async {
    final result = await datasource.createTopic(topicName: topicName);

    return result.fold(
      (error) => Left(error),
      (unit) => Right(unit.toEntity()),
    );
  }

  @override
  Future<Either<String, Unit>> deleteTopic({required int topicId}) async {
    final result = await datasource.deleteTopic(topicId: topicId);

    return result.fold(
      (error) => Left(error),
      (unit) => Right(unit),
    );
  }
}
