import 'package:alarm_front/config/colors.dart';
import 'package:flutter/material.dart';

class RoomListPage extends StatelessWidget {
  const RoomListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChatRoomListPage(),
    );
  }
}

class ChatRoomListPage extends StatelessWidget {
  // 예시로 채팅방 목록 데이터를 생성
  final List<ChatRoom> chatRooms = [
    const ChatRoom(
        subjectName: 'Flutter 스터디',
        roomName: '스터디하실 분 모집합니다!',
        roomStartDate: '2024-08-01 09:24',
        roomEndDate: '2024-08-24 18:48'),
    const ChatRoom(
        subjectName: 'Dart 스터디',
        roomName: 'dart 공부하실분~',
        roomStartDate: '2024-08-01 09:24',
        roomEndDate: '2024-08-24 18:48'),
    const ChatRoom(
        subjectName: '배드민턴 치실 분',
        roomName: '배드민턴 치실 분 구함',
        roomStartDate: '2024-08-01 09:24',
        roomEndDate: '2024-08-24 18:48'),
    const ChatRoom(
        subjectName: '앱 개발 공부 모입',
        roomName: '아무나 들어오십쇼',
        roomStartDate: '2024-08-01 09:24',
        roomEndDate: '2024-08-24 18:48'),
    const ChatRoom(
        subjectName: '테스트 스터디',
        roomName: '스터디하실 분 모집합니다!',
        roomStartDate: '2024-08-01 09:24',
        roomEndDate: '2024-08-24 18:48'),
    const ChatRoom(
        subjectName: '테스트 스터디',
        roomName: '스터디하실 분 모집합니다!',
        roomStartDate: '2024-08-01 09:24',
        roomEndDate: '2024-08-24 18:48'),
    const ChatRoom(
        subjectName: '테스트 스터디',
        roomName: '스터디하실 분 모집합니다!',
        roomStartDate: '2024-08-01 09:24',
        roomEndDate: '2024-08-24 18:48'),
    const ChatRoom(
        subjectName: '프로그래밍 스터디',
        roomName: '스터디하실 분 모집합니다!',
        roomStartDate: '2024-08-01 09:24',
        roomEndDate: '2024-08-24 18:48'),
    const ChatRoom(
        subjectName: '프로그래밍 스터디',
        roomName: '스터디하실 분 모집합니다!',
        roomStartDate: '2024-08-01 09:24',
        roomEndDate: '2024-08-24 18:48'),
    const ChatRoom(
        subjectName: '프로그래밍 스터디',
        roomName: '스터디하실 분 모집합니다!',
        roomStartDate: '2024-08-01 09:24',
        roomEndDate: '2024-08-24 18:48'),
  ];

  ChatRoomListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: ListView.builder(
        itemCount: chatRooms.length,
        itemBuilder: (context, index) {
          return ChatRoomTile(chatRoom: chatRooms[index]);
        },
      ),
    );
  }
}

class ChatRoom extends StatelessWidget {
  final String subjectName;
  final String roomName;
  final String roomStartDate;
  final String roomEndDate;

  const ChatRoom({
    super.key,
    required this.subjectName,
    required this.roomName,
    required this.roomStartDate,
    required this.roomEndDate,
  });

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
                width: 50,
                height: 50,
                child: ClipRect(
                  child: Image.asset(
                    '/Users/jhdo/Developer/team2/alarm_front/assets/images/chat_room_default_profile.png',
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
                  '주제: $subjectName',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '방 이름: $roomName',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  '시작: $roomStartDate',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  '종료: $roomStartDate',
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    // fixedSize: const Size(60, 40),
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

class ChatRoomTile extends StatelessWidget {
  final ChatRoom chatRoom;

  const ChatRoomTile({super.key, required this.chatRoom});

  @override
  Widget build(BuildContext context) {
    return chatRoom;
  }
}
