import 'package:alarm_front/config/constants.dart';
import 'package:alarm_front/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class UserDatasource {
  final Dio dio;
  UserDatasource({
    required this.dio,
  });

  Future<Either<String, UserModel>> createUser({required String uuid}) async {
    try {
      final response = await dio.post(
        "${Constants.baseUrl}/player",
        data: {"uuid": uuid},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data as Map<String, dynamic>;
        final user = UserModel.fromJson(data);
        ;
        return Right(user);
      } else {
        return Left('${response.statusCode} :: 유저를 생성하는데 실패했습니다.');
      }
    } catch (e) {
      return Left('${e.toString()}');
    }
  }
}
