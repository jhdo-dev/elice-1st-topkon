import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/presentation/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'widgets/message_widget.dart';
import 'package:alarm_front/config/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class RoomChatPage extends StatefulWidget {
  const RoomChatPage({super.key});

  @override
  State<RoomChatPage> createState() => _RoomChatPageState();
}

class _RoomChatPageState extends State<RoomChatPage> {
  late IO.Socket socket;
  TextEditingController _controller = TextEditingController();
  List<String> messages = [];
  List<bool> isMe = [];

  @override
  void initState() {
    super.initState();
    connectToServer();
  }

  void connectToServer() {
    socket = IO.io(
        'https://surrounding-lisha-elicecontents-4e3f02e0.koyeb.app/',
        <String, dynamic>{
          'transports': ['websocket'],
          'autoConnect': true,
        });

    socket.connect();

    socket.on('connect', (_) {
      print('connected');
    });

    socket.on('message', (data) {
      setState(() {
        messages.insert(0, data);
        isMe.insert(0, false);
      });
    });

    socket.on('message_received', (data) {
      setState(() {
        messages.insert(0, data['message']);
        isMe.insert(0, true);
      });
    });

    socket.on('disconnect', (_) {
      print('disconnect');
    });
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      FocusScope.of(context).unfocus();
      socket.emit('message', _controller.text);
      _controller.clear();
    }
  }

  @override
  void dispose() {
    print('bye');
    socket.dispose();
    super.dispose();
  }

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
                      itemCount: messages.length,
                      // 채팅 메시지 출력
                      itemBuilder: (context, index) {
                        return MessageWidget(messages[index], isMe[index]);
                      },
                    ),
                  ),
                  // 하단 채팅 입력창
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.h),
                    child: Row(
                      children: [
                        Expanded(
                            child: TextField(
                          minLines: 1,
                          maxLines: 4,
                          controller: _controller,
                          // 폰트 색상
                          style: TextStyles.mediumText,
                          // 테두리 색상
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.bottomNavColor
                                        .withOpacity(0.5))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.bottomNavColor
                                        .withOpacity(0.5))),
                          ),
                        )),
                        SizedBox(width: 15.w),
                        ElevatedButton(
                          onPressed: _sendMessage,
                          child: const Text('Send'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
