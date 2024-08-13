part of 'bottom_nav_bloc.dart';

@immutable
sealed class BottomNavState {
  final int selectedIndex;

  const BottomNavState({required this.selectedIndex});
}

final class BottomNavInitial extends BottomNavState {
  BottomNavInitial() : super(selectedIndex: 0);
}

final class BottomNavItemSelected extends BottomNavState {
  const BottomNavItemSelected({required int selectedIndex})
      : super(selectedIndex: selectedIndex);
}
