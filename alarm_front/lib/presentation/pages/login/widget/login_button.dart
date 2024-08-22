import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/config/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.text,
    required this.textStyle,
    required this.logo,
    this.onTap,
    required this.logoSize,
    this.color,
    this.bgColor,
  });

  final String text;
  final TextStyle textStyle;
  final String logo;
  final VoidCallback? onTap;
  final double logoSize;
  final Color? color;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.maxFinite,
          height: 55.h,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(5.h),
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                color: Colors.black.withOpacity(0.3),
                offset: Offset(0, 5),
              )
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 20.w,
                child: Image.asset(
                  logo,
                  width: logoSize,
                  fit: BoxFit.cover,
                  color: color,
                ),
              ),
              Text(
                text,
                style: textStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
