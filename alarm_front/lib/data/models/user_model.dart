import 'package:alarm_front/domain/entities/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class UserModel extends Equatable {
  final int? id;
  final String? uuid;
  final String? displayName;
  final String? email;
  final String? photoUrl;
  final String? loginType;
  UserModel({
    this.id,
    this.uuid,
    this.displayName,
    this.email,
    this.photoUrl,
    this.loginType,
  });

  @override
  List<Object?> get props {
    return [
      id,
      uuid,
      displayName,
      email,
      photoUrl,
      loginType,
    ];
  }

  @override
  String toString() {
    return 'UserModel(id: $id, uuid: $uuid, displayName: $displayName, email: $email, photoUrl: $photoUrl, loginType: $loginType)';
  }

  UserModel copyWith({
    ValueGetter<int?>? id,
    ValueGetter<String?>? uuid,
    ValueGetter<String?>? displayName,
    ValueGetter<String?>? email,
    ValueGetter<String?>? photoUrl,
    ValueGetter<String?>? loginType,
  }) {
    return UserModel(
      id: id != null ? id() : this.id,
      uuid: uuid != null ? uuid() : this.uuid,
      displayName: displayName != null ? displayName() : this.displayName,
      email: email != null ? email() : this.email,
      photoUrl: photoUrl != null ? photoUrl() : this.photoUrl,
      loginType: loginType != null ? loginType() : this.loginType,
    );
  }

  User toEntity() {
    return User(
      id: id,
      uuid: uuid,
      displayName: displayName,
      email: email,
      photoUrl: photoUrl,
      loginType: loginType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
      'loginType': loginType,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt(),
      uuid: map['uuid'],
      displayName: map['displayName'],
      email: map['email'],
      photoUrl: map['photoUrl'],
      loginType: map['loginType'],
    );
  }
}
