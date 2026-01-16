// import 'package:beh_doctor/TranslationLanguage.dart';
// import 'package:beh_doctor/controller/BottomNavController.dart';
// import 'package:beh_doctor/firebase_options.dart';
// import 'package:beh_doctor/modules/auth/controller/LanguageController.dart';
// import 'package:beh_doctor/views/LocalNotificationService.dart';
// import 'package:beh_doctor/widgets/MyStatusWidget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';

// import 'package:beh_doctor/routes/AppPage.dart';
// import 'package:beh_doctor/routes/AppRoutes.dart';
// import 'package:beh_doctor/shareprefs.dart';

// import 'package:intl/date_symbol_data_local.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// /// 🔔 BACKGROUND HANDLER
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   print("🔔 Background message received");
//   print("📦 Data: ${message.data}");
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await SharedPrefs.init();
//   await initializeDateFormatting('en', null);

//   /// 🔥 FIREBASE INIT
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   /// 🔔 LOCAL NOTIFICATION INIT (IMPORTANT)
//   await LocalNotificationService.init();

//   /// 🔔 BACKGROUND REGISTER
//   FirebaseMessaging.onBackgroundMessage(
//     firebaseMessagingBackgroundHandler,
//   );

//   /// 🔔 PERMISSION
//   await FirebaseMessaging.instance.requestPermission(
//     alert: true,
//     badge: true,
//     sound: true,
//   );

// final fcmToken = await FirebaseMessaging.instance.getToken();

// if (fcmToken != null && fcmToken.isNotEmpty) {
//   await SharedPrefs.saveFcmToken(fcmToken);
//   print("🔥 SAVED FCM TOKEN: $fcmToken");
// }

// // FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
// //   await SharedPrefs.saveFcmToken(newToken);
// //   print("🔄 FCM TOKEN REFRESHED: $newToken");
// // });

// FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setString('fcmToken', newToken);
//   print("🔄 FCM TOKEN REFRESHED: $newToken");
// });

//   /// 🔔 FOREGROUND MESSAGE
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     print("🔔 FOREGROUND MESSAGE RECEIVED");
//     print("📝 Title: ${message.notification?.title}");
//     print("📝 Body: ${message.notification?.body}");
//     print("📦 Data: ${message.data}");

//     /// ✅ FOREGROUND MAIN LOCAL NOTIFICATION
//     LocalNotificationService.show(message);
//   });

//   /// 🔔 TAP HANDLER
//   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     print("👉 Notification clicked");
//     print("📦 Data: ${message.data}");
//   });

//   /// ------------------ LANGUAGE ------------------
//   String savedLang = SharedPrefs.getLanguage() ?? "en";

//   Get.put(LanguageController(), permanent: true);

//   Get.updateLocale(Locale(savedLang));

//   /// ------------------ EASY LOADING ------------------
//   EasyLoading.instance
//     ..indicatorType = EasyLoadingIndicatorType.threeBounce
//     ..loadingStyle = EasyLoadingStyle.custom
//     ..indicatorSize = 30.0
//     ..backgroundColor = AppColors.color008541
//     ..indicatorColor = Colors.white
//     ..textColor = Colors.white
//     ..radius = 10.0
//     ..userInteractions = false
//     ..dismissOnTap = false;

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final langController = Get.find<LanguageController>();

//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,

//       initialBinding: BindingsBuilder(() {
//         Get.put(BottomNavController(), permanent: true);
//       }),

//       translations: AppTranslations(),
//       locale: Locale(langController.selectedLang.value),
//       fallbackLocale: const Locale('en'),

//       initialRoute: Routes.SPLASH,
//       getPages: AppPages.pages,

//       builder: (context, child) {
//         return MediaQuery(
//           data: MediaQuery.of(context)
//               .copyWith(textScaler: const TextScaler.linear(1.0)),
//           child: EasyLoading.init()(context, child),
//         );
//       },
//     );
//   }
// }

// import 'dart:async';

