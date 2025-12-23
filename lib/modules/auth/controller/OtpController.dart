import 'package:beh_doctor/repo/AuthRepo.dart';
import 'package:beh_doctor/views/BottomNavScreen.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpController extends GetxController {
  final AuthRepo repo = AuthRepo();

  var otpCode = ''.obs;
  var isOtpLoading = false.obs;
  RxString fullPhoneNumber = ''.obs;

  var isResendEnabled = false.obs;
  var resendSeconds = 30.obs;
  Timer? _resendTimer;

  /// 🔹 Verify OTP and save user token
  Future<void> verifyOtp({
    required String traceId,
    required String bottomNavRoute,
  }) async {
    if (otpCode.value.isEmpty) {
      Get.snackbar('error'.tr, 'enter_otp'.tr);
      return;
    }

    try {
      isOtpLoading.value = true;

      // Device token generate karna (unique per device/session)
      final deviceToken = DateTime.now().millisecondsSinceEpoch.toString();
      final prefs = await SharedPreferences.getInstance();
      final preToken = prefs.getString('preOtpToken');

      print("📌 Sending Pre-OTP Token to server: $preToken");

      final result = await repo.verifyOtp(
        traceId: traceId,
        otpCode: otpCode.value,
        deviceToken: deviceToken,
      );

      print("OTP RESULT=> $result");

      if (result.status == 'success' &&
          result.data != null &&
          result.data!.token != null) {
        // Save user token in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', result.data!.token!);

        Get.snackbar('success'.tr, 'otp_verified_token_saved'.tr);
        Get.offAll(() => BottomNavScreen());
      } else {
        Get.snackbar(
          'error'.tr,
          result.message ?? 'otp_verification_failed'.tr,
        );
      }
    } finally {
      isOtpLoading.value = false;
    }
  }

  /// 🔹 Resend OTP
  Future<void> resendOtp({
    required String traceId,
    required String dialCode,
  }) async {
    if (!isResendEnabled.value) return;

    try {
      await repo.resendOtp(traceId: traceId, dialCode: dialCode);
      Get.snackbar('otp'.tr, 'otp_resent_successfully'.tr);
      startResendTimer();
    } catch (e) {
      Get.snackbar('error'.tr, 'failed_to_resend_otp'.tr);
    }
  }

  /// 🔹 Start resend OTP timer
  void startResendTimer() {
    isResendEnabled.value = false;
    resendSeconds.value = 30;

    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendSeconds.value > 0) {
        resendSeconds.value--;
      } else {
        isResendEnabled.value = true;
        timer.cancel();
      }
    });
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   startResendTimer();
  // }
  @override
void onInit() {
  super.onInit();

  // ✅ SAFE PHONE NUMBER RECEIVE
  fullPhoneNumber.value = Get.arguments ?? "";

  startResendTimer();
}


  @override
  void onClose() {
    _resendTimer?.cancel();
    super.onClose();
  }

  /// 🔹 Helper to get saved user token anywhere
  static Future<String?> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }
}
