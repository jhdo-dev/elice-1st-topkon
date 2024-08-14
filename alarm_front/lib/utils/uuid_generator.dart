import 'dart:math';

class UuidGenerator {
  static String generateUuid() {
    final now = DateTime.now();
    final random = Random();

    //* 현재 시간을 기반으로 밀리초까지 포함한 문자열 생성
    String timeComponent = now.microsecondsSinceEpoch.toString();

    //* 4자리의 랜덤 숫자 생성
    String randomComponent = random.nextInt(10000).toString().padLeft(4, '0');

    //* 두 값을 결합하여 UUID 생성
    return '$timeComponent-$randomComponent';
  }
}
