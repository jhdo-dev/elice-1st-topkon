import 'package:alarm_front/data/datasources/login_datasource.dart';
import 'package:alarm_front/domain/entities/user.dart';
import 'package:alarm_front/domain/repositories/login_repo.dart';
import 'package:dartz/dartz.dart';

class LoginRepoImpl extends LoginRepo {
  final GoogleLoginDatasource? googleLoginDatasource;
  final KakaoLoginDatasource? kakaoLoginDatasource;
  LoginRepoImpl({
    this.googleLoginDatasource,
    this.kakaoLoginDatasource,
  });

  @override
  Future<Either<String, User>> logInWithGoogle() async {
    if (googleLoginDatasource == null) {
      return Left("구글 로그인에 문제가 있습니다.");
    }
    final result = await googleLoginDatasource!.logIn();
    return result.fold(
      (err) => Left(err),
      (user) => Right(user.toEntity()),
    );
  }

  @override
  Future<Either<String, User>> logInWithKakao() async {
    if (kakaoLoginDatasource == null) {
      return Left("카카오 로그인에 문제가 있습니다.");
    }
    final result = await kakaoLoginDatasource!.logIn();
    return result.fold(
      (err) => Left(err),
      (user) => Right(user.toEntity()),
    );
  }
}
