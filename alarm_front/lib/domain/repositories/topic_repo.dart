import 'package:alarm_front/domain/entities/topic.dart';
import 'package:dartz/dartz.dart';

abstract class TopicRepo {
  Future<Either<String, List<Topic>>> getAllTopics();
}
