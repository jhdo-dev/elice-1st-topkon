part of 'bottom_nav_bloc.dart';

@immutable
sealed class BottomNavState extends Equatable {
  final int selectedIndex;

  const BottomNavState({required this.selectedIndex});

  @override
  List<Object> get props => [selectedIndex];
}

final class BottomNavInitial extends BottomNavState {
  BottomNavInitial() : super(selectedIndex: 0);
}

final class BottomNavItemSelected extends BottomNavState {
  const BottomNavItemSelected({required int selectedIndex})
      : super(selectedIndex: selectedIndex);
}
