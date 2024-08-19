import 'package:alarm_front/data/datasources/local_datasource.dart';
import 'package:alarm_front/presentation/bloc/room/room_bloc.dart';
import 'package:alarm_front/presentation/pages/my/widgets/my_info_widget.dart';
import 'package:alarm_front/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../room_list/widgets/chat_room.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  void initState() {
    super.initState();
    _loadReservedRooms();
  }

  Future<void> _loadReservedRooms() async {
    final reservedRooms = await LocalDatasource.getReservedRooms();
    if (mounted) {
      // 위젯이 여전히 트리에 있는지 확인
      context
          .read<LoadRoomsByIdsBloc>()
          .add(LoadRoomsByIdsEvent(reservedRooms));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyInfoWidget(),
        const SizedBox(height: 16),
        BlocConsumer<LoadRoomsByIdsBloc, RoomState>(
          listener: (context, state) {
            if (state is GetRoomsByIdsError) {
              if (context.read<LoadRoomsByIdsBloc>().state
                  is! GetRoomsByIdsInitial) {
                showCustomSnackbar(context, "방 목록을 가져오는데 실패하였습니다.");
              }
            }
          },
          builder: (context, state) {
            if (state is GetRoomsByIdsLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is GetRoomsByIdsLoaded) {
              if (state.rooms.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Text(
                      '예약한 방이 없습니다.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                );
              }
              return Expanded(
                child: ListView.builder(
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
                ),
              );
            }
            return SizedBox();
          },
        ),
      ],
    );
  }
}
