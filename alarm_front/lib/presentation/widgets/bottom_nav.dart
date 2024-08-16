import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/config/text_styles.dart';
import 'package:alarm_front/presentation/bloc/bottom_nav/bottom_nav_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        return BottomNavigationBar(
          backgroundColor: AppColors.backgroundColor,
          selectedLabelStyle: TextStyles.bottomNav.copyWith(
            shadows: [
              Shadow(
                offset: Offset(1.3.w, 1.3.h),
                blurRadius: 3.0,
                color: AppColors.focusColor.withOpacity(0.3),
              ),
            ],
          ),
          unselectedLabelStyle: TextStyles.bottomNav,
          selectedItemColor: AppColors.focusColor,
          unselectedItemColor: AppColors.bottomNavColor,
          currentIndex: state.selectedIndex,
          onTap: (value) {
            context.read<BottomNavBloc>().add(SelectItem(selectedIndex: value));
            if (value == 0) {
              context.goNamed("roomList");
            } else {
              context.goNamed("my");
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  Positioned(
                    top: 1.5.h,
                    left: 1.5.w,
                    child: Icon(
                      Icons.home,
                      color: state.selectedIndex == 0
                          ? AppColors.focusColor.withOpacity(0.3)
                          : AppColors.bottomNavColor.withOpacity(0.3),
                      size: 25.w,
                    ),
                  ),
                  Icon(
                    Icons.home,
                    size: 25.w,
                  ),
                ],
              ),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [
                  Positioned(
                    top: 1.5.h,
                    left: 1.5.w,
                    child: Icon(
                      Icons.person,
                      color: state.selectedIndex == 1
                          ? AppColors.focusColor.withOpacity(0.3)
                          : AppColors.bottomNavColor.withOpacity(0.3),
                      size: 25.w,
                    ),
                  ),
                  Icon(
                    Icons.person,
                    size: 25.w,
                  ),
                ],
              ),
              label: 'MY',
            ),
          ],
        );
      },
    );
  }
}
