import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/config/text_styles.dart';
import 'package:alarm_front/presentation/bloc/topic/topic_bloc.dart';
import 'package:alarm_front/presentation/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocListener<TopicBloc, TopicState>(
      listener: (context, state) {
        if (state is CreateTopicSuccess) {
          showCustomSnackbar(context, "생성되었습니다.");
          Navigator.of(context).pop();
        } else if (state is CreateTopicError) {
          showCustomSnackbar(context, "문제가 발생했습니다. 잠시 후 다시 시도해 주세요.");
        }
      },
      child: AlertDialog(
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
              if (_controller.text.isEmpty) {
                showCustomSnackbar(context, "주제를 입력해 주세요.");
              } else {
                context
                    .read<TopicBloc>()
                    .add(CreateTopicsEvent(topicName: _controller.text));
              }
            },
          ),
        ],
      ),
    );
  }
}
