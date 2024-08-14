import 'package:alarm_front/domain/repositories/topic_repo.dart';
import 'package:dartz/dartz.dart';

class DeleteTopicUsecase {
  final TopicRepo repo;
  DeleteTopicUsecase({
    required this.repo,
  });

  Future<Either<String, Unit>> call({required int topicId}) async {
    return await repo.deleteTopic(topicId: topicId);
  }
}
