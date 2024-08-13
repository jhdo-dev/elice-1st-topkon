part of 'topic_bloc.dart';

@immutable
sealed class TopicEvent {}

final class LoadTopicsEvent extends TopicEvent {}
