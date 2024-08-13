import 'package:alarm_front/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
              SizedBox(
                width: 65,
                height: 65,
                child: ClipRect(
                  child: Image.asset(
                    'assets/images/chat_room_default_profile.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16.0),
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
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '종료: ${widget.roomEndDate}',
                  style: const TextStyle(
                    fontSize: 14.0,
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
                          onPressed: () {},
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
