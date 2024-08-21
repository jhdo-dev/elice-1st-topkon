import 'package:alarm_front/domain/entities/user.dart';
import 'package:alarm_front/domain/usecases/login/login_usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCases loginUseCases;

  LoginBloc({
    required this.loginUseCases,
  }) : super(LoginInitial()) {
    on<GoogleLoginEvent>((event, emit) async {
      emit(LoginLoading());

      final Either<String, User> result =
          await loginUseCases.googleLoginUsecase();

      result.fold(
        (failure) => emit(LoginFailure(message: failure)),
        (user) => emit(LoginSuccess(user: user)),
      );
    });

    // 카카오 로그인 이벤트 처리
    on<KakaoLoginEvent>((event, emit) async {
      emit(LoginLoading());

      final Either<String, User> result =
          await loginUseCases.kakaoLoginUsecase();

      result.fold(
        (failure) => emit(LoginFailure(message: failure)),
        (user) => emit(LoginSuccess(user: user)),
      );
    });
  }
}
