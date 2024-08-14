import 'package:alarm_front/di/bottom_nav_di.dart';
import 'package:alarm_front/di/topic_di.dart';
import 'package:alarm_front/di/user_di.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainDi {
  static Future<List<RepositoryProvider>> getRepositoryProvider() async {
    final dio = Dio();

    List<RepositoryProvider> topicRepositoryProvider =
        await TopicDi.getRepositoryProvider(dio: dio);
    List<RepositoryProvider> userRepositoryProvider =
        await UserDi.getRepositoryProvider(dio: dio);

    return [
      ...topicRepositoryProvider,
      ...userRepositoryProvider,
    ];
  }

  static List<BlocProvider> getBlocProvider() {
    return [
      BottomNavDi.getBlocProvider(),
      TopicDi.getBlocProvider(),
      UserDi.getBlocProvider(),
    ];
  }
}
