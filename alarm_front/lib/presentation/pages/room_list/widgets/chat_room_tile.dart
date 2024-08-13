import 'package:alarm_front/presentation/pages/room_list/widgets/chat_room.dart';
import 'package:flutter/material.dart';

class ChatRoomTile extends StatelessWidget {
  final ChatRoom chatRoom;

  const ChatRoomTile({super.key, required this.chatRoom});

  @override
  Widget build(BuildContext context) {
    return chatRoom;
  }
}
