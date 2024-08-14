import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/presentation/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'widgets/input_chat_field.dart';
import 'widgets/message_widget.dart';

class RoomChatPage extends StatefulWidget {
  const RoomChatPage({super.key});

  @override
  State<RoomChatPage> createState() => _RoomChatPageState();
}

class _RoomChatPageState extends State<RoomChatPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // 빈공간 터치시 입력창 내려감
        },
        child: Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: const AppbarWidget(
              title: 'ROOM CHAT',
              isBackIcon: true,
            ),
            // 중앙 채팅화면(+말풍선)과 하단 입력창
            body: Container(
              child: Column(
                children: [
                  // 중앙 채팅화면(+말풍선)
                  Expanded(
                      child: ListView.builder(
                    reverse: true,
                    itemCount: testMessageList.length,
                    // 채팅 메시지 출력
                    itemBuilder: (context, index) {
                      return MessageWidget(testMessageList[index]['text'],
                          testMessageList[index]['isMe']);
                    },
                  )),
                  // 하단 채팅 입력창
                  const InputChatField(),
                ],
              ),
            )));
  }
}

// 테스트용 메시지 리스트 (나중에 DB연동하면 지울거)
final testMessageList = [
  {
    'text': 'text1',
    'isMe': true,
  },
  {
    'text': 'text2',
    'isMe': false,
  },
  {
    'text': 'text3',
    'isMe': true,
  },
  {
    'text': 'text4',
    'isMe': true,
  },
  {
    'text': 'text5dfdsfsdfsdfsfsdfsdfsdfds',
    'isMe': false,
  },
  {
    'text': 'text6',
    'isMe': true,
  },
  {
    'text': 'text7',
    'isMe': false,
  },
  {
    'text': 'text8',
    'isMe': false,
  },
  {
    'text': 'text9',
    'isMe': true,
  },
  {
    'text': 'text10sadaadaasdasdadfdsfsdfsdfsfsdfsdfsdfds',
    'isMe': true,
  },
];
