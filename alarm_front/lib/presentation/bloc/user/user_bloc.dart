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

  UserBloc({required this.userUsecases}) : super(UserInitial()) {
    on<CreateUserEvent>(_onCreateUser);
  }

  Future<void> _onCreateUser(
      CreateUserEvent event, Emitter<UserState> emit) async {
    emit(CreateUserLoading());

    final Either<String, User> result =
        await userUsecases.createUserUsecase(uuid: event.uuid);
    result.fold((error) => emit(CreateUserError(error)), (_) {
      emit(CreateUserSuccess());
    });
  }
}
