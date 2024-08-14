import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/config/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageWidget extends StatelessWidget {
  // 나중에 final String/bool로 바꾸기
  var message;
  var isMe; // 말풍선이 사용자(me) 또는 상대방 두가지 상태를 가짐

  MessageWidget(this.message, this.isMe, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          // 유저이름 스타일
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: Text(
              isMe ? 'me' : 'other',
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
              borderRadius: BorderRadius.circular(12.r),
            ),
            width: 145, // 말풍선 최대넓이
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Text(
              message,
              style: TextStyles.mediumText,
            ),
          ),
        ],
      ),
    );
  }
}
