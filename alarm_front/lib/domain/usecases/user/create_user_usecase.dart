import 'package:alarm_front/domain/entities/user.dart';
import 'package:alarm_front/domain/repositories/user_repo.dart';
import 'package:dartz/dartz.dart';

class CreateUserUsecase {
  final UserRepo repo;

  CreateUserUsecase({required this.repo});

  Future<Either<String, User>> call({required String uuid}) async {
    return await repo.createUser(uuid: uuid);
  }
}
