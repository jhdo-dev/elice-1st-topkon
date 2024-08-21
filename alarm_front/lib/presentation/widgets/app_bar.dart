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
    this.titleSize,
  });

  final String title;
  final List<Widget> actions;
  final bool isBackIcon;
  final double? titleSize;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.backgroundColor,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyles.appbar.copyWith(fontSize: titleSize ?? 26.sp),
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
                      top: 1.1.h,
                      left: 1.1.w,
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
