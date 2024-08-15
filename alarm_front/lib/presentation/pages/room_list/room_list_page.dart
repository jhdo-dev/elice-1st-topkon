import 'package:alarm_front/di/topic_di.dart';
import 'package:alarm_front/presentation/bloc/room/room_bloc.dart';
import 'package:alarm_front/presentation/pages/room_list/widgets/chat_room.dart';
import 'package:alarm_front/presentation/pages/room_list/widgets/chat_room_tile.dart';
import 'package:alarm_front/presentation/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomListPage extends StatefulWidget {
  RoomListPage({super.key});

  @override
  State<RoomListPage> createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> {
  // 예시로 채팅방 목록 데이터를 생성
  final List<ChatRoom> chatRooms = [
    ChatRoom(
        subjectName: 'Flutter 스터디',
        roomName: '스터디하실 분 모집합니다!',
        roomStartDate: '2024-08-01 09:24',
        roomEndDate: '2024-08-24 18:48'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoadRoomBloc, RoomState>(
      listener: (context, state) {
        if (state is GetRoomError) {
          showCustomSnackbar(context, "방 목록을 가져오는데 실패하였습니다.");
        }
      },
      builder: (context, state) {
        if (state is GetRoomLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is GetRoomLoaded) {
          return ListView.builder(
            itemCount: state.rooms.length,
            itemBuilder: (context, index) {
              return ChatRoom(
                subjectName: 'flutter study',
                roomName: state.rooms[index].roomName,
                roomStartDate: state.rooms[index].getFormattedStartTime(),
                roomEndDate: state.rooms[index].getFormattedEndTime(),
              );
            },
          );
        }
        return SizedBox();
      },
    );
  }
}
