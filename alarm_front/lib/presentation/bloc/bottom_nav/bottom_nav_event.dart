part of 'bottom_nav_bloc.dart';

@immutable
sealed class BottomNavEvent {}

final class SelectItem extends BottomNavEvent {
  final int selectedIndex;

  SelectItem({required this.selectedIndex});
}
