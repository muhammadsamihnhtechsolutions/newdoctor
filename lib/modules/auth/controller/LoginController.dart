

// // phnechnage
// import 'package:get/get.dart';
// import 'package:beh_doctor/repo/AuthRepo.dart';
// import 'package:beh_doctor/views/OtpScreen.dart';

// class LoginController extends GetxController {
//   final AuthRepo repo = AuthRepo();

//   static LoginController get to => Get.find<LoginController>();

//   /// 🔹 LOGIN INPUT (ONLY FOR LOGIN SCREEN)
//   final RxString loginInputPhone = ''.obs;
//   final RxString loginInputDialCode = '+880'.obs;

//   /// 🔹 LOGGED-IN USER DATA (USED EVERYWHERE ELSE)
//   final RxString currentPhone = ''.obs;
//   final RxString currentDialCode = ''.obs;

//   final RxBool isLoading = false.obs;
//   final RxString traceId = ''.obs;

//   bool get isPhoneValid => loginInputPhone.value.length == 10;

//   // =========================================================
//   // 🔹 SEND OTP (LOGIN)
//   // =========================================================
//   Future<void> sendOtp() async {
//     if (!isPhoneValid) {
//       Get.snackbar('Error', 'Enter valid phone number');
//       return;
//     }

//     try {
//       isLoading.value = true;

//       final res = await repo.requestOtp(
//         phone: loginInputPhone.value,
//         dialCode: loginInputDialCode.value,
//       );

//       if (res.status == "success" && res.data != null) {
//         traceId.value = res.data!.traceId!;

//         Get.to(
//           () => OtpScreen(
//             traceId: traceId.value,
//             bottomNavRoute: '/bottomNav',
//           ),
//           arguments: {
//             "phone":
//                 "${loginInputDialCode.value}${loginInputPhone.value}",
//             "isForChangePhone": false,
//           },
//         );
//       } else {
//         Get.snackbar(
//           "Error",
//           res.message ?? "Failed to send OTP",
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         "Error",
//         "Something went wrong. Please try again",
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // =========================================================
//   // 🔑 SET LOGGED-IN USER PHONE (AFTER PROFILE FETCH)
//   // =========================================================
//   void setLoggedInPhone({
//     required String phone,
//     required String dialCode,
//   }) {
//     try {
//       currentPhone.value = phone;
//       currentDialCode.value = dialCode;
//     } catch (_) {
//       // silent fail (safe)
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beh_doctor/repo/AuthRepo.dart';
import 'package:beh_doctor/views/OtpScreen.dart';


class LoginController extends GetxController {
  final AuthRepo repo = AuthRepo();

  final RxString loginInputPhone = ''.obs;
  final RxString loginInputDialCode = '+880'.obs;

  final RxBool isLoading = false.obs;
  final RxString traceId = ''.obs;

  bool get isPhoneValid =>
      RegExp(r'^\d{10}$').hasMatch(loginInputPhone.value);
      Future<void> sendOtp() async {
  if (!isPhoneValid) return;

  try {
    isLoading.value = true;

    debugPrint("📤 SEND OTP API CALL START");

    final res = await repo.requestOtp(
      phone: loginInputPhone.value,
      dialCode: "+880",
    );

    debugPrint("📥 SEND OTP API RESPONSE => ${res.status}");
    debugPrint("📥 SEND OTP DATA => ${res.data}");

    if (res.status == "success" && res.data != null) {
      traceId.value = res.data!.traceId!;

      debugPrint("✅ TRACE ID => ${traceId.value}");
      debugPrint("➡️ NAVIGATING TO OTP SCREEN");

      Get.to(
        () => OtpScreen(
          traceId: traceId.value,
          bottomNavRoute: '/bottomNav',
        ),
        arguments: {
          "phone":
              "${loginInputDialCode.value}${loginInputPhone.value}",
          "isForChangePhone": false,
        },
      );
    } else {
      debugPrint("❌ SEND OTP FAILED => ${res.message}");
      Get.snackbar("error".tr, res.message ?? "OTP failed");
    }
  } catch (e, s) {
    debugPrint("❌ SEND OTP EXCEPTION => $e");
    debugPrintStack(stackTrace: s);

    Get.snackbar("error".tr, "Something went wrong");
  } finally {
    isLoading.value = false;
    debugPrint("🔚 SEND OTP FLOW END");
  }
}


  // Future<void> sendOtp() async {
  //   if (!isPhoneValid) return;

  //   try {
  //     isLoading.value = true;

  //     final res = await repo.requestOtp(
  //       phone: loginInputPhone.value,
  //       dialCode: "+880",
  //     );

  //     if (res.status == "success" && res.data != null) {
  //       traceId.value = res.data!.traceId!;

  //       Get.put(OtpController(isForChangePhone: false));

  //       Get.to(() => OtpScreen(
  //             traceId: traceId.value,
  //             bottomNavRoute: '/bottomNav',
  //           ),
  //           arguments: {
  //             "phone":
  //                 "${loginInputDialCode.value}${loginInputPhone.value}",
  //             "isForChangePhone": false,
  //           });
  //     }
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
}
