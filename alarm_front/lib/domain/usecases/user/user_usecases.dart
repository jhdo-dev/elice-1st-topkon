import 'package:alarm_front/domain/usecases/user/authenticate_usecase.dart';
import 'package:alarm_front/domain/usecases/user/update_user_usecase.dart';

class UserUsecases {
  final AuthenticateUsecase authenticateUsecase;
  final UpdateUserUsecase updateUserUsecase;
  UserUsecases({
    required this.authenticateUsecase,
    required this.updateUserUsecase,
  });
}
