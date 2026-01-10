

// phnechnage
import 'package:get/get.dart';
import 'package:beh_doctor/repo/AuthRepo.dart';
import 'package:beh_doctor/views/OtpScreen.dart';

class LoginController extends GetxController {
  final AuthRepo repo = AuthRepo();

  static LoginController get to => Get.find<LoginController>();

  /// 🔹 LOGIN INPUT (ONLY FOR LOGIN SCREEN)
  final RxString loginInputPhone = ''.obs;
  final RxString loginInputDialCode = '+880'.obs;

  /// 🔹 LOGGED-IN USER DATA (USED EVERYWHERE ELSE)
  final RxString currentPhone = ''.obs;
  final RxString currentDialCode = ''.obs;

  final RxBool isLoading = false.obs;
  final RxString traceId = ''.obs;

  bool get isPhoneValid => loginInputPhone.value.length == 10;

  // =========================================================
  // 🔹 SEND OTP (LOGIN)
  // =========================================================
  Future<void> sendOtp() async {
    if (!isPhoneValid) {
      Get.snackbar('Error', 'Enter valid phone number');
      return;
    }

    try {
      isLoading.value = true;

      final res = await repo.requestOtp(
        phone: loginInputPhone.value,
        dialCode: loginInputDialCode.value,
      );

      if (res.status == "success" && res.data != null) {
        traceId.value = res.data!.traceId!;

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
        Get.snackbar(
          "Error",
          res.message ?? "Failed to send OTP",
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong. Please try again",
      );
    } finally {
      isLoading.value = false;
    }
  }

  // =========================================================
  // 🔑 SET LOGGED-IN USER PHONE (AFTER PROFILE FETCH)
  // =========================================================
  void setLoggedInPhone({
    required String phone,
    required String dialCode,
  }) {
    try {
      currentPhone.value = phone;
      currentDialCode.value = dialCode;
    } catch (_) {
      // silent fail (safe)
    }
  }
}
