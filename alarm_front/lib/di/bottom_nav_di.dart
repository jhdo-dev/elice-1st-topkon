import 'package:alarm_front/presentation/bloc/bottom_nav/bottom_nav_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavDi {
  static BlocProvider getBlocProvider() {
    return BlocProvider<BottomNavBloc>(
      create: (context) => BottomNavBloc(),
    );
  }
}
