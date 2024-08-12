import 'package:alarm_front/presentation/pages/my/my_page.dart';
import 'package:alarm_front/presentation/pages/room_chat/room_chat_page.dart';
import 'package:alarm_front/presentation/pages/room_filter/room_filter_page.dart';
import 'package:alarm_front/presentation/pages/room_list/room_list_page.dart';
import 'package:go_router/go_router.dart';

final routers = GoRouter(
  initialLocation: "/roomList",
  routes: [
    //? 룸 목록 화면
    GoRoute(
      path: "/roomList",
      name: "roomList",
      pageBuilder: (context, state) => const NoTransitionPage(
        child: RoomListPage(),
      ),
    ),

    //? 룸 목록 화면
    GoRoute(
      path: "/roomChat",
      name: "roomChat",
      pageBuilder: (context, state) => const NoTransitionPage(
        child: RoomChatPage(),
      ),
    ),

    //? 룸 필터 화면
    GoRoute(
      path: "/roomFilter",
      name: "roomFilter",
      pageBuilder: (context, state) => const NoTransitionPage(
        child: RoomFilterPage(),
      ),
    ),

    //? 마이 화면
    GoRoute(
      path: "/my",
      name: "my",
      pageBuilder: (context, state) => const NoTransitionPage(
        child: MyPage(),
      ),
    ),
  ],
);
