import 'package:alarm_front/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static final _font1 = GoogleFonts.notoSans();
  static final _font2 = GoogleFonts.play();

  static TextStyle get smallText =>
      _font1.copyWith(fontSize: 10.sp, color: Colors.white);
  static TextStyle get mediumText =>
      _font1.copyWith(fontSize: 14.sp, color: Colors.white);
  static TextStyle get largeText =>
      _font1.copyWith(fontSize: 16.sp, color: Colors.white);

  static TextStyle get smallTitle => _font1.copyWith(
        fontSize: 17.sp,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get mediumTitle => _font1.copyWith(
        fontSize: 19.sp,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get largeTitle => _font1.copyWith(
        fontSize: 21.sp,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get appbar => _font2.copyWith(
        fontSize: 28.sp,
        color: AppColors.appbarColor,
        fontWeight: FontWeight.w900,
        shadows: [
          Shadow(
            offset: Offset(1.w, 1.h),
            blurRadius: 3.0,
            color: AppColors.appbarColor.withOpacity(0.3),
          ),
        ],
      );

  static TextStyle get bottomNav => _font2.copyWith(
        fontSize: 12.sp,
        color: AppColors.bottomNavColor,
        fontWeight: FontWeight.w600,
        shadows: [
          Shadow(
            offset: Offset(1.3.w, 1.3.h),
            blurRadius: 3.0,
            color: AppColors.bottomNavColor.withOpacity(0.3),
          ),
        ],
      );
}
