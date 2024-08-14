import 'package:alarm_front/domain/repositories/topic_repo.dart';
import 'package:dartz/dartz.dart';

class CreateTopicUsecase {
  final TopicRepo repo;
  CreateTopicUsecase({
    required this.repo,
  });

  Future<Either<String, Unit>> call({required String topicName}) async {
    return await repo.createTopic(topicName: topicName);
  }
}
