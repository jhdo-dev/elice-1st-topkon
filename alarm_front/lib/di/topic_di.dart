import 'package:alarm_front/data/datasources/topic_datasource.dart';
import 'package:alarm_front/data/repositories/topic_repo_impl.dart';
import 'package:alarm_front/domain/repositories/topic_repo.dart';
import 'package:alarm_front/domain/usecases/topic/create_topic_usecase.dart';
import 'package:alarm_front/domain/usecases/topic/delete_topic_usecase.dart';
import 'package:alarm_front/domain/usecases/topic/get_topic_usecase.dart';
import 'package:alarm_front/domain/usecases/topic/topic_usecases.dart';
import 'package:alarm_front/presentation/bloc/topic/topic_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopicDi {
  static Future<List<RepositoryProvider>> getRepositoryProvider(
      {required Dio dio}) async {
    final topicDatasourse = TopicDatasource(dio: dio);
    final topicRepository = TopicRepoImpl(datasource: topicDatasourse);
    final topicUsecase = TopicUsecases(
      getTopicUsecase: GetTopicUsecase(repo: topicRepository),
      createTopicUsecase: CreateTopicUsecase(repo: topicRepository),
      deleteTopicUsecase: DeleteTopicUsecase(repo: topicRepository),
    );

    return [
      RepositoryProvider<TopicDatasource>.value(value: topicDatasourse),
      RepositoryProvider<TopicRepo>.value(value: topicRepository),
      RepositoryProvider<TopicUsecases>.value(value: topicUsecase),
    ];
  }

  static BlocProvider getBlocProvider() {
    return BlocProvider<TopicBloc>(
      create: (context) => TopicBloc(
        topicUsecases: RepositoryProvider.of(context),
      ),
    );
  }
}
