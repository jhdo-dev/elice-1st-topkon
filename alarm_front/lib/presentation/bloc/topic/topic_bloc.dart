import 'package:alarm_front/domain/entities/topic.dart';
import 'package:alarm_front/domain/usecases/topic/topic_usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'topic_event.dart';
part 'topic_state.dart';

class TopicBloc extends Bloc<TopicEvent, TopicState> {
  final TopicUsecases topicUsecases;

  TopicBloc({required this.topicUsecases}) : super(TopicInitial()) {
    on<LoadTopicsEvent>(_onLoadTopics);
  }

  Future<void> _onLoadTopics(
      LoadTopicsEvent event, Emitter<TopicState> emit) async {
    emit(TopicLoading());

    final Either<String, List<Topic>> result =
        await topicUsecases.getTopicUsecase();

    result.fold(
      (failure) => emit(TopicError(failure)),
      (topics) => emit(TopicLoaded(topics)),
    );
  }
}
