import 'package:alarm_front/domain/usecases/login/facebook_login_usecase.dart';
import 'package:alarm_front/domain/usecases/login/google_login_usecase.dart';
import 'package:alarm_front/domain/usecases/login/kakao_login_usecase.dart';
import 'package:alarm_front/domain/usecases/login/naver_login_usercase.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginUseCases {
  final GoogleLoginUsecase googleLoginUsecase;
  final KakaoLoginUsecase kakaoLoginUsecase;
  final FacebookLoginUsecase facebookLoginUsecase;
  final NaverLoginUsecase naverLoginUsecase;

  LoginUseCases({
    required this.googleLoginUsecase,
    required this.kakaoLoginUsecase,
    required this.facebookLoginUsecase,
    required this.naverLoginUsecase,
  });
}
