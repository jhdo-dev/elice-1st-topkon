part of 'user_bloc.dart';

@immutable
sealed class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUserInitial extends UserState {}

class GetUserLoading extends UserState {}

class GetUserSuccess extends UserState {
  final User user;

  GetUserSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class GetUserError extends UserState {
  final String message;

  GetUserError({required this.message});

  @override
  List<Object> get props => [message];
}
