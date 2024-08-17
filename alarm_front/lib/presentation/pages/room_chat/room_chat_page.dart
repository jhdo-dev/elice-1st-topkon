import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/config/constants.dart';
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

/**할일
 * 1순위: room id, player id 연동하기
 * 2. 상태관리 공부하기
 * 3. bloc 공부하기
 * 4. DB에 채팅기록 연동
 */
class _RoomChatPageState extends State<RoomChatPage> {
  late IO.Socket socket;
  TextEditingController _controller = TextEditingController();

  final String roomId = 'room1'; // 임시 방 ID
  late final String myPlayerId; // 임시 플레이어 ID (일단 임시로 socket.id 할당)

  List<String> messages = [];
  List<String> playerId = [];
  List<bool> myTurn = []; // 연속된 대화일때 true

  @override
  void initState() {
    super.initState();
    connectToServer();
  }

  void connectToServer() {
    socket = IO.io(Constants.chatUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.connect();

    socket.on('connect', (_) {
      print('=================connected: ${socket.id}');
      myPlayerId = socket.id!;
      // 서버에 방 참여 이벤트 전송
      socket.emit('join', {'roomId': roomId, 'playerId': myPlayerId});
    });

    // 서버로부터 채팅 메시지를 받았을 때
    socket.on('msg', (data) {
      setState(() {
        messages.insert(0, data['msg']);
        playerId.insert(0, data['playerId']);
        if (myTurn.isEmpty) {
          myTurn.add(false);
        } else {
          myTurn.insert(0, playerId[1] == playerId[0]);
        }
      });
    });

    socket.on('disconnect', (_) {
      print('disconnected');
      socket.emit('exit', {roomId: roomId});
    });

    socket.onConnectError((err) => print('Connect error: $err'));
    socket.onError((err) => print('Error: $err'));
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      FocusScope.of(context).unfocus();
      socket.emit('msg', {
        'roomId': roomId,
        'msg': _controller.text,
        'playerId': myPlayerId,
      });
      _controller.clear();
    }
  }

  @override
  void dispose() {
    socket.emit('exit', {'roomId': roomId});
    socket.dispose();
    _controller.dispose();
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
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return MessageWidget(myPlayerId, playerId[index],
                      messages[index], myTurn[index]);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.h),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      minLines: 1,
                      maxLines: 4,
                      controller: _controller,
                      style: TextStyles.mediumText,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.bottomNavColor.withOpacity(0.5),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.bottomNavColor.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  ElevatedButton(
                    onPressed: _sendMessage,
                    child: Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* 나중에 시간나면 할일
1. 앱바 오른쪽에 드로워메뉴 추가해서 채팅방 유저목록 불러온 후 카드or리스트타일로 표시하기;
2. 같은유저의 연속된 채팅은 이름표시하지 않음; (완료)
3. 하단구석에 채팅시간 표시
3-1. 같은 분일때 시간표시 생략


*/


