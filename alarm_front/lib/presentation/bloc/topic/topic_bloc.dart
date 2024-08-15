import 'package:alarm_front/domain/entities/topic.dart';
import 'package:alarm_front/domain/usecases/topic/topic_usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'topic_event.dart';
part 'topic_state.dart';

class LoadTopicBloc extends Bloc<TopicEvent, TopicState> {
  final TopicUsecases topicUsecases;

  LoadTopicBloc({required this.topicUsecases}) : super(GetTopicInitial()) {
    on<LoadTopicsEvent>(
      (event, emit) async {
        emit(GetTopicLoading());

        final Either<String, List<Topic>> result =
            await topicUsecases.getTopicUsecase();
        result.fold(
          (failure) => emit(GetTopicError(failure)),
          (topics) => emit(GetTopicLoaded(topics)),
        );
      },
    );
  }
}

class CreateTopicBloc extends Bloc<TopicEvent, TopicState> {
  final TopicUsecases topicUsecases;
  final LoadTopicBloc loadTopicBloc;

  CreateTopicBloc({
    required this.topicUsecases,
    required this.loadTopicBloc,
  }) : super(CreateTopicInitial()) {
    on<CreateTopicsEvent>(
      (event, emit) async {
        emit(CreateTopicLoading());

        final Either<String, Topic> result =
            await topicUsecases.createTopicUsecase(topicName: event.topicName);
        result.fold(
          (failure) => emit(CreateTopicError(failure)),
          (topic) {
            if (loadTopicBloc.state is GetTopicLoaded) {
              final currentState = loadTopicBloc.state as GetTopicLoaded;
              final updatedTopics = List<Topic>.from(currentState.topics)
                ..add(topic);
              loadTopicBloc.emit(GetTopicLoaded(updatedTopics));
            }

            emit(CreateTopicSuccess(topic: topic));
          },
        );
      },
    );
  }
}

class DeleteTopicBloc extends Bloc<TopicEvent, TopicState> {
  final TopicUsecases topicUsecases;
  final LoadTopicBloc loadTopicBloc;

  DeleteTopicBloc({
    required this.topicUsecases,
    required this.loadTopicBloc,
  }) : super(DeleteTopicInitial()) {
    on<DeleteTopicsEvent>(
      (event, emit) async {
        emit(DeleteTopicLoading());

        final Either<String, Unit> result =
            await topicUsecases.deleteTopicUsecase(topicId: event.topicId);
        result.fold(
          (failure) => emit(DeleteTopicError(failure)),
          (_) {
            if (loadTopicBloc.state is GetTopicLoaded) {
              final currentState = loadTopicBloc.state as GetTopicLoaded;
              final updatedTopics = currentState.topics
                  .where((topic) => topic.id != event.topicId)
                  .toList();
              loadTopicBloc.emit(GetTopicLoaded(updatedTopics));
            }
            emit(DeleteTopicSuccess());
          },
        );
      },
    );
  }
}
