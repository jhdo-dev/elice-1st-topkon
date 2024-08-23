import 'package:alarm_front/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

abstract class LoginDatasource {
  Future<Either<String, UserModel>> logIn();
}

class GoogleLoginDatasource extends LoginDatasource {
  final GoogleSignIn googleSignIn;

  GoogleLoginDatasource({required this.googleSignIn});

  @override
  Future<Either<String, UserModel>> logIn() async {
    try {
      final googleUser = await googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final data = await FirebaseAuth.instance.signInWithCredential(credential);

      if (data.user != null) {
        final user = UserModel(
          uuid: data.user!.uid,
          displayName: data.user!.displayName,
          email: data.user!.email,
          photoUrl: data.user!.photoURL,
          loginType: "google",
        );

        return Right(user);
      } else {
        return Left('구글 로그인이 취소되었습니다.');
      }
    } catch (e) {
      print(e);
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

class NaverLoginDatasource extends LoginDatasource {
  NaverLoginDatasource() {
    _initializeSdk();
  }

  Future<void> _initializeSdk() async {
    await FlutterNaverLogin.initSdk(
      clientId: 'whiODgA6zzg8LueHkbpY',
      clientSecret: '7losgiFIzp',
      clientName: 'TopicApp',
    );
  }

  @override
  Future<Either<String, UserModel>> logIn() async {
    try {
      // 네이버 로그인 시도
      NaverLoginResult result = await FlutterNaverLogin.logIn();

      if (result.status == NaverLoginStatus.loggedIn) {
        // 로그인 성공
        final NaverAccessToken token =
            await FlutterNaverLogin.currentAccessToken;
        final NaverAccountResult accountResult =
            await FlutterNaverLogin.currentAccount();

        final user = UserModel(
          uuid: token.accessToken,
          displayName: accountResult.nickname,
          email: accountResult.email,
          photoUrl: accountResult.profileImage,
          loginType: "naver",
        );

        return Right(user);
      } else {
        return Left('네이버 로그인이 취소되었습니다.');
      }
    } catch (e) {
      return Left('네이버 로그인 실패 ${e.toString()}');
    }
  }
}
