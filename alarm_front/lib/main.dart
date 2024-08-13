import 'package:alarm_front/config/routers.dart';
import 'package:alarm_front/config/theme.dart';
import 'package:alarm_front/di/main_di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
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
}
