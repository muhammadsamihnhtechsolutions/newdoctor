
import 'package:beh_doctor/theme/Appcolars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:beh_doctor/modules/auth/controller/OtpController.dart';

class OtpScreen extends StatelessWidget {
  final String traceId;
  final String bottomNavRoute;
  final bool isForChangePhone; // ✅ NEW (safe)

  OtpScreen({
    super.key,
    required this.traceId,
    required this.bottomNavRoute,
    this.isForChangePhone = false, // ✅ DEFAULT
  });

  @override
  Widget build(BuildContext context) {
    // final OtpController controller = Get.put(
    //   OtpController(isForChangePhone: isForChangePhone),
    //   permanent: true,
    // );
    final OtpController controller = Get.put(
  OtpController(isForChangePhone: isForChangePhone),
);


    return Scaffold(
      backgroundColor: AppColors.white,

      appBar: AppBar(
        title: Text("verify_its_you".tr),
        centerTitle: true,
        backgroundColor: AppColors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.delete<OtpController>(force: true); // ✅ cleanup
            Get.back();
          },
        ),
      ),

      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Obx(() {
          return Stack(
            children: [
              _buildUI(controller),

              if (controller.isOtpLoading.value)
                Container(
                  color: Colors.white.withOpacity(0.8),
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildUI(OtpController controller) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                "assets/svgs/otp_lock.svg",
                height: 100,
                color: AppColors.color008541,
              ),

              const SizedBox(height: 24),

              Text(
                "otp_sent_to".tr,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),

              const SizedBox(height: 8),

              Obx(() => Text(
                    controller.fullPhoneNumber.value,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.color008541,
                    ),
                  )),

              const SizedBox(height: 28),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  6,
                  (index) => _OtpBox(index: index, controller: controller),
                ),
              ),

              const SizedBox(height: 24),

              Obx(
                () => GestureDetector(
                  onTap: controller.isResendEnabled.value
                      ? () => controller.resendOtp(
                            traceId: traceId,
                            dialCode: "+880",
                          )
                      : null,
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 14),
                      children: [
                        const TextSpan(style: TextStyle(color: Colors.grey)),
                        TextSpan(
                          text: controller.isResendEnabled.value
                              ? "resend_otp_q".tr
                              : "${"resend".tr}? (${controller.resendSeconds.value}s)",
                          style: TextStyle(
                            color: AppColors.color008541,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.color008541,
                    foregroundColor: AppColors.white,
                  ),
                  onPressed: () => controller.verifyOtp(
                    traceId: traceId,
                    bottomNavRoute: bottomNavRoute,
                  ),
                  child: Text("verify".tr),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OtpBox extends StatelessWidget {
  final int index;
  final OtpController controller;

  const _OtpBox({required this.index, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 56,
      child: TextField(
        cursorColor: AppColors.color008541,
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.color008541,
        ),
        decoration: InputDecoration(
          counterText: "",
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.color008541, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: AppColors.color008541, width: 2),
          ),
        ),
        onChanged: (val) {
          controller.otpCode.value =
              controller.otpCode.value.padRight(6, ' ');

          if (val.isNotEmpty) {
            controller.otpCode.value = controller.otpCode.value.replaceRange(
              index,
              index + 1,
              val,
            );
            FocusScope.of(context).nextFocus();
          } else {
            controller.otpCode.value = controller.otpCode.value.replaceRange(
              index,
              index + 1,
              ' ',
            );
            if (index > 0) FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}
