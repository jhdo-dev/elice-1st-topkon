part of 'filter_bloc.dart';

@immutable
sealed class FilterState extends Equatable {
  final int selectedIndex;

  FilterState({required this.selectedIndex});

  @override
  List<Object> get props => [selectedIndex];
}

final class FilterInitial extends FilterState {
  FilterInitial() : super(selectedIndex: -1);
}

final class FilterSelected extends FilterState {
  FilterSelected({required int selectedIndex})
      : super(selectedIndex: selectedIndex);
}
