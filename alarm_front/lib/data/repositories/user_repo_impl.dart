import 'package:alarm_front/data/datasources/user_datasource.dart';
import 'package:alarm_front/data/models/user_model.dart';
import 'package:alarm_front/domain/entities/user.dart';
import 'package:alarm_front/domain/repositories/user_repo.dart';
import 'package:dartz/dartz.dart';

class UserRepoImpl implements UserRepo {
  final UserDatasource datasource;

  UserRepoImpl({required this.datasource});

  @override
  Future<Either<String, User>> authenticateUser(User user) async {
    final userModel = UserModel.fromEntity(user);

    final result = await datasource.authenticateUser(userModel);

    return result.fold(
      (l) => Left(l),
      (r) => Right(r.toEntity()),
    );
  }

  @override
  Future<Either<String, User>> updateUser(
      {required String uuid, required String name}) async {
    final result = await datasource.updateUser(uuid: uuid, name: name);

    return result.fold(
      (l) => Left(l),
      (r) => Right(r.toEntity()),
    );
  }
}
