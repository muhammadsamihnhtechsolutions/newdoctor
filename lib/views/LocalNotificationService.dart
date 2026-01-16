// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// class LocalNotificationService {
//   static final FlutterLocalNotificationsPlugin _plugin =
//       FlutterLocalNotificationsPlugin();

//   static Future<void> init() async {
//     const android = AndroidInitializationSettings('@mipmap/ic_launcher');

//     const settings = InitializationSettings(android: android);

//     await _plugin.initialize(settings);

//     print("✅ LocalNotification initialized");
//   }

//   static Future<void> show(RemoteMessage message) async {
//     const androidDetails = AndroidNotificationDetails(
//       'default_channel',
//       'General Notifications',
//       channelDescription: 'App notifications',
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//     const notificationDetails =
//         NotificationDetails(android: androidDetails);

//     await _plugin.show(
//       DateTime.now().millisecondsSinceEpoch ~/ 1000,
//       message.notification?.title ?? 'Notification',
//       message.notification?.body ?? '',
//       notificationDetails,
//     );
//   }
// }


import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    // ✅ iOS setup added
    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      android: android,
      iOS: ios,
    );

    await _plugin.initialize(settings);

    print("✅ LocalNotification initialized");
  }

  static Future<void> show(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'General Notifications',
      channelDescription: 'App notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    // ✅ iOS notification details added
    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      message.notification?.title ?? 'Notification',
      message.notification?.body ?? '',
      notificationDetails,
    );
  }
}
