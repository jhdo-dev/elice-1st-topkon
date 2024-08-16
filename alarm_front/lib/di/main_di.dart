import 'package:alarm_front/di/bottom_nav_di.dart';
import 'package:alarm_front/di/login_di.dart';
import 'package:alarm_front/di/room_di.dart';
import 'package:alarm_front/di/topic_di.dart';
import 'package:alarm_front/di/user_di.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainDi {
  static Future<List<RepositoryProvider>> getRepositoryProvider() async {
    final dio = Dio();
    final googleSignIn = GoogleSignIn();

    List<RepositoryProvider> topicRepositoryProvider =
        await TopicDi.getRepositoryProvider(dio: dio);
    List<RepositoryProvider> userRepositoryProvider =
        await UserDi.getRepositoryProvider(dio: dio);
    List<RepositoryProvider> roomRepositoryProvider =
        await RoomDi.getRepositoryProvider(dio: dio);
    List<RepositoryProvider> loginRepositoryProvider =
        await LoginDi.getRepositoryProvider(googleSignIn: googleSignIn);

    return [
      ...topicRepositoryProvider,
      ...userRepositoryProvider,
      ...roomRepositoryProvider,
      ...loginRepositoryProvider,
    ];
  }

  static List<BlocProvider> getBlocProvider() {
    return [
      BottomNavDi.getBlocProvider(),
      ...TopicDi.getBlocProvider(),
      ...UserDi.getBlocProvider(),
      LoginDi.getBlocProvider(),
      ...RoomDi.getBlocProvider(),
    ];
  }
}
