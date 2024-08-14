part of 'user_bloc.dart';

@immutable
sealed class UserEvent extends Equatable {}

class CreateUserEvent extends UserEvent {
  final String uuid;

  CreateUserEvent({required this.uuid});

  @override
  List<Object> get props => [uuid];
}
