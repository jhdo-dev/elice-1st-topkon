part of 'topic_bloc.dart';

@immutable
sealed class TopicEvent extends Equatable {}

final class LoadTopicsEvent extends TopicEvent {
  @override
  List<Object> get props => [];
}

class CreateTopicsEvent extends TopicEvent {
  final String topicName;
  CreateTopicsEvent({
    required this.topicName,
  });

  @override
  List<Object> get props => [topicName];
}

class DeleteTopicsEvent extends TopicEvent {
  final int topicId;
  DeleteTopicsEvent({
    required this.topicId,
  });

  @override
  List<Object> get props => [topicId];
}
