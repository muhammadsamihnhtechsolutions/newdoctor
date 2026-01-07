import 'package:beh_doctor/modules/auth/controller/DoctorProfileController.dart';
import 'package:get/get.dart';
import 'package:beh_doctor/repo/AuthRepo.dart';
import 'package:beh_doctor/views/OtpScreen.dart';


class ChangePhoneController extends GetxController {
  final AuthRepo _repo = AuthRepo();

  final isLoading = false.obs;

  /// 🔑 SOURCE OF TRUTH
  final DoctorProfileController profile =
      Get.find<DoctorProfileController>();

  Future<void> requestOtpForChangePhone({
    required String newDialCode,
    required String newPhone,
  }) async {
    if (newPhone.length != 10) {
      Get.snackbar("Error", "Enter valid phone number");
      return;
    }

    /// 🔐 PROFILE SAFETY CHECK
    if (profile.currentPhone.isEmpty ||
        profile.currentDialCode.isEmpty) {
      Get.snackbar("Error", "Profile still loading");
      return;
    }

    try {
      isLoading.value = true;

      final traceId = await _repo.requestChangePhoneOtp(
        currentDialCode: profile.currentDialCode,
        currentPhone: profile.currentPhone,
        newDialCode: newDialCode,
        newPhone: newPhone,
      );

      if (traceId != null) {
        Get.to(
          () => OtpScreen(
            traceId: traceId,
            bottomNavRoute: '/profile',
            isForChangePhone: true,
          ),
          arguments: {
            "phone": "$newDialCode$newPhone",
            "isForChangePhone": true,
          },
        );
      } else {
        Get.snackbar("Error", "Failed to send OTP");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
}
