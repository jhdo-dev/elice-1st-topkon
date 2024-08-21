import 'package:alarm_front/domain/usecases/login/google_login_usecase.dart';
import 'package:alarm_front/domain/usecases/login/kakao_login_usecase.dart';

class LoginUseCases {
  final GoogleLoginUsecase googleLoginUsecase;
  final KakaoLoginUsecase kakaoLoginUsecase;

  LoginUseCases({
    required this.googleLoginUsecase,
    required this.kakaoLoginUsecase,
  });
}
