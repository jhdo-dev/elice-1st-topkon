import 'package:alarm_front/domain/entities/topic.dart';
import 'package:alarm_front/domain/usecases/topic/topic_usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'topic_event.dart';
part 'topic_state.dart';

class TopicBloc extends Bloc<TopicEvent, TopicState> {
  final TopicUsecases topicUsecases;

  TopicBloc({required this.topicUsecases}) : super(TopicInitial()) {
    on<LoadTopicsEvent>(_onLoadTopics);
    on<CreateTopicsEvent>(_onCreateTopic);
    on<DeleteTopicsEvent>(_onDeleteTopic);
  }

  Future<void> _onLoadTopics(
      LoadTopicsEvent event, Emitter<TopicState> emit) async {
    emit(GetTopicLoading());

    final Either<String, List<Topic>> result =
        await topicUsecases.getTopicUsecase();
    print("get topic -> $result");
    result.fold(
      (failure) => emit(GetTopicError(failure)),
      (topics) => emit(GetTopicLoaded(topics)),
    );
  }

  Future<void> _onCreateTopic(
      CreateTopicsEvent event, Emitter<TopicState> emit) async {
    emit(GetTopicLoading());

    final Either<String, Unit> result =
        await topicUsecases.createTopicUsecase(topicName: event.topicName);
    print("create topic -> $result");
    result.fold(
      (failure) => emit(CreateTopicError(failure)),
      (_) {
        emit(CreateTopicSuccess());
        add(LoadTopicsEvent());
      },
    );
  }

  Future<void> _onDeleteTopic(
      DeleteTopicsEvent event, Emitter<TopicState> emit) async {
    emit(DeleteTopicLoading());

    final Either<String, Unit> result =
        await topicUsecases.deleteTopicUsecase(topicId: event.topicId);
    print("delete topic -> $result");
    result.fold(
      (failure) => emit(DeleteTopicError(failure)),
      (_) {
        emit(DeleteTopicSuccess());
        add(LoadTopicsEvent());
      },
    );
  }
}
