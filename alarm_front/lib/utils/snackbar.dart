import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/config/text_styles.dart';
import 'package:flutter/material.dart';

void showCustomSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  final snackBar = SnackBar(
    content: Center(
      child: Text(
        message,
        style: TextStyles.largeText.copyWith(color: AppColors.focusColor),
      ),
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
