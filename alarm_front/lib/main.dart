import 'package:alarm_front/config/routers.dart';
import 'package:alarm_front/config/theme.dart';
import 'package:alarm_front/di/main_di.dart';
import 'package:alarm_front/presentation/bloc/user/user_bloc.dart';
import 'package:alarm_front/utils/uuid_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  List<RepositoryProvider> repositoryProviders =
      await MainDi.getRepositoryProvider();

  runApp(
    //* 리포지토리 연결
    MultiRepositoryProvider(
      providers: repositoryProviders,
      //* Bloc 연결
      child: MultiBlocProvider(
        providers: MainDi.getBlocProvider(),
        child: const AlarmApp(),
      ),
    ),
  );
}

class AlarmApp extends StatelessWidget {
  const AlarmApp({super.key});

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    _initializeUuid(userBloc);

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
          routerConfig: routers,
        );
      },
    );
  }

  Future<void> _initializeUuid(UserBloc userBloc) async {
    final prefs = await SharedPreferences.getInstance();
    String? uuid = prefs.getString('user_uuid');

    if (uuid == null || uuid.isEmpty) {
      //* UUID가 없다면 생성하고 로컬에 저장한 후 이벤트 디스패치
      uuid = UuidGenerator.generateUuid();
      await prefs.setString('user_uuid', uuid);
      userBloc.add(CreateUserEvent(uuid: uuid));
    } else {
      //* UUID가 이미 존재하면 이벤트를 실행하지 않음
      print('UUID already exists: $uuid');
    }
  }
}
