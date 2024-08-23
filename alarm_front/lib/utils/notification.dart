import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

void permissionWithNotification() async {
  if (await Permission.notification.isDenied &&
      !await Permission.notification.isPermanentlyDenied) {
    await [Permission.notification].request();
  }
}

void initialization(FlutterLocalNotificationsPlugin local) async {
  AndroidInitializationSettings android =
      const AndroidInitializationSettings("@mipmap/ic_launcher");
  DarwinInitializationSettings ios = const DarwinInitializationSettings(
    requestSoundPermission: true, // 알림 권한 요청을 true로 변경
    requestBadgePermission: true,
    requestAlertPermission: true,
  );
  InitializationSettings settings =
      InitializationSettings(android: android, iOS: ios);
  await local.initialize(settings);
}
