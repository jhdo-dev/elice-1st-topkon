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
  final String msgDate;
  final String msgTime;

  // 말풍선이 사용자(me) 또는 상대방 두가지 상태를 가짐
  late final bool isMe = myPlayerId == playerId;

  MessageWidget(this.myPlayerId, this.playerId, this.message, this.myTurn,
      {required this.displayName,
      required this.msgDate,
      required this.msgTime,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isMe
          ? EdgeInsets.fromLTRB(100.w, 5.w, 0.w, 5.w)
          : EdgeInsets.fromLTRB(0.w, 5.w, 100.w, 5.w),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
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
                  margin: isMe
                      ? EdgeInsets.only(right: 10.w)
                      : EdgeInsets.only(left: 10.w),
                  child: Text(
                    message,
                    style: TextStyles.largeText,
                  ),
                ),
              ]
            : [
                // displayName 스타일
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        displayName,
                        style: TextStyles.largeText,
                      ),
                      SizedBox(width: 13),
                      Text(
                        msgTime,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ],
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
                  margin: isMe
                      ? EdgeInsets.only(right: 10.w)
                      : EdgeInsets.only(left: 10.w),
                  child: Text(
                    message,
                    style: TextStyles.largeText,
                  ),
                ),
              ],
      ),
    );
  }
}
