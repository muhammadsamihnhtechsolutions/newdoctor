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

//       // ----------------- Routing -----------------
//       initialRoute: Routes.LOGIN,
//       getPages: AppPages.pages,
//     );
//   }
// }
import 'package:beh_doctor/TranslationLanguage.dart';
import 'package:beh_doctor/controller/BottomNavController.dart';
import 'package:beh_doctor/firebase_options.dart';
import 'package:beh_doctor/modules/auth/controller/LanguageController.dart';
import 'package:beh_doctor/views/ErrorScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:beh_doctor/routes/AppPage.dart';
import 'package:beh_doctor/routes/AppRoutes.dart';
import 'package:beh_doctor/shareprefs.dart';

// 👇 ADD THIS
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart'; // <-- ADDED
import 'package:firebase_messaging/firebase_messaging.dart';

import 'modules/auth/controller/SplashController.dart'; // <-- ADDED

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
  String? token = await FirebaseMessaging.instance.getToken();
  print("FCM TOKEN: $token");

  // ------------------ LOAD SAVED LANGUAGE ------------------
  String savedLang = SharedPrefs.getLanguage() ?? "en";

  // ------------------ PUT CONTROLLERS ------------------
  Get.put(LanguageController(), permanent: true);

  // Set saved language before app start
  Get.updateLocale(Locale(savedLang));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final langController = Get.find<LanguageController>();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      // 👇 ADD THIS LINE
      initialBinding: BindingsBuilder(() {
        Get.put(BottomNavController(), permanent: true);  Get.put(SplashController(), permanent: true,);

      }),

      // ----------------- Localization Setup -----------------
      translations: AppTranslations(),
      locale: Locale(langController.selectedLang.value),
      fallbackLocale: const Locale('en'),

      // ----------------- Routing -----------------
      initialRoute: Routes.SPLASH,
      getPages: AppPages.pages,
    );
  }
}

