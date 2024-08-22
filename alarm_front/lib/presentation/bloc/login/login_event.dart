part of 'login_bloc.dart';

@immutable
sealed class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GoogleLoginEvent extends LoginEvent {}

class KakaoLoginEvent extends LoginEvent {}

class FacebookLoginEvent extends LoginEvent {}
