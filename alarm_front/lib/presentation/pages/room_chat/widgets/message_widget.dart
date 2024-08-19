import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/config/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageWidget extends StatelessWidget {
  final String myPlayerId;
  final String playerId;
  final String message;
  final bool myTurn;
  final String displayName; // displayName 추가
  // final String msgDate;
  // final String msgTime;

  // 말풍선이 사용자(me) 또는 상대방 두가지 상태를 가짐
  late final bool isMe = myPlayerId == playerId;

  MessageWidget(this.myPlayerId, this.playerId, this.message, this.myTurn,
      {required this.displayName,
      // required this.msgDate,
      // required this.msgTime,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isMe
          ? EdgeInsets.fromLTRB(100.w, 5.w, 15.w, 5.w)
          : EdgeInsets.fromLTRB(15.w, 5.w, 100.w, 5.w),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: myTurn
            ? [
                // 연속된 말풍선 스타일
                Container(
                  decoration: BoxDecoration(
                    // 연속된 말풍선 색깔 설정
                    color: isMe
                        ? AppColors.sendMsgBurbleColor
                        : AppColors.receiveMsgBurbleColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15.r),
                      bottomLeft: Radius.circular(15.r),
                      topRight: Radius.circular(15.r),
                      topLeft: Radius.circular(15.r),
                    ),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Text(
                    message,
                    style: TextStyles.mediumText,
                  ),
                ),
                SizedBox(height: 2),

                // Text(
                //   msgTime,
                //   style: TextStyles.smallText,
                // )
              ]
            : [
                // displayName 스타일
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  child: Text(
                    displayName, // playerId 대신 displayName을 사용
                    style: TextStyles.mediumText,
                  ),
                ),
                // 말풍선 스타일
                Container(
                  decoration: BoxDecoration(
                    // 말풍선 색깔 설정
                    color: isMe
                        ? AppColors.sendMsgBurbleColor
                        : AppColors.receiveMsgBurbleColor,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15.r),
                      bottomLeft: Radius.circular(15.r),
                      topRight:
                          isMe ? Radius.circular(0.r) : Radius.circular(15.r),
                      topLeft:
                          isMe ? Radius.circular(15.r) : Radius.circular(0.r),
                    ),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Text(
                    message,
                    style: TextStyles.mediumText,
                  ),
                ),
                SizedBox(height: 2),
                // Text(
                //   msgTime,
                //   style: TextStyles.smallText,
                // ),
              ],
      ),
    );
  }
}
