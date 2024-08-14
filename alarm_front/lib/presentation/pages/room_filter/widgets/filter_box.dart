import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/config/text_styles.dart';
import 'package:alarm_front/presentation/bloc/topic/topic_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterBox extends StatelessWidget {
  const FilterBox({
    super.key,
    required this.boxIndex,
    required this.isClickBox,
    required this.topicName,
    required this.topicCount,
    required this.id,
  });

  final int boxIndex;
  final int isClickBox;
  final String topicName;
  final String topicCount;
  final int id;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color:
            isClickBox == boxIndex ? AppColors.focusColor : AppColors.cardColor,
        borderRadius: BorderRadius.circular(20.w),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: Colors.black.withOpacity(0.3),
            offset: Offset(3, 3),
          )
        ],
      ),
      child: Stack(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Text(
                topicName,
                style: TextStyles.mediumTitle,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: GestureDetector(
              onTap: () {
                context
                    .read<DeleteTopicBloc>()
                    .add(DeleteTopicsEvent(topicId: id));
              },
              child: Container(
                width: 25.w,
                height: 25.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.countBoxColor,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      color: Colors.black.withOpacity(0.3),
                      offset: Offset(0, 2.h),
                    )
                  ],
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.close_rounded,
                  size: 15.w,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            child: Container(
              width: 25.w,
              height: 25.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.sendMsgBurbleColor,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    color: Colors.black.withOpacity(0.3),
                    offset: Offset(0, 2.h),
                  )
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                topicCount,
                style: TextStyles.smallText.copyWith(
                  height: 1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
