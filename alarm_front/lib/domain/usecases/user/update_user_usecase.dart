import 'package:alarm_front/domain/entities/user.dart';
import 'package:alarm_front/domain/repositories/user_repo.dart';
import 'package:dartz/dartz.dart';

class UpdateUserUsecase {
  final UserRepo repo;

  UpdateUserUsecase({required this.repo});

  Future<Either<String, User>> call(
      {required String uuid, required String name}) async {
    return await repo.updateUser(name: name, uuid: uuid);
  }
}
