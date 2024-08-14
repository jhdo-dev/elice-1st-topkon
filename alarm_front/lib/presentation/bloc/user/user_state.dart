part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class CreateUserLoading extends UserState {}

final class CreateUserSuccess extends UserState {}

final class CreateUserError extends UserState {
  final String message;
  CreateUserError(this.message);
}
