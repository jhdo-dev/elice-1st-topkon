import 'package:alarm_front/presentation/bloc/bottom_nav/bottom_nav_bloc.dart';
import 'package:alarm_front/presentation/widgets/app_bar.dart';
import 'package:alarm_front/presentation/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShellComponent extends StatelessWidget {
  const ShellComponent({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //? 앱바
      appBar: AppbarWidget(
        title: context.watch<BottomNavBloc>().state.selectedIndex == 0
            ? 'ROOM LIST'
            : "MY",
      ),

      //? 바디
      body: child,

      //? 바텀네비게이션
      bottomNavigationBar: BottomNav(),
    );
  }
}
