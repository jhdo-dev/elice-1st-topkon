import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/config/text_styles.dart';
import 'package:alarm_front/presentation/bloc/room/room_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatRoom extends StatefulWidget {
  final String subjectName;
  final String roomName;
  final String roomStartDate;
  final String roomEndDate;

  ChatRoom({
    super.key,
    required this.subjectName,
    required this.roomName,
    required this.roomStartDate,
    required this.roomEndDate,
  });

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  bool isRoomActive = true;

  Future<void> _saveReservation() async {
    final prefs = await SharedPreferences.getInstance();
    // 예약 정보를 저장합니다. 예: 방 이름과 시작일, 종료일
    await prefs.setString('roomName', widget.roomName);
    await prefs.setString('roomStartDate', widget.roomStartDate);
    await prefs.setString('roomEndDate', widget.roomEndDate);
    // 필요에 따라 다른 정보를 저장할 수 있습니다.
    print('예약 정보가 저장되었습니다.');
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
          Column(
            children: [
              ClipOval(
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey.shade900),
                  child: SizedBox(
                    width: 70,
                    height: 70,
                    child: ClipRect(
                      child: Image.asset(
                        'assets/images/chat_room_default_profile.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
                Text('시작: ${widget.roomStartDate}',
                    style: TextStyles.smallText.copyWith(color: Colors.grey)),
                Text('종료: ${widget.roomEndDate}',
                    style: TextStyles.smallText.copyWith(color: Colors.grey)),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isRoomActive
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.sendMsgBurbleColor,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () {
                            context.pushNamed("roomChat");
                          },
                          child: const Text(
                            '참여',
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            // backgroundColor: Colors.red,
                            foregroundColor: Colors.red,
                          ),
                          onPressed: () {
                            context
                                .read<ReloadRoomBloc>()
                                .add(ReloadRoomEvent(28));
                          },
                          child: const Text(
                            '취소',
                          ),
                        ),
                      ],
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          // fixedSize: const Size(60, 40),
                          // backgroundBuilder: Colors.blue,
                          ),
                      onPressed: () {},
                      child: const Text(
                        '예약',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
