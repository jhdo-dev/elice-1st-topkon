import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/config/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        title,
        style: TextStyles.appbar,
      ),
      actions: [
        Stack(children: [
          Positioned(
            top: 2.0.h,
            left: 2.0.w,
            child: Icon(
              Icons.filter_list_alt,
              color: AppColors.appbarColor.withOpacity(0.3),
              size: 30.w,
            ),
          ),
          Icon(
            Icons.filter_list_alt,
            color: AppColors.appbarColor,
            size: 30.w,
          )
        ]),
        SizedBox(
          width: 10.w,
        ),
      ],
    );
  }
}
