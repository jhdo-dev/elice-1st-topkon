import 'package:alarm_front/presentation/pages/login/login_page.dart';
import 'package:alarm_front/presentation/pages/my/my_page.dart';
import 'package:alarm_front/presentation/pages/room_chat/room_chat_page.dart';
import 'package:alarm_front/presentation/pages/room_create/room_create_page.dart';
import 'package:alarm_front/presentation/pages/room_filter/room_filter_page.dart';
import 'package:alarm_front/presentation/pages/room_list/room_list_page.dart';
import 'package:alarm_front/presentation/widgets/shell_component.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

final routers = GoRouter(
  initialLocation: "/login",
  navigatorKey: rootNavigatorKey,
  routes: [
    //? 로그인 화면
    GoRoute(
      path: "/login",
      name: "login",
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: LoginPage(),
      ),
    ),

    //? 공통 화면(앱바 및 바텀네비)
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      pageBuilder: (context, state, child) {
        return NoTransitionPage(
          child: ShellComponent(
            child: child,
          ),
        );
      },
      routes: [
        //? 룸 목록 화면
        GoRoute(
          path: "/roomList",
          name: "roomList",
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: RoomListPage(),
          ),
        ),

        //? 마이 화면
        GoRoute(
          path: "/my",
          name: "my",
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: const MyPage(),
          ),
        ),
      ],
    ),

    //? 룸 채팅 화면
    GoRoute(
      path: "/roomChat",
      name: "roomChat",
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const RoomChatPage(),
      ),
    ),

    //? 룸 필터 화면
    GoRoute(
      path: "/roomFilter",
      name: "roomFilter",
      builder: (context, state) => RoomFilterPage(
        key: state.pageKey,
      ),
    ),

    //? 룸 생성 화면
    GoRoute(
      path: "/roomCreate",
      name: "roomCreate",
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const RoomCreatePage(),
      ),
    ),
  ],
);
