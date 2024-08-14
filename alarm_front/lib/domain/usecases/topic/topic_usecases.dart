import 'package:alarm_front/domain/usecases/topic/create_topic_usecase.dart';
import 'package:alarm_front/domain/usecases/topic/delete_topic_usecase.dart';
import 'package:alarm_front/domain/usecases/topic/get_topic_usecase.dart';

class TopicUsecases {
  final GetTopicUsecase getTopicUsecase;
  final CreateTopicUsecase createTopicUsecase;
  final DeleteTopicUsecase deleteTopicUsecase;
  TopicUsecases({
    required this.getTopicUsecase,
    required this.createTopicUsecase,
    required this.deleteTopicUsecase,
  });
}
