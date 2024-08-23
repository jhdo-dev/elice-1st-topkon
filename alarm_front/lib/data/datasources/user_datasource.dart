import 'package:alarm_front/config/constants.dart';
import 'package:alarm_front/data/models/user_model.dart';
import 'package:alarm_front/utils/get_fcm_token.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class UserDatasource {
  final Dio dio;
  UserDatasource({
    required this.dio,
  });

  Future<Either<String, UserModel>> authenticateUser(UserModel user) async {
    try {
      final fcmToken = await getFcmToken();
      print("fcmToken :: $fcmToken");

      final userWithToken = user.copyWith(fcmToken: fcmToken);

      final response = await dio.post(
        '${Constants.baseUrl}/player',
        data: userWithToken.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final userModel = UserModel.fromJson(response.data);
        return Right(userModel);
      } else {
        return Left('회원 인증 실패: ${response.statusCode}');
      }
    } catch (e) {
      return Left('회원 인증 실패: $e');
    }
  }

  Future<Either<String, UserModel>> updateUser(
      {required String uuid, required String name}) async {
    try {
      final response = await dio.patch(
        '${Constants.baseUrl}/player/update',
        data: {
          "uuid": uuid,
          "displayName": name,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final userModel = UserModel.fromJson(response.data);
        return Right(userModel);
      } else {
        return Left('회원 수정 실패: ${response.statusCode}');
      }
    } catch (e) {
      return Left('회원 수정 실패: $e');
    }
  }
}
