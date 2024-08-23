import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void initializeFCM(FlutterLocalNotificationsPlugin local) async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // 알림 권한 요청
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }

  // FCM 토큰 가져오기
  String? token = await messaging.getToken();
  print("FCM Token: $token");

  // FCM 백그라운드 메시지 처리 핸들러 설정
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // 포그라운드에서 메시지 수신
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Received message while in foreground: ${message.messageId}');
    _showNotification(message, local);
  });

  // 앱이 백그라운드에서 열릴 때 메시지 처리
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Message clicked!');
    _showNotification(message, local);
  });
}

// FCM 백그라운드 메시지 핸들러
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");

  // 널 체크 추가
  if (message.notification != null) {
    FlutterLocalNotificationsPlugin local = FlutterLocalNotificationsPlugin();
    _showNotification(message, local);
  }
}

// 로컬 알림 표시
Future<void> _showNotification(
    RemoteMessage message, FlutterLocalNotificationsPlugin local) async {
  final notification = message.notification;
  final title = notification?.title ?? '기본 제목';
  final body = notification?.body ?? '기본 내용';

  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'channel_id', 'channel_name', // 채널 ID와 이름
    importance: Importance.max,
    priority: Priority.high,
    icon: '@drawable/android12splash',
  );
  const NotificationDetails notificationDetails =
      NotificationDetails(android: androidDetails);

  await local.show(
    message.hashCode,
    title,
    body,
    notificationDetails,
    payload: message.data['payload'],
  );
}
