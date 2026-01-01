
// import 'package:beh_doctor/modules/auth/controller/DoctorProfileController.dart';
// import 'package:beh_doctor/views/CreateProfileScreen.dart';
// import 'package:beh_doctor/views/OtpScreen.dart';
// import 'package:get/get.dart';
// import 'package:beh_doctor/repo/AuthRepo.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class LoginController extends GetxController {
//   final AuthRepo repo = AuthRepo();

//   var phone = ''.obs;
//   var dialCode = '+880'.obs;
//   var isLoading = false.obs;

//   var traceId = ''.obs;
//   var deviceToken = ''.obs;

//   // 🔹 Request OTP
//   Future<void> sendOtp() async {
//     if (phone.value.isEmpty) {
//       Get.snackbar('error'.tr, 'enter_phone_number'.tr);
//       return;
//     }

//     try {
//       isLoading.value = true;

//       final res = await repo.requestOtp(
//         phone: phone.value,
//         dialCode: dialCode.value,
//       );

//       print("📌 OTP API Response: ${res.toJson()}");

//       if (res.status == "success" && res.data != null) {
//         traceId.value = res.data?.traceId ?? "";
//         print("📌 TRACEID Saved: ${traceId.value}");

//         //  IMPORTANT FIX
//         if (res.data?.token != null) {
//           final prefs = await SharedPreferences.getInstance();
//           await prefs.setString('preOtpToken', res.data!.token!);
//           print("🔵 Pre-OTP TOKEN Saved: ${res.data!.token!}");
//         }

//       Get.to(
//   () => OtpScreen(
//     traceId: traceId.value,
//     bottomNavRoute: '/bottomNav',
//   ),
//   arguments: "${dialCode.value}${phone.value}", // ✅ phone pass
// );

//       } else {
//         Get.snackbar("error".tr, res.message ?? "unknown_error".tr);
//       }
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> handlePostLoginNavigation() async {
//   final doctorController = Get.put(DoctorProfileController());

//   await doctorController.fetchDoctorProfile();

//   if (doctorController.doctor.value == null) {
//     // ❌ Doctor profile EXIST NAHI
//     Get.offAll(() => CreateProfileScreen());
//   } else {
//     // ✅ Doctor profile EXIST karta hai
//     Get.offAllNamed('/bottomNav');
//   }
// }

// }

import 'package:beh_doctor/modules/auth/controller/DoctorProfileController.dart';
import 'package:beh_doctor/views/CreateProfileScreen.dart';
import 'package:beh_doctor/views/OtpScreen.dart';
import 'package:get/get.dart';
import 'package:beh_doctor/repo/AuthRepo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final AuthRepo repo = AuthRepo();

  var phone = ''.obs;
  var dialCode = '+880'.obs;
  var isLoading = false.obs;

  var traceId = ''.obs;
  var deviceToken = ''.obs;

  /// 🔒 Bangladesh rule → +880 ke baad 10 digits
  bool get isPhoneValid => phone.value.length == 10;

  // 🔹 Request OTP
  Future<void> sendOtp() async {
    if (!isPhoneValid) {
      Get.snackbar('error'.tr, 'enter_phone_number'.tr);
      return;
    }

    try {
      isLoading.value = true;

      final res = await repo.requestOtp(
        phone: phone.value,
        dialCode: dialCode.value,
      );

      if (res.status == "success" && res.data != null) {
        traceId.value = res.data?.traceId ?? "";

        if (res.data?.token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('preOtpToken', res.data!.token!);
        }

        Get.to(
          () => OtpScreen(
            traceId: traceId.value,
            bottomNavRoute: '/bottomNav',
          ),
          arguments: "${dialCode.value}${phone.value}",
        );
      } else {
        Get.snackbar("error".tr, res.message ?? "unknown_error".tr);
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> handlePostLoginNavigation() async {
    final doctorController = Get.put(DoctorProfileController());

    await doctorController.fetchDoctorProfile();

    if (doctorController.doctor.value == null) {
      Get.offAll(() => CreateProfileScreen());
    } else {
      Get.offAllNamed('/bottomNav');
    }
  }
}
