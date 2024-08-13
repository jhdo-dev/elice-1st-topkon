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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyles.appbar,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(children: [
            Positioned(
              top: 1.0.h,
              left: 1.0.w,
              child: Icon(
                Icons.filter_list_alt,
                color: AppColors.appbarColor.withOpacity(0.3),
                size: 28.w,
              ),
            ),
            Icon(
              Icons.filter_list_alt,
              color: AppColors.appbarColor,
              size: 28.w,
            )
          ]),
        ),
        SizedBox(
          width: 10.w,
        ),
      ],
    );
  }
}
