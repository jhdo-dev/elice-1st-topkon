import 'package:alarm_front/presentation/pages/my/my_page.dart';
import 'package:alarm_front/presentation/pages/room_chat/room_chat_page.dart';
import 'package:alarm_front/presentation/pages/room_filter/room_filter_page.dart';
import 'package:alarm_front/presentation/pages/room_list/room_list_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final routers = GoRouter(
  initialLocation: "/roomList",
  navigatorKey: rootNavigatorKey,
  routes: [
    //? 룸 목록 화면
    GoRoute(
      path: "/roomList",
      name: "roomList",
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const RoomListPage(),
      ),
    ),

    //? 룸 목록 화면
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
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const RoomFilterPage(),
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
);
