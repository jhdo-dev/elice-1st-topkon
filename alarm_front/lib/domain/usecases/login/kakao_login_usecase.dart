import 'package:alarm_front/domain/entities/user.dart';
import 'package:alarm_front/domain/repositories/login_repo.dart';
import 'package:dartz/dartz.dart';

class KakaoLoginUsecase {
  final LoginRepo repo;

  KakaoLoginUsecase({required this.repo});

  Future<Either<String, User>> call() async {
    return await repo.logInWithKakao();
  }
}
