import 'package:alarm_front/domain/entities/topic.dart';
import 'package:dartz/dartz.dart';

abstract class TopicRepo {
  Future<Either<String, List<Topic>>> getAllTopics();
  Future<Either<String, Unit>> createTopic({required String topicName});
  Future<Either<String, Unit>> deleteTopic({required int topicId});
}
