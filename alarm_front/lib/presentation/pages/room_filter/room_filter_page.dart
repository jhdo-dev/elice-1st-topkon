import 'package:alarm_front/config/colors.dart';
import 'package:alarm_front/presentation/pages/room_filter/widgets/filter_box.dart';
import 'package:alarm_front/presentation/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoomFilterPage extends StatefulWidget {
  const RoomFilterPage({super.key});

  @override
  State<RoomFilterPage> createState() => _RoomFilterPageState();
}

class _RoomFilterPageState extends State<RoomFilterPage> {
  int isClickBox = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: 10,
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
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
