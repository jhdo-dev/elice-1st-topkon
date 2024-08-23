import 'package:alarm_front/config/routers.dart';
import 'package:alarm_front/config/theme.dart';
import 'package:alarm_front/data/datasources/local_datasource.dart';
import 'package:alarm_front/di/main_di.dart';
import 'package:alarm_front/presentation/bloc/user/user_bloc.dart';
import 'package:alarm_front/utils/fcm.dart'; // 분리된 FCM 파일
import 'package:alarm_front/utils/notification.dart'; // 분리된 알림 초기화 파일
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  await dotenv.load(fileName: ".env");

  tz.initializeTimeZones();

  final user = await LocalDatasource.getUserInfo();

  final bool saveLocal = user != null;

  final routers = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    initialLocation: saveLocal ? '/roomList' : '/login',
    routes: appRoutes,
  );

  final FlutterLocalNotificationsPlugin local =
      FlutterLocalNotificationsPlugin(); // 인스턴스 생성

  List<RepositoryProvider> repositoryProviders =
      await MainDi.getRepositoryProvider(
    flutterLocalNotificationsPlugin: local,
  );

  KakaoSdk.init(nativeAppKey: dotenv.env['KAKAO_NATIVE_APP_KEY']);
  print(await KakaoSdk.origin);

  runApp(
    //* 리포지토리 연결
    MultiRepositoryProvider(
      providers: repositoryProviders,
      //* Bloc 연결
      child: MultiBlocProvider(
        providers: MainDi.getBlocProvider(),
        child: AlarmApp(
          routers: routers,
          local: local, // 알림 플러그인 전달
        ),
      ),
    ),
  );
}

class AlarmApp extends StatefulWidget {
  const AlarmApp({
    super.key,
    required this.routers,
    required this.local,
  });
  final GoRouter routers;
  final FlutterLocalNotificationsPlugin local;

  @override
  State<AlarmApp> createState() => _AlarmAppState();
}

class _AlarmAppState extends State<AlarmApp> {
  @override
  void initState() {
    super.initState();
    permissionWithNotification(); // 알림 권한 요청 함수
    initialization(widget.local); // 알림 초기화 함수
    initializeFCM(widget.local); // FCM 초기화 함수 호출
  }

  @override
  Widget build(BuildContext context) {
    context.read<UserBloc>().add(GetLocalUserEvent());

    //* 반응형 적용
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        //* 라우터 연결
        return MaterialApp.router(
          //*  테마 설정
          theme: appTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: widget.routers,
        );
      },
    );
  }
}
