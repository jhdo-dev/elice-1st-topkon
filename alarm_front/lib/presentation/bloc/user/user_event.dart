part of 'user_bloc.dart';

@immutable
sealed class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserAuthenticated extends UserEvent {
  final User user;

  UserAuthenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

class GetLocalUserEvent extends UserEvent {}
