import 'package:alarm_front/data/datasources/login_datasource.dart';
import 'package:alarm_front/data/repositories/login_repo_impl.dart';
import 'package:alarm_front/domain/repositories/login_repo.dart';
import 'package:alarm_front/domain/usecases/login/google_login_usecase.dart';
import 'package:alarm_front/domain/usecases/login/login_usecases.dart';
import 'package:alarm_front/presentation/bloc/login/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginDi {
  static Future<List<RepositoryProvider>> getRepositoryProvider(
      {required GoogleSignIn googleSignIn}) async {
    final googleLoginDatasource =
        GoogleLoginDatasource(googleSignIn: googleSignIn);
    final googleLoginRepository =
        LoginRepoImpl(googleLoginDatasource: googleLoginDatasource);
    final loginUsecase = LoginUseCases(
      googleLoginUsecase: GoogleLoginUsecase(repo: googleLoginRepository),
    );

    return [
      RepositoryProvider<GoogleLoginDatasource>.value(
          value: googleLoginDatasource),
      RepositoryProvider<LoginRepo>.value(value: googleLoginRepository),
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
