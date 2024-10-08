import 'package:alarm_front/data/datasources/user_datasource.dart';
import 'package:alarm_front/data/repositories/user_repo_impl.dart';
import 'package:alarm_front/domain/usecases/user/authenticate_usecase.dart';
import 'package:alarm_front/domain/usecases/user/update_user_usecase.dart';
import 'package:alarm_front/domain/usecases/user/user_usecases.dart';
import 'package:alarm_front/presentation/bloc/user/user_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDi {
  static Future<List<RepositoryProvider>> getRepositoryProvider(
      {required Dio dio}) async {
    final userDatasource = UserDatasource(dio: dio);
    final userRepository = UserRepoImpl(datasource: userDatasource);
    final userUsecase = UserUsecases(
      authenticateUsecase: AuthenticateUsecase(repo: userRepository),
      updateUserUsecase: UpdateUserUsecase(repo: userRepository),
    );

    return [
      RepositoryProvider<UserDatasource>.value(value: userDatasource),
      RepositoryProvider<UserRepoImpl>.value(value: userRepository),
      RepositoryProvider<UserUsecases>.value(value: userUsecase),
    ];
  }

  static List<BlocProvider> getBlocProvider() {
    return [
      BlocProvider<UserBloc>(
        create: (context) => UserBloc(
          userUsecases: RepositoryProvider.of(context),
        ),
      ),
      BlocProvider<UpdateUserBloc>(
        create: (context) => UpdateUserBloc(
          userUsecases: RepositoryProvider.of(context),
          userBloc: BlocProvider.of<UserBloc>(context),
        ),
      ),
    ];
  }
}
