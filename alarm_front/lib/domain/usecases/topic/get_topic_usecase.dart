import 'package:alarm_front/domain/entities/topic.dart';
import 'package:alarm_front/domain/repositories/topic_repo.dart';
import 'package:dartz/dartz.dart';

class GetTopicUsecase {
  final TopicRepo repo;
  GetTopicUsecase({
    required this.repo,
  });

  Future<Either<String, List<Topic>>> call() async {
    return await repo.getAllTopics();
  }
}
