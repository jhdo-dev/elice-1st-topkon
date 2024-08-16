import 'package:alarm_front/presentation/pages/my/widgets/my_info_widget.dart';
import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyInfoWidget(),

        //TODO : 예약한 방 리스트
      ],
    );
  }
}
