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
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:beh_doctor/modules/auth/controller/LanguageController.dart';

// class LogoutController extends GetxController {
//   final LogoutRepo _repo = LogoutRepo();

//   final RxBool isLoading = false.obs;

//   Future<void> logout() async {
//     if (isLoading.value) return; // ✅ double tap safety

//     try {
//       isLoading.value = true;

//       final prefs = await SharedPreferences.getInstance();

//       /// 🔥 Backend logout (NO DEVICE TOKEN)
//       await _repo.logout(deviceToken: null);

//       /// 🔥 CLEAR AUTH DATA ONLY
//       await prefs.remove('authToken');
//       await prefs.remove('preOtpToken');
//       await prefs.remove('token');

   
//       /// 🚪 GO TO LOGIN
//       Get.offAllNamed('/login');
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

class LogoutController extends GetxController {
  final LogoutRepo _repo = LogoutRepo();

  final RxBool isLoading = false.obs;

  /// 🔴 CALL THIS FROM UI
 void showLogoutConfirmation() {
  if (isLoading.value) return;

  Get.dialog(
    Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 32),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 🔔 TITLE
            const Text(
              "Are you sure?",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 12),

            // 📄 MESSAGE
            const Text(
              "Do you really want to logout?",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 24),

            // 🔘 BUTTONS
            Row(
              children: [
                // ❌ NO
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      side: const BorderSide(color: Color(0xFF008541)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      "No",
                      style: TextStyle(
                        color: Color(0xFF008541),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                // ✅ YES
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF008541),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      Get.back();
                      logout();
                    },
                    child: const Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}


  Future<void> logout() async {
    if (isLoading.value) return; 

    isLoading.value = true;

    try {
      final prefs = await SharedPreferences.getInstance();

      /// 🔥 BACKEND LOGOUT (WAIT FOR RESPONSE)
      await _repo
          .logout(deviceToken: null)
          .timeout(const Duration(seconds: 8));

      /// 🔥 CLEAR LOCAL DATA (AFTER API SUCCESS)
      await prefs.remove('authToken');
      await prefs.remove('preOtpToken');
      await prefs.remove('token');

      /// 🚪 GO TO LOGIN
      Get.offAllNamed('/login');

    } catch (e) {
      /// ❌ API fail / timeout
      Get.snackbar(
        "Error",
        "Logout failed. Please try again.",
      );
    } finally {
      isLoading.value = false;
    }
  }
}




   /// 🔄 RESET CONTROLLERS
      // Get.delete<BottomNavController>(force: true);
      // Get.delete<DoctorProfileController>(force: true);

      // Get.put(LanguageController(), permanent: true);
      // Get.put(BottomNavController(), permanent: true);
