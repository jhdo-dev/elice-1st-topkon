import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/config/text_styles.dart';
import 'package:alarm_front/presentation/bloc/topic/topic_bloc.dart';
import 'package:alarm_front/presentation/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoomCreatePage extends StatelessWidget {
  const RoomCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        title: "ROOM CREATE",
        isBackIcon: true,
        actions: [
          GestureDetector(
            onTap: () {},
            child: Stack(children: [
              Positioned(
                top: 2.0.h,
                left: 2.0.w,
                child: Icon(
                  Icons.check_circle_rounded,
                  color: AppColors.focusColor.withOpacity(0.3),
                  size: 30.w,
                ),
              ),
              Icon(
                Icons.check_circle_rounded,
                color: AppColors.focusColor,
                size: 30.w,
              )
            ]),
          ),
          SizedBox(
            width: 15.w,
          ),
        ],
      ),
      body: const RoomCreateForm(),
    );
  }
}

class RoomCreateForm extends StatefulWidget {
  const RoomCreateForm({super.key});

  @override
  _RoomCreateFormState createState() => _RoomCreateFormState();
}

class _RoomCreateFormState extends State<RoomCreateForm> {
  DateTime? selectedStartDateTime;
  DateTime? selectedEndDateTime;
  int? selectedTopic;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TopicBloc>().add(LoadTopicsEvent());
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50.h, left: 50.w, right: 50.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'ROOM NAME',
            style: TextStyles.largeTitle,
          ),
          const SizedBox(height: 10),
          Container(
            height: 50.h,
            child: TextField(
              controller: _controller,
              style: TextStyles.mediumText,
              decoration: InputDecoration(
                hintText: "방 이름을 입력해 주세요.",
                hintStyle:
                    TextStyles.mediumText.copyWith(color: AppColors.hintColor),
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.bottomNavColor.withOpacity(0.5))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: AppColors.focusColor.withOpacity(0.5))),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'SELECT TOPIC',
            style: TextStyles.largeTitle,
          ),
          const SizedBox(height: 10),
          Container(
            width: double.maxFinite,
            height: 50.h,
            decoration: BoxDecoration(
              border:
                  Border.all(color: AppColors.bottomNavColor.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(5.h),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: DropdownButtonHideUnderline(
              child: BlocBuilder<TopicBloc, TopicState>(
                builder: (context, state) {
                  return DropdownButton<int>(
                    dropdownColor: AppColors.dropDownColor,
                    hint: Text(
                      '주제를 선택해 주세요.',
                      style: TextStyles.mediumText
                          .copyWith(color: AppColors.hintColor),
                    ),
                    style: TextStyles.mediumText,
                    isExpanded: true,
                    value: selectedTopic,
                    items: state is GetTopicLoaded
                        ? state.topics
                            .map(
                              (e) => DropdownMenuItem<int>(
                                child: Text(
                                  e.name,
                                  style: TextStyles.mediumText,
                                ),
                                value: e.id,
                              ),
                            )
                            .toList()
                        : [],
                    onChanged: (int? value) {
                      if (value != null) {
                        setState(() {
                          selectedTopic = value;
                        });
                      }
                    },
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.center, // 왼쪽 정렬
            child: Text(
              'START DATE',
              style: TextStyles.largeTitle,
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: GestureDetector(
              onTap: () {
                _selectStartDateTime(context);
              },
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(5.h),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      color: Colors.black.withOpacity(0.3),
                      offset: Offset(0, 5),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      selectedStartDateTime != null
                          ? '${"${selectedStartDateTime!.toLocal()}".split(' ')[0]} ${TimeOfDay.fromDateTime(selectedStartDateTime!).format(context)}'
                          : 'SELECT',
                      style: TextStyles.largeText,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Align(
            alignment: Alignment.center,
            child: Text(
              'END DATE',
              style: TextStyles.largeTitle,
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: GestureDetector(
              onTap: () {
                _selectEndDateTime(context);
              },
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                  color: AppColors.cardColor,
                  borderRadius: BorderRadius.circular(5.h),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      color: Colors.black.withOpacity(0.3),
                      offset: Offset(0, 5),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      selectedEndDateTime != null
                          ? '${"${selectedEndDateTime!.toLocal()}".split(' ')[0]} ${TimeOfDay.fromDateTime(selectedEndDateTime!).format(context)}'
                          : 'SELECT',
                      style: TextStyles.largeText,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectStartDateTime(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedStartDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  Future<void> _selectEndDateTime(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedEndDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }
}
