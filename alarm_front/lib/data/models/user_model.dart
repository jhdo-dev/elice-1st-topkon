import 'package:alarm_front/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String uuid;
  UserModel({
    required this.id,
    required this.uuid,
  });

  @override
  List<Object> get props => [id, uuid];

  @override
  String toString() => 'UserModel(id: $id, uuid: $uuid)';

  UserModel copyWith({
    int? id,
    String? uuid,
  }) {
    return UserModel(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt() ?? 0,
      uuid: map['uuid'] ?? '',
    );
  }

  User toEntity() {
    return User(
      id: id,
      uuid: uuid,
    );
  }
}
