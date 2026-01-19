// //     // 🔥 SAB TOKEN CLEAR
// //     await prefs.remove('authToken');     // main token
// //     await prefs.remove('preOtpToken');    // pre otp token
// //     await prefs.remove('token');          // agar kahin aur save ho

// //     // 🔥 GetX controllers clear
// //     Get.deleteAll(force: true);
// import 'package:get/get.dart';
// import 'package:beh_doctor/modules/auth/controller/LanguageController.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LogoutController extends GetxController {
//   Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();

//     // 🔥 SAB TOKEN CLEAR
//     await prefs.remove('authToken'); // main auth token
//     await prefs.remove('preOtpToken'); // pre-OTP token
//     // 🔹 "token" key ab purani hai, isse remove karna optional hai
//     await prefs.remove('token');

//     // 🔥 GetX controllers clear
//     Get.deleteAll(force: true);

//     if (!Get.isRegistered<LanguageController>()) {
//       Get.put(LanguageController(), permanent: true);
//     }

//     // 🔥 Navigate to login screen
//     Get.offAllNamed('/login');

//     Get.snackbar("logout".tr, "successfully_logged_out".tr);
//   }
// }

// import 'package:get/get.dart';
// import 'package:beh_doctor/modules/auth/controller/LanguageController.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:beh_doctor/shareprefs.dart';

// class LogoutController extends GetxController {
//   Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();

//     // 🔥 SAB TOKEN CLEAR
//     await prefs.remove('authToken');      // main auth token
//     await prefs.remove('preOtpToken');    // pre-OTP token
//     await prefs.remove('token');          // legacy token

//     // 🔥 FCM TOKEN CLEAR (IMPORTANT)
//     await SharedPrefs.clearFcmToken();

//     // 🔥 GetX controllers clear
//     Get.deleteAll(force: true);

//     if (!Get.isRegistered<LanguageController>()) {
//       Get.put(LanguageController(), permanent: true);
//     }

//     // 🔥 Navigate to login
//     Get.offAllNamed('/login');

//     Get.snackbar("logout".tr, "successfully_logged_out".tr);
//   }
// }

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:beh_doctor/shareprefs.dart';
// import 'package:beh_doctor/modules/auth/controller/LanguageController.dart';

// class LogoutController extends GetxController {
//   Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();

//     // 🔥 Backend ko token invalidation (optional but best)
//     final oldFcmToken = await SharedPrefs.getFcmToken();
//     if (oldFcmToken != null) {
//       // TODO: call logout API and pass deviceToken
//     }

//     // 🔥 Firebase FCM token delete
//     await FirebaseMessaging.instance.deleteToken();

//     // 🔥 Local tokens clear
//     await prefs.remove('authToken');
//     await prefs.remove('preOtpToken');
//     await prefs.remove('token');
//     await SharedPrefs.clearFcmToken();

//     // 🔥 Controllers clear
//     Get.deleteAll(force: true);

//     if (!Get.isRegistered<LanguageController>()) {
//       Get.put(LanguageController(), permanent: true);
//     }

//     Get.offAllNamed('/login');
//     Get.snackbar("logout".tr, "successfully_logged_out".tr);
//   }
// }

// import 'package:beh_doctor/controller/BottomNavController.dart';
// import 'package:beh_doctor/modules/auth/controller/DoctorProfileController.dart';
// import 'package:beh_doctor/repo/AuthRepo.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:beh_doctor/shareprefs.dart';
// import 'package:beh_doctor/modules/auth/controller/LanguageController.dart';

// class LogoutController extends GetxController {
//   final LogoutRepo _repo = LogoutRepo();

//   final RxBool isLoading = false.obs; // ✅ ADD THIS

//   Future<void> logout() async {
//     if (isLoading.value) return; // ✅ double tap safety

//     try {
//       isLoading.value = true;

//       final prefs = await SharedPreferences.getInstance();
//       final deviceToken = await SharedPrefs.getFcmToken();

//       /// 🔥 Backend logout
//       await _repo.logout(deviceToken: deviceToken);

//       await FirebaseMessaging.instance.deleteToken();
//       await SharedPrefs.clearFcmToken();

//       await prefs.remove('authToken');
//       await prefs.remove('preOtpToken');
//       await prefs.remove('token');

//       Get.delete<BottomNavController>(force: true);
//       Get.delete<DoctorProfileController>(force: true);

//       Get.put(LanguageController(), permanent: true);
//       Get.put(BottomNavController(), permanent: true);

//       Get.offAllNamed('/login');
//     } catch (e) {
//       // optional: log only
//       rethrow;
//     } finally {
//       isLoading.value = false; // ✅ STOP LOADER
//     }
//   }
// }

import 'package:beh_doctor/controller/BottomNavController.dart';
import 'package:beh_doctor/modules/auth/controller/DoctorProfileController.dart';
import 'package:beh_doctor/repo/AuthRepo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:beh_doctor/modules/auth/controller/LanguageController.dart';

class LogoutController extends GetxController {
  final LogoutRepo _repo = LogoutRepo();

  final RxBool isLoading = false.obs;

  Future<void> logout() async {
    if (isLoading.value) return; // ✅ double tap safety

    try {
      isLoading.value = true;

      final prefs = await SharedPreferences.getInstance();

      /// 🔥 Backend logout (NO DEVICE TOKEN)
      await _repo.logout(deviceToken: null);

      /// 🔥 CLEAR AUTH DATA ONLY
      await prefs.remove('authToken');
      await prefs.remove('preOtpToken');
      await prefs.remove('token');

      /// 🔄 RESET CONTROLLERS
      // Get.delete<BottomNavController>(force: true);
      // Get.delete<DoctorProfileController>(force: true);

      // Get.put(LanguageController(), permanent: true);
      // Get.put(BottomNavController(), permanent: true);

      /// 🚪 GO TO LOGIN
      Get.offAllNamed('/login');
    } finally {
      isLoading.value = false;
    }
  }
}
