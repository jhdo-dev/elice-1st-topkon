import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/config/text_styles.dart';
import 'package:alarm_front/presentation/bloc/topic/topic_bloc.dart';
import 'package:alarm_front/presentation/pages/room_filter/widgets/filter_box.dart';
import 'package:alarm_front/presentation/pages/room_filter/widgets/topic_create_dialog.dart';
import 'package:alarm_front/presentation/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoomFilterPage extends StatefulWidget {
  const RoomFilterPage({super.key});

  @override
  State<RoomFilterPage> createState() => _RoomFilterPageState();
}

class _RoomFilterPageState extends State<RoomFilterPage> {
  int isClickBox = 0;

  @override
  void initState() {
    super.initState();
    context.read<TopicBloc>().add(LoadTopicsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //? 룸 생성 버튼
      floatingActionButton: SizedBox(
        width: 50.w,
        height: 50.w,
        child: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.h),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return TopicCreateDialog();
              },
            );
          },
          child: Icon(
            Icons.add_rounded,
            size: 30.w,
            color: Colors.white,
          ),
        ),
      ),
      appBar: AppbarWidget(
        title: 'ROOM FILTER',
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
      body: BlocBuilder<TopicBloc, TopicState>(
        builder: (context, state) {
          if (state is TopicLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TopicLoaded) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      itemCount: state.topics.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20.w,
                        mainAxisSpacing: 20.h,
                        childAspectRatio: 1.5,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              isClickBox = index;
                            });
                          },
                          child: FilterBox(
                            boxIndex: index,
                            isClickBox: isClickBox,
                            topicCount: state.topics[index].roomCount,
                            topicName: state.topics[index].name,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            );
          } else if (state is TopicError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: TextStyles.mediumText,
              ),
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
