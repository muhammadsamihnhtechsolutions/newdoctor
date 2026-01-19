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

    const settings = InitializationSettings(android: android, iOS: ios);

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

//get token
// ignore_for_file: avoid_print, unused_local_variable, use_build_context_synchronously, unnecessary_type_check, unnecessary_null_comparison

// import 'dart:io';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';

// import '../../../../routes/routes.dart';
// import '../../../../vendor/db/vendor_preferences_helper.dart';
// import '../../../db/user_preferences_helper.dart';

// class LocalNotificationService {
//   //initialising firebase message plugin
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//   //initialising firebase message plugin
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   //send notificartion request
//   void requestNotificationPermission() async {
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       announcement: true,
//       badge: true,
//       carPlay: true,
//       criticalAlert: true,
//       provisional: true,
//       sound: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       if (kDebugMode) {
//         print('user granted permission');
//       }
//     } else if (settings.authorizationStatus ==
//         AuthorizationStatus.provisional) {
//       if (kDebugMode) {
//         print('user granted provisional permission');
//       }
//     } else {
//       //appsetting.AppSettings.openNotificationSettings();
//       if (kDebugMode) {
//         print('user denied permission');
//       }
//     }
//   }

//   Future<String> getDeviceToken() async {
//     // Request permissions
//     await messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//       announcement: true,
//       carPlay: true,
//       criticalAlert: true,
//       provisional: true,
//     );

//     // iOS specific check
//     if (Platform.isIOS) {
//       String? apns = await messaging.getAPNSToken();
//       print("🔑 APNs Token: $apns");

//       if (apns == null) {
//         print("❌ APNs token not yet set, returning empty.");
//         return '';
//       }
//     }

//     // Fetch FCM token
//     String? token = await messaging.getToken();
//     print("🎯 FCM Token: $token");

//     return token ?? 'dummy';
//   }

//   // //Fetch FCM Token
//   // Future<String> getDeviceToken() async {
//   //   NotificationSettings settings = await messaging.requestPermission(
//   //     alert: true,
//   //     badge: true,
//   //     sound: true,
//   //     announcement: true,
//   //     carPlay: true,
//   //     criticalAlert: true,
//   //     provisional: true,
//   //   );

//   //   String? token = await messaging.getToken();
//   //   print("token=> $token");
//   //   return token!;
//   // }

//   //function to initialise flutter local notification plugin to show notifications for android when app is active
//   void initLocalNotifications(
//       BuildContext context, RemoteMessage message) async {
//     var androidInitializationSettings =
//         const AndroidInitializationSettings('@mipmap/ic_launcher');
//     var iosInitializationSettings = const DarwinInitializationSettings();

//     var initializationSetting = InitializationSettings(
//         android: androidInitializationSettings, iOS: iosInitializationSettings);

//     await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
//         onDidReceiveNotificationResponse: (payload) {
//       // handle interaction when app is active for android
//       handleMessage(context, message);
//     });
//   }

// //
//   void firebaseInit(BuildContext context) {
//     //foreground
//     FirebaseMessaging.onMessage.listen((message) async {
//       RemoteNotification? notification = message.notification;
//       AndroidNotification? android = message.notification!.android;

//       if (kDebugMode) {
//         print("notifications title:${notification!.title}");
//         print("notifications body:${notification.body}");
//         print('count:${android?.count}');
//         print('data:${message.data.toString()}');
//       }

//       if (Platform.isIOS) {
//         forgroundMessage();
//       }

//       if (Platform.isAndroid) {
//         initLocalNotifications(context, message);
//         showNotification(message);
//       }
//     });
//   }

//   //handle tap on notification when app is in background or terminated
//   Future<void> setupInteractMessage(BuildContext context) async {
//     // // when app is terminated
//     // RemoteMessage? initialMessage =
//     //     await FirebaseMessaging.instance.getInitialMessage();

//     // if (initialMessage != null) {
//     //   handleMessage(context, initialMessage);
//     // }

//     //when app ins background
//     FirebaseMessaging.onMessageOpenedApp.listen((event) {
//       handleMessage(context, event);
//     });

//     // Handle terminated state
//     FirebaseMessaging.instance
//         .getInitialMessage()
//         .then((RemoteMessage? message) {
//       if (message != null && message.data.isNotEmpty) {
//         handleMessage(context, message);
//       }
//     });
//   }

//   // function to show visible notification when app is active
//   Future<void> showNotification(RemoteMessage message) async {
//     AndroidNotificationChannel channel = AndroidNotificationChannel(
//       message.notification!.android!.channelId.toString(),
//       message.notification!.android!.channelId.toString(),
//       importance: Importance.max,
//       showBadge: true,
//       playSound: true,
//       enableLights: true,
//       enableVibration: true,
//       // sound: const RawResourceAndroidNotificationSound('jetsons_doorbell'),
//     );

//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//             channel.id.toString(), channel.name.toString(),
//             channelDescription: 'your channel description',
//             importance: Importance.high,
//             priority: Priority.high,
//             playSound: true,
//             ticker: 'ticker',
//             enableLights: true,
//             enableVibration: true,
//             sound: channel.sound
//             //     sound: RawResourceAndroidNotificationSound('jetsons_doorbell')
//             //  icon: largeIconPath
//             );

//     const DarwinNotificationDetails darwinNotificationDetails =
//         DarwinNotificationDetails(
//       presentAlert: true,
//       presentBadge: true,
//       presentSound: true,
//       presentBanner: true,
//       presentList: true,
//     );

//     NotificationDetails notificationDetails = NotificationDetails(
//         android: androidNotificationDetails, iOS: darwinNotificationDetails);

//     Future.delayed(Duration.zero, () {
//       _flutterLocalNotificationsPlugin.show(
//         0,
//         message.notification!.title.toString(),
//         message.notification!.body.toString(),
//         notificationDetails,
//         payload: 'my_data',
//       );
//     });
//   }

// //for ios
//   Future forgroundMessage() async {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//   }

//   Future<void> handleMessage(
//     BuildContext context,
//     RemoteMessage message,
//   ) async {
//     print("Message received: ${message.data}");
//     VendorPreferencesHelper vendorPreferencesHelper = VendorPreferencesHelper();
//     UserPreferencesHelper userPreferencesHelper = UserPreferencesHelper();

//     final String? vendorToken = await vendorPreferencesHelper.getToken();
//     final String? userToken = await userPreferencesHelper.getToken();

//     // ✅ Extract notification_type from data
//     final String? notificationType = message.data['notification_type'];
//     final dataMessage = message.data;

//     // 🔐 Decide navigation based on token presence
//     if (notificationType == "user") {
//       if (userToken != null && userToken.isNotEmpty) {
//         Get.toNamed(AppRoutes.notificationScreen);
//       } else {
//         Get.toNamed(AppRoutes.signInScreen);
//       }
//     } else {
//       if (vendorToken != null && vendorToken.isNotEmpty) {
//         Get.toNamed(AppRoutes.fetchAllVendorNotificationScreen);
//       } else {
//         Get.toNamed(AppRoutes.vendorSignInScreen);
//       }
//     }
//   }
// }
