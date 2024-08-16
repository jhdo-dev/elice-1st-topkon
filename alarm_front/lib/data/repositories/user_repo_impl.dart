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
    try {
      final userModel = UserModel.fromEntity(user);

      final result = await datasource.authenticateUser(userModel);

      return result.map((userModel) => userModel.toEntity());
    } catch (e) {
      return Left('유저 인증 실패: $e');
    }
  }
}