// import 'package:beh_doctor/TranslationLanguage.dart';
// import 'package:beh_doctor/controller/BottomNavController.dart';
// import 'package:beh_doctor/firebase_options.dart';
// import 'package:beh_doctor/modules/auth/controller/LanguageController.dart';
// import 'package:beh_doctor/views/LocalNotificationService.dart';
// import 'package:beh_doctor/widgets/MyStatusWidget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';

// import 'package:beh_doctor/routes/AppPage.dart';
// import 'package:beh_doctor/routes/AppRoutes.dart';
// import 'package:beh_doctor/shareprefs.dart';

// import 'package:intl/date_symbol_data_local.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// /// 🔔 BACKGROUND HANDLER
// Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   print("🔔 Background message received");
//   print("📦 Data: ${message.data}");
// }

// void main() {
//   runZonedGuarded(() async {
//     WidgetsFlutterBinding.ensureInitialized();

//     /// ✅ GLOBAL FLUTTER ERROR CATCH
//     FlutterError.onError = (FlutterErrorDetails details) {
//       FlutterError.dumpErrorToConsole(details);
//       print("❌ FLUTTER ERROR: ${details.exception}");
//     };

//     await SharedPrefs.init();
//     await initializeDateFormatting('en', null);

//     /// 🔥 FIREBASE INIT
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );

//     /// 🔔 LOCAL NOTIFICATION INIT
//     await LocalNotificationService.init();

//     /// 🔔 BACKGROUND REGISTER
//     FirebaseMessaging.onBackgroundMessage(
//       firebaseMessagingBackgroundHandler,
//     );

//     /// 🔔 PERMISSION
//     await FirebaseMessaging.instance.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     /// ✅ FCM TOKEN (SINGLE SOURCE)
//     final fcmToken = await FirebaseMessaging.instance.getToken();
//     if (fcmToken != null && fcmToken.isNotEmpty) {
//       await SharedPrefs.saveFcmToken(fcmToken);
//       print("🔥 SAVED FCM TOKEN: $fcmToken");
//     }

//     /// ✅ TOKEN REFRESH (ONLY ONE LISTENER)
//     FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
//       await SharedPrefs.saveFcmToken(newToken);
//       print("🔄 FCM TOKEN REFRESHED: $newToken");
//     });

//     /// 🔔 FOREGROUND MESSAGE
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print("🔔 FOREGROUND MESSAGE RECEIVED");
//       print("📝 Title: ${message.notification?.title}");
//       print("📝 Body: ${message.notification?.body}");
//       print("📦 Data: ${message.data}");

//       LocalNotificationService.show(message);
//     });

//     /// 🔔 TAP HANDLER
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print("👉 Notification clicked");
//       print("📦 Data: ${message.data}");
//     });

//     /// ------------------ LANGUAGE ------------------
//     String savedLang = SharedPrefs.getLanguage() ?? "en";
//     Get.put(LanguageController(), permanent: true);
//     Get.updateLocale(Locale(savedLang));

//     /// ------------------ EASY LOADING ------------------
//     EasyLoading.instance
//       ..indicatorType = EasyLoadingIndicatorType.threeBounce
//       ..loadingStyle = EasyLoadingStyle.custom
//       ..indicatorSize = 30.0
//       ..backgroundColor = AppColors.color008541
//       ..indicatorColor = Colors.white
//       ..textColor = Colors.white
//       ..radius = 10.0
//       ..userInteractions = false
//       ..dismissOnTap = false;

//     runApp(MyApp());
//   }, (error, stack) {
//     /// ✅ RELEASE APK CRASH CATCH
//     print("❌ ZONED ERROR: $error");
//     print(stack);
//   });
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final langController = Get.find<LanguageController>();

//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,

//       initialBinding: BindingsBuilder(() {
//         Get.put(BottomNavController(), permanent: true);
//       }),

//       translations: AppTranslations(),
//       locale: Locale(langController.selectedLang.value),
//       fallbackLocale: const Locale('en'),

//       initialRoute: Routes.SPLASH,
//       getPages: AppPages.pages,

