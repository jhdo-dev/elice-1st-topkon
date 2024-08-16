import 'package:alarm_front/data/datasources/local_datasource.dart';
import 'package:alarm_front/domain/entities/user.dart';
import 'package:alarm_front/domain/usecases/user/user_usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserUsecases userUsecases;

  UserBloc({
    required this.userUsecases,
  }) : super(GetUserInitial()) {
    on<UserAuthenticated>((event, emit) async {
      emit(GetUserLoading());

      final Either<String, User> result =
          await userUsecases.authenticateUsecase(event.user);

      result.fold((failure) => emit(GetUserError(message: failure)),
          (user) async {
        emit(GetUserSuccess(user: user));

        await LocalDatasource.saveUserInfo(user);
      });
    });

    on<GetLocalUserEvent>((event, emit) async {
      final user = await LocalDatasource.getUserInfo();
      if (user != null) {
        emit(GetUserSuccess(user: user));
      }
    });
  }
}
