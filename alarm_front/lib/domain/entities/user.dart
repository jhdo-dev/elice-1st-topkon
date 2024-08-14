import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String uuid;
  User({
    required this.id,
    required this.uuid,
  });

  @override
  List<Object> get props => [id, uuid];
}
