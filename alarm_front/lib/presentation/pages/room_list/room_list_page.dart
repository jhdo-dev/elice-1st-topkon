import 'package:alarm_front/presentation/pages/room_list/widgets/chat_room.dart';
import 'package:alarm_front/presentation/pages/room_list/widgets/chat_room_tile.dart';
import 'package:flutter/material.dart';

class RoomListPage extends StatelessWidget {
  // 예시로 채팅방 목록 데이터를 생성
  final List<ChatRoom> chatRooms = [
    ChatRoom(
        subjectName: 'Flutter 스터디',
        roomName: '스터디하실 분 모집합니다!',
        roomStartDate: '2024-08-01 09:24',
        roomEndDate: '2024-08-24 18:48'),
    ChatRoom(
        subjectName: 'Dart 스터디',
        roomName: 'dart 공부하실분~',
        roomStartDate: '2024-08-01 09:24',
        roomEndDate: '2024-08-24 18:48'),
    ChatRoom(
        subjectName: '배드민턴 치실 분',
        roomName: '배드민턴 치실 분 구함',
        roomStartDate: '2024-08-01 09:24',
        roomEndDate: '2024-08-24 18:48'),
    ChatRoom(
        subjectName: '앱 개발 공부 모입',
        roomName: '아무나 들어오십쇼',
        roomStartDate: '2024-08-01 09:24',
        roomEndDate: '2024-08-24 18:48'),
    ChatRoom(
        subjectName: '테스트 스터디',
        roomName: '스터디하실 분 모집합니다!',
        roomStartDate: '2024-08-01 09:24',
        roomEndDate: '2024-08-24 18:48'),
    ChatRoom(
        subjectName: '테스트 스터디',
        roomName: '스터디하실 분 모집합니다!',
        roomStartDate: '2024-08-01 09:24',
        roomEndDate: '2024-08-24 18:48'),
    ChatRoom(
        subjectName: '테스트 스터디',
        roomName: '스터디하실 분 모집합니다!',
        roomStartDate: '2024-08-01 09:24',
        roomEndDate: '2024-08-24 18:48'),
    ChatRoom(
        subjectName: '프로그래밍 스터디',
        roomName: '스터디하실 분 모집합니다!',
        roomStartDate: '2024-08-01 09:24',
        roomEndDate: '2024-08-24 18:48'),
    ChatRoom(
        subjectName: '프로그래밍 스터디',
        roomName: '스터디하실 분 모집합니다!',
        roomStartDate: '2024-08-01 09:24',
        roomEndDate: '2024-08-24 18:48'),
    ChatRoom(
        subjectName: '프로그래밍 스터디',
        roomName: '스터디하실 분 모집합니다!',
        roomStartDate: '2024-08-01 09:24',
        roomEndDate: '2024-08-24 18:48'),
  ];

  RoomListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chatRooms.length,
      itemBuilder: (context, index) {
        return ChatRoomTile(chatRoom: chatRooms[index]);
      },
    );
  }
}
