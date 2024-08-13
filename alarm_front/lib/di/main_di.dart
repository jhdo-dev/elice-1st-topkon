import 'package:alarm_front/di/bottom_nav_di.dart';
import 'package:alarm_front/di/topic_di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainDi {
  static Future<List<RepositoryProvider>> getRepositoryProvider() async {
    List<RepositoryProvider> topicRepositoryProvider =
        await TopicDi.getRepositoryProvider();

    return [
      ...topicRepositoryProvider,
    ];
  }

  static List<BlocProvider> getBlocProvider() {
    return [
      BottomNavDi.getBlocProvider(),
      ...TopicDi.getBlocProvider(),
    ];
  }
}
