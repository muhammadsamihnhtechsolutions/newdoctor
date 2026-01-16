import 'dart:async';
import 'dart:io';
import 'package:beh_doctor/modules/auth/controller/DoctorProfileController.dart';
import 'package:beh_doctor/repo/AuthRepo.dart';
import 'package:beh_doctor/repo/FcmHelper.dart';
import 'package:beh_doctor/shareprefs.dart';
import 'package:beh_doctor/views/BottomNavScreen.dart';
import 'package:beh_doctor/views/CreateProfileScreen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpController extends GetxController {
  final AuthRepo repo = AuthRepo();

  var otpCode = ''.obs;
  var isOtpLoading = false.obs;
  RxString fullPhoneNumber = ''.obs;

  var isResendEnabled = false.obs;
  var resendSeconds = 60.obs;
  Timer? _resendTimer;

  var isOtpExpired = false.obs;

  /// false = LOGIN OTP
  /// true  = CHANGE PHONE OTP
  bool isForChangePhone = false;

  OtpController({this.isForChangePhone = false});

  // =====================================================
  // 🔹 VERIFY OTP
  // =====================================================
  Future<void> verifyOtp({
    required String traceId,
    required String bottomNavRoute,
  }) async {
    if (isOtpExpired.value) {
      Get.snackbar('error'.tr, 'otp_expired'.tr);
      Get.delete<OtpController>(force: true); // ✅ FIX
      return;
    }

    if (otpCode.value.trim().isEmpty) {
      Get.snackbar('error'.tr, 'enter_otp'.tr);
      return;
    }

    try {
      isOtpLoading.value = true;

      final String? deviceToken;

      if (Platform.isAndroid) {
        deviceToken = await FcmHelper.ensureToken();
      } else {
        deviceToken = 'dfefdsfcdsfcsd';
      }

      if (deviceToken == null || deviceToken.isEmpty) {
        Get.snackbar(
          'error'.tr,
          'Device token not ready. Please wait & try again.',
        );
        return;
      }

      print("📲 DEVICE TOKEN => $deviceToken");

      final result = isForChangePhone
          ? await repo.verifyChangePhoneOtp(
              traceId: traceId,
              otpCode: otpCode.value.trim(),
            )
          : await repo.verifyOtp(
              traceId: traceId,
              otpCode: otpCode.value.trim(),
              deviceToken: deviceToken,
            );

      if (result.status != 'success') {
        Get.snackbar(
          'error'.tr,
          result.message ?? 'otp_verification_failed'.tr,
        );
        return;
      }

      // =================================================
      // 🔹 CHANGE PHONE SUCCESS
      // =================================================
      if (isForChangePhone) {
        if (Get.isRegistered<DoctorProfileController>()) {
          await Get.find<DoctorProfileController>().fetchDoctorProfile();
        }

        Get.back();
        Get.snackbar('success', 'Phone number updated successfully');

        Get.delete<OtpController>(force: true); // ✅ FIX
        return;
      }

      // =================================================
      // 🔹 LOGIN SUCCESS (UNCHANGED)
      // =================================================
      if (result.data?.token != null) {
        await SharedPrefs.saveToken(result.data!.token!);

        final doctorController = Get.put(
          DoctorProfileController(),
          permanent: true,
        );

        await doctorController.fetchDoctorProfile();

        final doctor = doctorController.doctor.value;

        if (doctor == null ||
            doctor.gender == null ||
            doctor.gender == "none") {
          Get.offAll(() => CreateProfileScreen());
        } else {
          Get.offAll(() => BottomNavScreen());
        }
      }
    } catch (e) {
      Get.snackbar('error'.tr, 'something_went_wrong'.tr);
    } finally {
      isOtpLoading.value = false;
    }
  }

  // =====================================================
  // 🔹 RESEND OTP
  // =====================================================
  Future<void> resendOtp({
    required String traceId,
    required String dialCode,
  }) async {
    if (!isResendEnabled.value) return;

    try {
      await repo.resendOtp(traceId: traceId, dialCode: dialCode);

      otpCode.value = '';
      isOtpExpired.value = false;

      Get.snackbar('otp'.tr, 'otp_resent_successfully'.tr);
      startResendTimer();
    } catch (e) {
      Get.snackbar('error'.tr, 'failed_to_resend_otp'.tr);
    }
  }

  // =====================================================
  // 🔹 TIMER
  // =====================================================
  void startResendTimer() {
    isResendEnabled.value = false;
    isOtpExpired.value = false;
    resendSeconds.value = 60;

    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendSeconds.value > 0) {
        resendSeconds.value--;
      } else {
        isOtpExpired.value = true;
        isResendEnabled.value = true;
        timer.cancel();
      }
    });
  }

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;

    if (args is Map) {
      fullPhoneNumber.value = args['phone'] ?? '';
      isForChangePhone = args['isForChangePhone'] ?? false;
    } else {
      fullPhoneNumber.value = args ?? '';
    }

    startResendTimer();
  }

  @override
  void onClose() {
    _resendTimer?.cancel();
    super.onClose();
  }

  static Future<String?> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }
}
