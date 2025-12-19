// import 'package:beh_doctor/TranslationLanguage.dart';
// import 'package:beh_doctor/modules/auth/controller/LanguageController.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:beh_doctor/modules/auth/controller/DoctorProfileController.dart';
// import 'package:beh_doctor/routes/AppPage.dart';
// import 'package:beh_doctor/routes/AppRoutes.dart';
// import 'package:beh_doctor/shareprefs.dart';

// // 👇 ADD THIS
// import 'package:intl/date_symbol_data_local.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await SharedPrefs.init();

//   //  ADD THIS (REQUIRED FOR DateFormat)
//   await initializeDateFormatting('en', null);

//   // ------------------ LOAD SAVED LANGUAGE ------------------
//   String savedLang = SharedPrefs.getLanguage() ?? "en";

//   // ------------------ PUT CONTROLLERS ------------------
//   Get.put(LanguageController(), permanent: true);
//   Get.put(DoctorProfileController(), permanent: true);

//   // Set saved language before app start
//   Get.updateLocale(Locale(savedLang));

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final langController = Get.find<LanguageController>();

//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,

//       // ----------------- Localization Setup -----------------
//       translations: AppTranslations(),
//       locale: Locale(langController.selectedLang.value),
//       fallbackLocale: const Locale('en'),

// ignore_for_file: dead_code

//       // ----------------- Routing -----------------
//       initialRoute: Routes.LOGIN,
//       getPages: AppPages.pages,
//     );
//   }
// }
import 'dart:io';

import 'package:beh_doctor/TranslationLanguage.dart';
import 'package:beh_doctor/controller/BottomNavController.dart';
import 'package:beh_doctor/firebase_options.dart';
import 'package:beh_doctor/modules/auth/controller/LanguageController.dart';
import 'package:beh_doctor/views/ErrorScreen.dart';
import 'package:beh_doctor/widgets/MyStatusWidget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:beh_doctor/routes/AppPage.dart';
import 'package:beh_doctor/routes/AppRoutes.dart';
import 'package:beh_doctor/shareprefs.dart';

// 👇 ADD THIS
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart'; // <-- ADDED
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPrefs.init();

  //  ADD THIS (REQUIRED FOR DateFormat)
  await initializeDateFormatting('en', null);

  // 👇 ADD THIS (FIREBASE INIT)

  // await Firebase.initializeApp();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    if (kDebugMode) {
      print("Firebase initialization failed: $e");
    }

    runApp(const ErrorScreen());
    return;
  }

  // 👇 ADD THIS (GET FCM TOKEN)
  // String? token = await FirebaseMessaging.instance.getToken();
  // print("FCM TOKEN: $token");

  // ------------------ LOAD SAVED LANGUAGE ------------------
  String savedLang = SharedPrefs.getLanguage() ?? "en";

  // ------------------ PUT CONTROLLERS ------------------
  Get.put(LanguageController(), permanent: true);

  // Set saved language before app start
  Get.updateLocale(Locale(savedLang));

  // Set up loading indicator customization
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 30.0
    // ..backgroundColor = AppConstant.primarySwatch.withValues(alpha: 0.5)
    ..backgroundColor = AppColors.color008541
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..radius = 10.0
    ..userInteractions = false
    ..dismissOnTap = false;

  runApp(MyApp());
}

Future<String> getDeviceToken() async {
  // Request permissions
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
    announcement: true,
    carPlay: true,
    criticalAlert: true,
    provisional: true,
  );

  // iOS specific check
  if (Platform.isIOS) {
    String? apns = await FirebaseMessaging.instance.getAPNSToken();
    if (kDebugMode) {
      print("🔑 APNs Token: $apns");
    }

    if (apns == null) {
      print("❌ APNs token not yet set, returning empty.");
      return '';
    }
  }

  // Fetch FCM token
  String? token = await FirebaseMessaging.instance.getToken();
  print("🎯 FCM Token: $token");

  return token ?? 'dummy';
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final langController = Get.find<LanguageController>();
    final GlobalKey mediaQueryKey = GlobalKey();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      // 👇 ADD THIS LINE
      initialBinding: BindingsBuilder(() {
        Get.put(BottomNavController(), permanent: true);
        // Get.put(SplashController(), permanent: true);
      }),

      // ----------------- Localization Setup -----------------
      translations: AppTranslations(),
      locale: Locale(langController.selectedLang.value),
      fallbackLocale: const Locale('en'),

      // ----------------- Routing -----------------
      initialRoute: Routes.SPLASH,
      getPages: AppPages.pages,
      builder: (context, child) {
        return MediaQuery(
          key: mediaQueryKey,
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: EasyLoading.init()(context, child),
        );
      },
    );
  }
}
