import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/config/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({
    super.key,
    required this.title,
    this.actions = const [],
    this.isBackIcon = false,
  });

  final String title;
  final List<Widget> actions;
  final bool isBackIcon;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyles.appbar,
      ),
      leading: isBackIcon
          ? GestureDetector(
              onTap: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.goNamed("roomList");
                }
              },
              child: Center(
                child: Stack(
                  children: [
                    Positioned(
                      top: 1.9.h,
                      left: 1.9.w,
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.appbarColor.withOpacity(0.3),
                        size: 27.w,
                      ),
                    ),
                    Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: AppColors.appbarColor,
                      size: 27.w,
                    )
                  ],
                ),
              ),
            )
          : null,
      actions: actions,
    );
  }
}
