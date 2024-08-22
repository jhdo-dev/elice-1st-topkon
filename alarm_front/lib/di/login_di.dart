import 'package:alarm_front/data/datasources/login_datasource.dart';
import 'package:alarm_front/data/repositories/login_repo_impl.dart';
import 'package:alarm_front/domain/repositories/login_repo.dart';
import 'package:alarm_front/domain/usecases/login/facebook_login_usecase.dart';
import 'package:alarm_front/domain/usecases/login/google_login_usecase.dart';
import 'package:alarm_front/domain/usecases/login/kakao_login_usecase.dart';
import 'package:alarm_front/domain/usecases/login/login_usecases.dart';
import 'package:alarm_front/presentation/bloc/login/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginDi {
  static Future<List<RepositoryProvider>> getRepositoryProvider({
    required GoogleSignIn googleSignIn,
    required FacebookAuth facebookAuth,
  }) async {
    final googleLoginDatasource =
        GoogleLoginDatasource(googleSignIn: googleSignIn);
    final kakaoLoginDatasource = KakaoLoginDatasource();
    final facebookLoginDatasource =
        FacebookLoginDatasource(facebookAuth: facebookAuth);

    final googleLoginRepository =
        LoginRepoImpl(googleLoginDatasource: googleLoginDatasource);
    final kakaoLoginRepository =
        LoginRepoImpl(kakaoLoginDatasource: kakaoLoginDatasource);
    final facebookLoginRepository =
        LoginRepoImpl(facebookLoginDatasource: facebookLoginDatasource);

    final loginUsecase = LoginUseCases(
      googleLoginUsecase: GoogleLoginUsecase(repo: googleLoginRepository),
      kakaoLoginUsecase: KakaoLoginUsecase(repo: kakaoLoginRepository),
      facebookLoginUsecase: FacebookLoginUsecase(repo: facebookLoginRepository),
    );

    return [
      RepositoryProvider<GoogleLoginDatasource>.value(
          value: googleLoginDatasource),
      RepositoryProvider<KakaoLoginDatasource>.value(
          value: kakaoLoginDatasource),
      RepositoryProvider<FacebookLoginDatasource>.value(
          value: facebookLoginDatasource),
      RepositoryProvider<LoginRepo>.value(value: googleLoginRepository),
      RepositoryProvider<LoginRepo>.value(value: kakaoLoginRepository),
      RepositoryProvider<LoginRepo>.value(value: facebookLoginRepository),
      RepositoryProvider<LoginUseCases>.value(value: loginUsecase),
    ];
  }

  static BlocProvider getBlocProvider() {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(
        loginUseCases: RepositoryProvider.of(context),
      ),
    );
  }
}
