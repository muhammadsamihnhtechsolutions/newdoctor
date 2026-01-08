// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// class LocalNotificationService {
//   static FlutterLocalNotificationsPlugin? _plugin;

//   /// 🔔 INITIALIZE LOCAL NOTIFICATION
//   static Future<void> init() async {
//     _plugin ??= FlutterLocalNotificationsPlugin();

//     const android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const settings = InitializationSettings(android: android);

//     await _plugin!.initialize(settings);
//   }

//   static Future<void> _ensureInit() async {
//     if (_plugin == null) {
//       await init();
//     }
//   }

//   /// 🔔 SIMPLE LOCAL NOTIFICATION (MANUAL CALL)
//   static Future<void> showSimple({
//     required String title,
//     required String body,
//   }) async {
//     await _ensureInit();

//     const androidDetails = AndroidNotificationDetails(
//       'withdraw_channel',
//       'Withdraw Notifications',
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//     const details = NotificationDetails(android: androidDetails);

//     await _plugin!.show(
//       DateTime.now().millisecondsSinceEpoch ~/ 1000,
//       title,
//       body,
//       details,
//     );
//   }

//   /// 🔔 FIREBASE FOREGROUND NOTIFICATION
//   static Future<void> show(RemoteMessage message) async {
//     await _ensureInit();

//     const androidDetails = AndroidNotificationDetails(
//       'default_channel',
//       'Default',
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//     const details = NotificationDetails(android: androidDetails);

//     await _plugin!.show(
//       DateTime.now().millisecondsSinceEpoch ~/ 1000,
//       message.notification?.title ?? "Notification",
//       message.notification?.body ?? "",
//       details,
//     );
//   }
// }
