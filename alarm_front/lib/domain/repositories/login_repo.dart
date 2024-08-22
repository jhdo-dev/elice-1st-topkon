import 'package:alarm_front/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepo {
  Future<Either<String, User>> logInWithGoogle();
  Future<Either<String, User>> logInWithKakao();
  Future<Either<String, User>> logInWithFacebook();
}
