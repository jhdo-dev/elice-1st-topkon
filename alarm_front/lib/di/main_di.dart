import 'package:alarm_front/di/bottom_nav_di.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainDi {
  static List<BlocProvider> getBlocProvider() {
    return [
      BottomNavDi.getBlocProvider(),
    ];
  }
}
