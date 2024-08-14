import 'package:alarm_front/config/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/colors.dart';

class InputChatField extends StatefulWidget {
  const InputChatField({super.key});

  @override
  State<InputChatField> createState() => _InputChatFieldState();
}

class _InputChatFieldState extends State<InputChatField> {
  final _controller = TextEditingController();
  var _userEnterMessage = '';
  void _sendMessage() {
    FocusScope.of(context).unfocus();
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 20.h),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            maxLines: null,
            controller: _controller,
            // 폰트 색상
            style: TextStyles.mediumText,

            // 테두리 색상
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors.bottomNavColor.withOpacity(0.5))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: AppColors.bottomNavColor.withOpacity(0.5))),
            ),
            onChanged: (value) => setState(() {
              _userEnterMessage = value;
            }),
          )),
          SizedBox(width: 15.w),
          ElevatedButton(
            onPressed: _sendMessage,
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }
}
