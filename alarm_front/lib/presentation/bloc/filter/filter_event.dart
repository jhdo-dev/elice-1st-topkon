part of 'filter_bloc.dart';

@immutable
sealed class FilterEvent extends Equatable {}

final class SelectTopic extends FilterEvent {
  final int selectedId;

  SelectTopic({required this.selectedId});

  @override
  List<Object> get props => [selectedId];
}
