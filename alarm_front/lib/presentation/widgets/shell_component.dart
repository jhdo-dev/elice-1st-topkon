import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/presentation/bloc/bottom_nav/bottom_nav_bloc.dart';
import 'package:alarm_front/presentation/widgets/app_bar.dart';
import 'package:alarm_front/presentation/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ShellComponent extends StatefulWidget {
  const ShellComponent({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<ShellComponent> createState() => _ShellComponentState();
}

class _ShellComponentState extends State<ShellComponent> {
  @override
  Widget build(BuildContext context) {
    final selectedIndex = context.watch<BottomNavBloc>().state.selectedIndex;

    return Scaffold(
      //? 앱바
      appBar: AppbarWidget(
        title: selectedIndex == 0 ? 'ROOM LIST' : "MY",
        actions: selectedIndex == 0
            ? [
                GestureDetector(
                  onTap: () {
                    context.pushNamed("roomFilter");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(children: [
                      Positioned(
                        top: 1.0.h,
                        left: 1.0.w,
                        child: Icon(
                          Icons.filter_list_alt,
                          color: AppColors.appbarColor.withOpacity(0.3),
                          size: 30.w,
                        ),
                      ),
                      Icon(
                        Icons.filter_list_alt,
                        color: AppColors.appbarColor,
                        size: 28.w,
                      )
                    ]),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
              ]
            : [],
      ),

      //? 바디
      body: widget.child,

      //? 바텀네비게이션
      bottomNavigationBar: const BottomNav(),

      //? 룸 생성 버튼
      floatingActionButton: selectedIndex == 0
          ? SizedBox(
              width: 50.w,
              height: 50.w,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.h),
                ),
                onPressed: () {
                  context.pushNamed("roomCreate");
                },
                child: Icon(
                  Icons.add_rounded,
                  size: 30.w,
                  color: Colors.white,
                ),
              ),
            )
          : null,
    );
  }
}
