import 'package:equatable/equatable.dart';

class Topic extends Equatable {
  final int id;
  final String name;
  final String roomCount;
  Topic({
    required this.id,
    required this.name,
    required this.roomCount,
  });

  @override
  List<Object> get props => [id, name, roomCount];
}
