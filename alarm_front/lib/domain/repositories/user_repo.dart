import 'package:alarm_front/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepo {
  Future<Either<String, User>> authenticateUser(User user);
}
