import 'package:alarm_front/domain/entities/user.dart';
import 'package:alarm_front/domain/repositories/user_repo.dart';
import 'package:dartz/dartz.dart';

class AuthenticateUsecase {
  final UserRepo repo;

  AuthenticateUsecase({required this.repo});

  Future<Either<String, User>> call(User user) async {
    return await repo.authenticateUser(user);
  }
}
