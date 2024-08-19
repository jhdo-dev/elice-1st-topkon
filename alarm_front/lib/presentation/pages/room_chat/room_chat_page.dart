import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/config/constants.dart';
import 'package:alarm_front/config/text_styles.dart';
import 'package:alarm_front/presentation/bloc/user/user_bloc.dart';
import 'package:alarm_front/presentation/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'widgets/message_widget.dart';

class RoomChatPage extends StatefulWidget {
  const RoomChatPage({
    super.key,
    required this.roomId,
    required this.topicName,
    required this.roomName,
  });

  final String roomId;
  final String topicName;
  final String roomName;

  @override
  State<RoomChatPage> createState() => _RoomChatPageState();
}

class _RoomChatPageState extends State<RoomChatPage> {
  late IO.Socket socket;
  TextEditingController _controller = TextEditingController();

  late final String myPlayerId;
  late final String displayName; // 사용자의 displayName

  List<String> messages = [];
  List<String> playerId = [];
  List<String> displayNames = []; // displayNames 리스트 추가

  bool myTurn = false;
  List<bool> myTurnList = [];

  List<String> msgDate = [];
  List<String> msgTime = [];

  @override
  void initState() {
    super.initState();

    final userBloc = context.read<UserBloc>();

    if (userBloc.state is GetUserSuccess) {
      final user = (userBloc.state as GetUserSuccess).user;
      myPlayerId = user.uuid!;

      // !!!닉네임 설정안하면 오류생김!!!
      displayName = user.displayName!;

      connectToServer(); // 서버 연결
    }
  }

  void connectToServer() async {
    socket = IO.io(Constants.chatUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.connect();

    socket.on('connect', (_) {
      print('=================connected: ${socket.id}');
      // 서버에 방 참여 이벤트 전송, playerId만 포함
      socket.emit('join', {
        'roomId': widget.roomId,
        'playerId': myPlayerId,
      });
    });

    // 서버로부터 이전 메시지 기록을 받을 때
    socket.on('previousMessages', (data) {
      setState(() {
        for (var msgData in data) {
          messages.add(msgData['msg']);
          playerId.add(msgData['playerId']);
          displayNames.add(msgData['displayName']); // displayName 저장
          myTurnList.add(msgData['myTurn']);
          msgDate.add(msgData['msgDate']);
          msgTime.add(msgData['msgTime']);
        }
      });
    });

    // 서버로부터 채팅 메시지를 받았을 때
    socket.on('msg', (data) {
      setState(() {
        messages.insert(0, data['msg']);
        playerId.insert(0, data['playerId']);
        displayNames.insert(0, data['displayName']); // displayName 저장
        myTurnList.insert(0, data['myTurn']);
        msgDate.insert(0, data['msgDate']);
        msgTime.insert(0, data['msgTime']);

        if (data['playerId'] != myPlayerId) {
          myTurn = false;
        }
      });
    });

    socket.on('disconnect', (_) {
      print('disconnected');
      socket.emit('exit', {'roomId': widget.roomId});
    });

    socket.onConnectError((err) => print('Connect error: $err'));
    socket.onError((err) => print('Error: $err'));
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      DateTime dt = DateTime.now();

      FocusScope.of(context).unfocus();
      socket.emit('msg', {
        'roomId': widget.roomId,
        'msg': _controller.text,
        'playerId': myPlayerId,
        'myTurn': myTurn,
        'msgDate': '${dt.year}년 ${dt.month}월 ${dt.day}일',
        'msgTime':
            '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}',
        // 서버에서 displayName을 가져와 전송하기 때문에 여기서는 필요 없음
      });
      myTurn = true;
      _controller.clear();
    }
  }

  @override
  void dispose() {
    socket.emit('exit', {'roomId': widget.roomId});
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
        appBar: AppbarWidget(
          title: '[${widget.topicName}] ${widget.roomName}',
          isBackIcon: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return MessageWidget(
                      myPlayerId,
                      playerId[index],
                      messages[index],
                      myTurnList[index],
                      displayName: displayNames[index], // displayName을 전달
                      msgDate: msgDate[index],
                      msgTime: msgTime[index],
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
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


