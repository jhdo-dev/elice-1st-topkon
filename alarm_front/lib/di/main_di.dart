import 'package:alarm_front/di/bottom_nav_di.dart';
import 'package:alarm_front/di/login_di.dart';
import 'package:alarm_front/di/notification_di.dart';
import 'package:alarm_front/di/room_di.dart';
import 'package:alarm_front/di/topic_di.dart';
import 'package:alarm_front/di/user_di.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class MainDi {
  static Future<List<RepositoryProvider>> getRepositoryProvider({
    required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  }) async {
    final dio = Dio();
    final googleSignIn = GoogleSignIn();
    final facebookAuth = FacebookAuth.instance;

    List<RepositoryProvider> topicRepositoryProvider =
        await TopicDi.getRepositoryProvider(dio: dio);
    List<RepositoryProvider> userRepositoryProvider =
        await UserDi.getRepositoryProvider(dio: dio);
    List<RepositoryProvider> roomRepositoryProvider =
        await RoomDi.getRepositoryProvider(dio: dio);
    List<RepositoryProvider> loginRepositoryProvider =
        await LoginDi.getRepositoryProvider(
            googleSignIn: googleSignIn, facebookAuth: facebookAuth);
    List<RepositoryProvider> notificationRepositoryProvider =
        await NotificationDi.getRepositoryProvider(
            flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin);

    return [
      ...topicRepositoryProvider,
      ...userRepositoryProvider,
      ...roomRepositoryProvider,
      ...loginRepositoryProvider,
      ...notificationRepositoryProvider,
    ];
  }

  static List<BlocProvider> getBlocProvider() {
    return [
      BottomNavDi.getBlocProvider(),
      ...TopicDi.getBlocProvider(),
      ...UserDi.getBlocProvider(),
      LoginDi.getBlocProvider(),
      ...RoomDi.getBlocProvider(),
      NotificationDi.getBlocProvider(),
    ];
  }
}
