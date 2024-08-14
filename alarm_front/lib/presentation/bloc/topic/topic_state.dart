part of 'topic_bloc.dart';

@immutable
sealed class TopicState {}

final class TopicInitial extends TopicState {}

final class GetTopicLoading extends TopicState {}

final class GetTopicLoaded extends TopicState {
  final List<Topic> topics;
  GetTopicLoaded(this.topics);
}

final class GetTopicError extends TopicState {
  final String message;

  GetTopicError(this.message);
}

final class CreateTopicLoading extends TopicState {}

final class CreateTopicSuccess extends TopicState {}

final class CreateTopicError extends TopicState {
  final String message;

  CreateTopicError(this.message);
}

final class DeleteTopicLoading extends TopicState {}

final class DeleteTopicSuccess extends TopicState {}

final class DeleteTopicError extends TopicState {
  final String message;

  DeleteTopicError(this.message);
}
