import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/config/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterBox extends StatelessWidget {
  const FilterBox({
    super.key,
    required this.boxIndex,
    required this.isClickBox,
  });

  final int boxIndex;
  final int isClickBox;

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
                "샘플 주제",
                style: TextStyles.mediumTitle,
              ),
            ),
          ),
          Positioned(
            right: 0,
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
              child: Text(
                "2",
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
