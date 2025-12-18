//     // 🔥 SAB TOKEN CLEAR
//     await prefs.remove('authToken');     // main token
//     await prefs.remove('preOtpToken');    // pre otp token
//     await prefs.remove('token');          // agar kahin aur save ho

//     // 🔥 GetX controllers clear
//     Get.deleteAll(force: true);
import 'package:get/get.dart';
import 'package:beh_doctor/modules/auth/controller/LanguageController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutController extends GetxController {
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    // 🔥 SAB TOKEN CLEAR
    await prefs.remove('authToken'); // main auth token
    await prefs.remove('preOtpToken'); // pre-OTP token
    // 🔹 "token" key ab purani hai, isse remove karna optional hai
    await prefs.remove('token');

    // 🔥 GetX controllers clear
    Get.deleteAll(force: true);

    if (!Get.isRegistered<LanguageController>()) {
      Get.put(LanguageController(), permanent: true);
    }

    // 🔥 Navigate to login screen
    Get.offAllNamed('/login');

    Get.snackbar("logout".tr, "successfully_logged_out".tr);
  }
}
