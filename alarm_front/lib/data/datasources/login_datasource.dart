import 'package:alarm_front/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

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

class KakaoLoginDatasource extends LoginDatasource {
  KakaoLoginDatasource();

  @override
  Future<Either<String, UserModel>> logIn() async {
    try {
      // 카카오톡 실행 가능 여부 확인
      if (await isKakaoTalkInstalled()) {
        return await _logInWithKakao(
            () => UserApi.instance.loginWithKakaoTalk());
      } else {
        return await _logInWithKakao(
            () => UserApi.instance.loginWithKakaoAccount());
      }
    } catch (e) {
      return Left('카카오 로그인 실패: ${e.toString()}');
    }
  }

  Future<Either<String, UserModel>> _logInWithKakao(
      Future<OAuthToken> Function() loginMethod) async {
    try {
      await loginMethod();
      final user = await UserApi.instance.me();
      // print(user);
      final userModel = UserModel(
        uuid: user.id.toString(),
        displayName: user.kakaoAccount?.profile?.nickname ?? '',
        email: user.kakaoAccount?.email ?? '',
        photoUrl: user.kakaoAccount?.profile?.profileImageUrl ?? '',
        loginType: "kakao",
      );
      print(userModel);
      return Right(userModel);
    } catch (e) {
      return Left('로그인 실패: ${e.toString()}');
    }
  }
}

class FacebookLoginDatasource extends LoginDatasource {
  final FacebookAuth facebookAuth;

  FacebookLoginDatasource({required this.facebookAuth});

  @override
  Future<Either<String, UserModel>> logIn() async {
    try {
      final LoginResult result = await facebookAuth.login(
        permissions: ['public_profile', 'email'],
      );

      if (result.status == LoginStatus.success) {
        final userData = await facebookAuth.getUserData(
          fields: "name,email,picture.width(200)",
        );
        // print('-----------> $userData');

        final userModel = UserModel(
          uuid: userData['id'].toString(),
          displayName: userData['name'] ?? '',
          email: userData['email'] ?? '',
          photoUrl: userData['picture']?['data']?['url'] ?? '',
          loginType: "facebook",
        );

        return Right(userModel);
      } else {
        return Left('페이스북 로그인이 취소되었습니다.');
      }
    } catch (e) {
      print(e.toString());
      return Left('페이스북 로그인 실패: ${e.toString()}');
    }
  }
}
