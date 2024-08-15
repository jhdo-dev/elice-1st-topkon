import 'package:alarm_front/data/datasources/user_datasource.dart';
import 'package:alarm_front/domain/entities/user.dart';
import 'package:alarm_front/domain/repositories/user_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepoImpl implements UserRepo {
  final UserDatasource datasource;

  UserRepoImpl({required this.datasource});

  @override
  Future<Either<String, User>> createUser({required String uuid}) async {
    final result = await datasource.createUser(uuid: uuid);
    return result.fold(
      (error) => Left(error),
      (user) async {
        final prefs = await SharedPreferences.getInstance();

        if (user.uuid != null) {
          await prefs.setString('user_uuid', user.uuid!);
        }
        if (user.id != null) {
          await prefs.setInt('user_id', user.id!);
        }
        return Right(user.toEntity());
      },
    );
  }
}
