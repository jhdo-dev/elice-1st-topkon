import 'dart:math';

import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/data/datasources/local_datasource.dart';
import 'package:alarm_front/domain/entities/notification_schedule.dart';
import 'package:alarm_front/presentation/bloc/notification/notification_bloc.dart';
import 'package:alarm_front/presentation/bloc/room/room_bloc.dart';
import 'package:alarm_front/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ChatRoom extends StatefulWidget {
  final String subjectName;
  final String roomName;
  final String roomStartDate;
  final String roomEndDate;
  final int id;

  ChatRoom({
    super.key,
    required this.subjectName,
    required this.roomName,
    required this.roomStartDate,
    required this.roomEndDate,
    required this.id,
  });

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  bool isRoomActive = false;
  bool isReserve = false;

  @override
  void initState() {
    super.initState();
    _checkRoomStatus();
    _checkReservationStatus();
  }

  void _checkRoomStatus() {
    DateTime scheduleDate = DateTime.parse(widget.roomStartDate);
    setState(() {
      isRoomActive = DateTime.now().isAfter(scheduleDate);
    });
  }

  void _checkReservationStatus() async {
    List<int> reservedRooms = await LocalDatasource.getReservedRooms();

    if (mounted) {
      setState(() {
        isReserve = reservedRooms.contains(widget.id);
      });
    }
  }

  void _handleCancelReservation() async {
    DateTime scheduleDate = DateTime.parse(widget.roomStartDate);

    if (DateTime.now().isBefore(scheduleDate)) {
      context.read<NotificationBloc>().add(CancelNotificationEvent(widget.id));
      LocalDatasource.removeReservedRoom(widget.id);
      LocalDatasource.getReservedRooms();
      final reservedRooms = await LocalDatasource.getReservedRooms();
      context
          .read<LoadRoomsByIdsBloc>()
          .add(LoadRoomsByIdsEvent(reservedRooms));
      setState(() {
        isReserve = false;
      });
      showCustomSnackbar(context, "예약된 알림이 취소되었습니다.");
    } else {
      setState(() {
        isRoomActive = true;
      });
      showCustomSnackbar(context, "시작 시간이 지났습니다. 취소할 수 없습니다.");
    }
  }

  void _handleReserve() {
    DateTime scheduleDate = DateTime.parse(widget.roomStartDate);

    if (DateTime.now().isBefore(scheduleDate)) {
      final notificationSchedule = NotificationSchedule(
        id: widget.id,
        title: "${widget.subjectName} | ${widget.roomName}",
        body: "참여 시간이 되었습니다.",
        scheduleDate: scheduleDate,
      );

      context
          .read<NotificationBloc>()
          .add(ScheduleNotificationEvent(notificationSchedule));
      LocalDatasource.saveReservedRoom(widget.id);
      setState(() {
        isReserve = true;
      });
      showCustomSnackbar(context, "예약되었습니다.");
    } else {
      showCustomSnackbar(context, "시작 시간이 이미 지났습니다. 예약할 수 없습니다.");
    }
  }

  void _handleJoinRoom() {
    DateTime endDate = DateTime.parse(widget.roomEndDate);

    if (DateTime.now().isBefore(endDate)) {
      context.pushNamed(
        "roomChat",
        extra: {
          'roomId': widget.id.toString(),
          'roomName': widget.roomName.toString()
        },
      );
    } else {
      showCustomSnackbar(context, "종료 시간이 지나 참여할 수 없습니다.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
      decoration: BoxDecoration(
        color: AppColors.roomListTileColor,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: Container(
              decoration: BoxDecoration(color: AppColors.profileRandomColor5),
              child: SizedBox(
                width: 70,
                height: 70,
                child: Image.asset(
                  'assets/images/chat_room_default_profile_1.png',
                ),
              ),
            ),
          ),
          const SizedBox(width: 14.0),
          Container(
            width: 1, // 선의 두께
            height: 75, // 선의 높이
            color: AppColors.focusColor, // 선의 색상
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '[${widget.subjectName}]',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                Text(
                  widget.roomName,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  '시작: ${widget.roomStartDate}',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '종료: ${widget.roomEndDate}',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isRoomActive
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.sendMsgBurbleColor,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: _handleJoinRoom,
                      child: const Text('참여'),
                    )
                  : isReserve
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.red,
                          ),
                          onPressed: _handleCancelReservation,
                          child: const Text('취소'),
                        )
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: AppColors.focusPurpleColor,
                          ),
                          onPressed: _handleReserve,
                          child: const Text('예약'),
                        ),
            ],
          ),
        ],
      ),
    );
  }
}

// Color getRandomProfileColor() {
//   final random = Random();
//   int index = random.nextInt(AppColors.profileRandomColors.length);
//   return AppColors.profileRandomColors[index];
// }
