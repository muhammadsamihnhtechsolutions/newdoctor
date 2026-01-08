// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';

// class NotificationController extends GetxController {
//   @override
//   void onInit() {
//     super.onInit();

//     /// Request permissions
//     FirebaseMessaging.instance.requestPermission();

//     /// Foreground messages
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       if (message.notification != null) {
//         _showLocalNotification(
//           title: message.notification!.title ?? "Notification",
//           body: message.notification!.body ?? "",
//         );
//       }
//     });

//     /// App opened from terminated or background
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print("Notification clicked: ${message.data}");
//       // Example: navigate to transaction page
//       if (message.data['type'] == 'withdraw') {
//         Get.toNamed('/withdraw_history');
//       }
//     });
//   }

//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   void initLocalNotification() {
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     const InitializationSettings initializationSettings =
//         InitializationSettings(android: initializationSettingsAndroid);

//     _flutterLocalNotificationsPlugin.initialize(initializationSettings);
//   }

//   void _showLocalNotification({required String title, required String body}) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'withdraw_channel', // unique id
//       'Withdraw Notifications',
//       channelDescription: 'Notifications for wallet withdraw',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);

//     await _flutterLocalNotificationsPlugin.show(
//       0,
//       title,
//       body,
//       platformChannelSpecifics,
//     );
//   }
// }
