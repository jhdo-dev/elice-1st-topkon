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
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppbarWidget(
          title: 'ROOM CHAT',
          isBackIcon: true,
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(child: ChatMessageField()),
              ChatInputField(),
            ],
          ),
        ));
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
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 5),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            maxLines: null,
            controller: _controller,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(),
            ),
            onChanged: (value) => setState(() {
              _userEnterMessage = value;
            }),
          )),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: _sendMessage,
            child: Text('Send'),
          ),
        ],
      ),
    );
  }
}

// 메시지(말풍선) 스타일
class Message extends StatelessWidget {
  var message;
  var isMe;

  Message(this.message, this.isMe, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: isMe ? Text('me') : Text('other'),
          ),
          Container(
            decoration: BoxDecoration(
              color: isMe ? Colors.blue : Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
            width: 145, // 말풍선 최대넓이
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
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
