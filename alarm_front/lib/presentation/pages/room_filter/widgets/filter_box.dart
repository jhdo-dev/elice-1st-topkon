import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/config/text_styles.dart';
import 'package:alarm_front/presentation/bloc/filter/filter_bloc.dart';
import 'package:alarm_front/presentation/bloc/topic/topic_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterBox extends StatelessWidget {
  const FilterBox({
    super.key,
    required this.topicName,
    required this.topicCount,
    required this.id,
  });

  final String topicName;
  final String topicCount;
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (state.selectedIndex == id) {
              context.read<FilterBloc>().add(SelectTopic(selectedId: -1));
            } else {
              context.read<FilterBloc>().add(SelectTopic(selectedId: id));
            }
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              color: state.selectedIndex == id
                  ? AppColors.focusPurpleColor
                  : AppColors.cardColor,
              borderRadius: BorderRadius.circular(20.w),
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  color: Colors.black.withOpacity(0.3),
                  offset: Offset(3, 3),
                )
              ],
            ),
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          topicName,
                          style: TextStyles.mediumTitle,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Container(
                          width: 30.w,
                          height: 25.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(14),
                            color: AppColors.appbarColor,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 2,
                                color: Colors.black.withOpacity(0.3),
                                offset: Offset(0, 2.h),
                              )
                            ],
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            topicCount,
                            style: TextStyles.mediumText.copyWith(
                              color: AppColors.focusPurpleColor,
                              height: 1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      context
                          .read<DeleteTopicBloc>()
                          .add(DeleteTopicsEvent(topicId: id));
                    },
                    child: Container(
                      width: 25.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.countBoxColor,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            color: Colors.black.withOpacity(0.3),
                            offset: Offset(0, 2.h),
                          )
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.close_rounded,
                        size: 15.w,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
