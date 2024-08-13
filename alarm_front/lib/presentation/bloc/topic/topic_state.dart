part of 'topic_bloc.dart';

@immutable
sealed class TopicState {}

final class TopicInitial extends TopicState {}

final class TopicLoading extends TopicState {}

final class TopicLoaded extends TopicState {
  final List<Topic> topics;

  TopicLoaded(this.topics);
}

final class TopicError extends TopicState {
  final String message;

  TopicError(this.message);
}
