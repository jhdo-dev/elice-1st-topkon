import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/presentation/widgets/app_bar.dart';
import 'package:flutter/material.dart';

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
              child: const Column(
                children: [
                  Expanded(child: ChatMessageField()),
                  ChatInputField(),
                ],
              ),
            )));
  }
}

// 중앙 메시지 출력 공간
class ChatMessageField extends StatelessWidget {
  const ChatMessageField({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: testMessageList.length,
      itemBuilder: (context, index) {
        return Message(
            testMessageList[index]['text'], testMessageList[index]['isMe']);
      },
    );
  }
}

// 하단 메시지 입력 공간
class ChatInputField extends StatefulWidget {
  const ChatInputField({super.key});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final _controller = TextEditingController();
  var _userEnterMessage = '';
  void _sendMessage() {
    FocusScope.of(context).unfocus();
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            maxLines: null,
            controller: _controller,
            // 폰트 색상
            style: const TextStyle(color: AppColors.appbarColor),
            // 테두리 색상
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.appbarColor)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.appbarColor)),
            ),
            onChanged: (value) => setState(() {
              _userEnterMessage = value;
            }),
          )),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: _sendMessage,
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }
}

// 메시지(말풍선) 스타일
class Message extends StatelessWidget {
  // 나중에 final String/bool로 바꾸기
  var message;
  var isMe; // 말풍선이 사용자(me) 또는 상대방 두가지 상태를 가짐

  Message(this.message, this.isMe, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // 유저이름 스타일
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(
              isMe ? 'me' : 'other',
              style: const TextStyle(color: AppColors.appbarColor),
            ),
          ),
          // 말풍선 스타일
          Container(
            decoration: BoxDecoration(
              // 말풍선 색깔 설정
              color: isMe
                  ? AppColors.sendMsgBurbleColor
                  : AppColors.receiveMsgBurbleColor,
              borderRadius: BorderRadius.circular(12),
            ),
            width: 145, // 말풍선 최대넓이
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              message,
              style: const TextStyle(color: AppColors.appbarColor),
            ),
          ),
        ],
      ),
    );
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
];
