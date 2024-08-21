import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/config/text_styles.dart';
import 'package:alarm_front/presentation/pages/room_chat/room_chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatDrawer extends StatelessWidget {
  ChatDrawer({
    super.key,
    required this.widget,
    required this.playerList,
  });

  final RoomChatPage widget;
  final List<String> playerList;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.backgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 40.h),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Text(
                      '[ ${widget.subjectName} ]',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      widget.roomName,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              indent: 10,
              endIndent: 10,
              height: 40,
              color: AppColors.focusColor,
            ),
            Text(
              '대화상대',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: playerList.length,
                  itemBuilder: (context, index) {
                    return drawerTile(player: playerList[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class drawerTile extends StatelessWidget {
  const drawerTile({
    super.key,
    required this.player,
  });

  final String player;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          tileColor: AppColors.cardColor,
          leading: SizedBox(),
          title: Text(
            player,
            style: TextStyles.mediumText,
          ),
        ),
        SizedBox(height: 2),
      ],
    );
  }
}
