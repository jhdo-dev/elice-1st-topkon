import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static String get baseUrl {
    return dotenv.env['BASE_URL']!;
  }

  static String get chatUrl {
    return dotenv.env['CHAT_URL']!;
  }
}
