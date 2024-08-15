import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String? uuid;
  final String? displayName;
  final String? email;
  final String? photoUrl;
  final String? loginType;
  User({
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
}
