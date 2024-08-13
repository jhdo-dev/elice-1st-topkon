import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/config/text_styles.dart';
import 'package:flutter/material.dart';

class TopicCreateDialog extends StatefulWidget {
  const TopicCreateDialog({
    super.key,
  });

  @override
  State<TopicCreateDialog> createState() => _TopicCreateDialogState();
}

class _TopicCreateDialogState extends State<TopicCreateDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.backgroundColor,
      title: Text(
        'ROOM TOPIC',
        style: TextStyles.mediumTitle,
      ),
      content: TextField(
        controller: _controller,
        style: TextStyles.mediumText,
        decoration: InputDecoration(
            hintStyle:
                TextStyles.mediumText.copyWith(color: AppColors.hintColor),
            hintText: "주제를 입력해주세요.",
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.focusColor),
            )),
        cursorColor: AppColors.focusColor,
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            'OK',
            style: TextStyles.largeText.copyWith(color: AppColors.focusColor),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
