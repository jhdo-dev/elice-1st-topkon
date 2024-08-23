import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static String get baseUrl {
    // if (Platform.isAndroid) {
    //   return 'http://10.0.2.2:3000'; //? Android 에뮬레이터
    // } else if (Platform.isIOS) {
    //   return 'http://127.0.0.1:3000'; //? iOS 에뮬레이터
    // } else {
    //   return 'http://localhost:3000'; //? 그 외의 경우
    // }
    return dotenv.env['BASE_URL']!;
  }

  static String get chatUrl {
    // if (Platform.isAndroid) {
    //   return 'http://10.0.2.2:3001/chat'; //? Android 에뮬레이터
    // } else if (Platform.isIOS) {
    //   return 'http://127.0.0.1:3001/chat'; //? iOS 에뮬레이터
    // } else {
    //   return 'http://localhost:3001/chat'; //? 그 외의 경우
    // }
    return dotenv.env['CHAT_URL']!;
  }
}
