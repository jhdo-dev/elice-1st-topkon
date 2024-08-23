import 'package:firebase_messaging/firebase_messaging.dart';

Future<String?> getFcmToken() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  return await messaging.getToken();
}