//       builder: (context, child) {
//         return MediaQuery(
//           data: MediaQuery.of(context)
//               .copyWith(textScaler: const TextScaler.linear(1.0)),
//           child: EasyLoading.init()(context, child),
//         );
//       },
//     );
//   }
// }

import 'dart:async';
import 'dart:io';

import 'package:beh_doctor/TranslationLanguage.dart';
import 'package:beh_doctor/controller/BottomNavController.dart';
import 'package:beh_doctor/firebase_options.dart';
import 'package:beh_doctor/modules/auth/controller/LanguageController.dart';
import 'package:beh_doctor/views/LocalNotificationService.dart';
import 'package:beh_doctor/widgets/MyStatusWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:beh_doctor/routes/AppPage.dart';
import 'package:beh_doctor/routes/AppRoutes.dart';
import 'package:beh_doctor/shareprefs.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

/// 🔔 BACKGROUND HANDLER
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  print("🔔 Background message received");
  print("📦 Data: ${message.data}");
}

void main() {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      /// ✅ GLOBAL FLUTTER ERROR CATCH
      FlutterError.onError = (FlutterErrorDetails details) {
        FlutterError.dumpErrorToConsole(details);
        print("❌ FLUTTER ERROR: ${details.exception}");
      };

      await SharedPrefs.init();
      await initializeDateFormatting('en', null);

      /// 🔥 FIREBASE INIT
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      /// 🍎 iOS FOREGROUND NOTIFICATION ENABLE (ONLY ADDITION)
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
            alert: true,
            badge: true,
            sound: true,
          );

      /// 🔔 LOCAL NOTIFICATION INIT
      await LocalNotificationService.init();

      /// 🔔 BACKGROUND REGISTER
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      /// 🔔 PERMISSION
      await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      /// ✅ FCM TOKEN (SINGLE SOURCE)
      ///
      if (Platform.isAndroid) {
        final fcmToken = await FirebaseMessaging.instance.getToken();
        if (fcmToken != null && fcmToken.isNotEmpty) {
          await SharedPrefs.saveFcmToken(fcmToken);
          print("🔥 SAVED FCM TOKEN: $fcmToken");
        }
      }

      /// ✅ TOKEN REFRESH (ONLY ONE LISTENER)
      FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
        await SharedPrefs.saveFcmToken(newToken);
        print("🔄 FCM TOKEN REFRESHED: $newToken");
      });

      /// 🔔 FOREGROUND MESSAGE
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print("🔔 FOREGROUND MESSAGE RECEIVED");
        print("📝 Title: ${message.notification?.title}");
        print("📝 Body: ${message.notification?.body}");
        print("📦 Data: ${message.data}");

        LocalNotificationService.show(message);
      });

      /// 🔔 TAP HANDLER
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        print("👉 Notification clicked");
        print("📦 Data: ${message.data}");
      });

      /// ------------------ LANGUAGE ------------------
      String savedLang = SharedPrefs.getLanguage() ?? "en";
      Get.put(LanguageController(), permanent: true);
      Get.updateLocale(Locale(savedLang));

      /// ------------------ EASY LOADING ------------------
      EasyLoading.instance
        ..indicatorType = EasyLoadingIndicatorType.threeBounce
        ..loadingStyle = EasyLoadingStyle.custom
        ..indicatorSize = 30.0
        ..backgroundColor = AppColors.color008541
        ..indicatorColor = Colors.white
        ..textColor = Colors.white
        ..radius = 10.0
        ..userInteractions = false
        ..dismissOnTap = false;

      runApp(MyApp());
    },
    (error, stack) {
      /// ✅ RELEASE APK CRASH CATCH
      print("❌ ZONED ERROR: $error");
      print(stack);
    },
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final langController = Get.find<LanguageController>();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      initialBinding: BindingsBuilder(() {
        Get.put(BottomNavController(), permanent: true);
      }),

      translations: AppTranslations(),
      locale: Locale(langController.selectedLang.value),
      fallbackLocale: const Locale('en'),

      initialRoute: Routes.SPLASH,
      getPages: AppPages.pages,

      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: EasyLoading.init()(context, child),
        );
      },
    );
  }
}
