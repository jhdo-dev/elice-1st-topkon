import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/presentation/bloc/bottom_nav/bottom_nav_bloc.dart';
import 'package:alarm_front/presentation/widgets/app_bar.dart';
import 'package:alarm_front/presentation/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ShellComponent extends StatelessWidget {
  const ShellComponent({
    super.key,
    required this.child,
  });

  final Widget child;

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
                  child: Stack(children: [
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
                ),
                SizedBox(
                  width: 10.w,
                ),
              ]
            : [],
      ),

      //? 바디
      body: child,

      //? 바텀네비게이션
      bottomNavigationBar: BottomNav(),

      //? 룸 생성 버튼
      floatingActionButton: Container(
        width: 50.w,
        height: 50.w,
        child: FloatingActionButton(
          onPressed: () {
            context.pushNamed("roomCreate");
          },
          child: Icon(
            Icons.add_rounded,
            size: 30.w,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
