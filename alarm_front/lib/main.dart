import 'package:alarm_front/config/routers.dart';
import 'package:alarm_front/config/theme.dart';
import 'package:alarm_front/data/datasources/local_datasource.dart';
import 'package:alarm_front/di/main_di.dart';
import 'package:alarm_front/presentation/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final user = await LocalDatasource.getUserInfo();
  print("main -----> $user");
  final bool saveLocal = user != null;

  final routers = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    initialLocation: saveLocal ? '/roomList' : '/login',
    routes: appRoutes,
  );

  List<RepositoryProvider> repositoryProviders =
      await MainDi.getRepositoryProvider();

  runApp(
    //* 리포지토리 연결
    MultiRepositoryProvider(
      providers: repositoryProviders,
      //* Bloc 연결
      child: MultiBlocProvider(
        providers: MainDi.getBlocProvider(),
        child: AlarmApp(
          routers: routers,
        ),
      ),
    ),
  );
}

class AlarmApp extends StatelessWidget {
  const AlarmApp({
    super.key,
    required this.routers,
  });
  final GoRouter routers;

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
          routerConfig: routers,
        );
      },
    );
  }
}
