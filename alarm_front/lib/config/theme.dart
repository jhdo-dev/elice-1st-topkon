import 'package:alarm_front/config/colors.dart';
import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.backgroundColor,
  appBarTheme: const AppBarTheme(
    color: AppColors.backgroundColor,
    scrolledUnderElevation: 0,
  ),
  splashColor: AppColors.focusColor.withOpacity(0.1),
  highlightColor: Colors.transparent,
  // 다른 테마 설정들을 여기에 추가
);
