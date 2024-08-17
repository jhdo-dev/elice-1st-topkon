import 'package:alarm_front/presentation/bloc/room/room_bloc.dart';
import 'package:alarm_front/presentation/pages/room_list/widgets/chat_room.dart';
import 'package:alarm_front/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomListPage extends StatefulWidget {
  RoomListPage({super.key});

  @override
  State<RoomListPage> createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> {
  // 예시로 채팅방 목록 데이터를 생성

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
              final room = state.rooms[index];
              return ChatRoom(
                subjectName: room.topicName,
                roomName: room.roomName,
                roomStartDate: room.getFormattedStartTime(),
                roomEndDate: room.getFormattedEndTime(),
                id: room.id,
              );
            },
          );
        }
        return SizedBox();
      },
    );
  }
}
