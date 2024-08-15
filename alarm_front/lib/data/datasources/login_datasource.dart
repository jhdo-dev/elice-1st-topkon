import 'package:alarm_front/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class LoginDatasource {
  Future<Either<String, UserModel>> logIn();
}

class GoogleLoginDatasource extends LoginDatasource {
  final GoogleSignIn googleSignIn;

  GoogleLoginDatasource({required this.googleSignIn});

  @override
  Future<Either<String, UserModel>> logIn() async {
    try {
      final data = await googleSignIn.signIn();

      if (data != null) {
        final user = UserModel(
          uuid: data.id,
          displayName: data.displayName,
          email: data.email,
          photoUrl: data.photoUrl,
          loginType: "google",
        );
        return Right(user);
      } else {
        return Left('구글 로그인이 취소되었습니다.');
      }
    } catch (e) {
      return Left('구글 로그인 실패 ${e.toString()}');
    }
  }
}
