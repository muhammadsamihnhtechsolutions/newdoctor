import 'package:beh_doctor/modules/auth/controller/DoctorProfileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:beh_doctor/modules/auth/controller/ChangePhoneNumberController.dart';


class ChangePhoneNumberScreen extends StatelessWidget {
  ChangePhoneNumberScreen({super.key});

  final controller = Get.put(ChangePhoneController());
  final profile = Get.find<DoctorProfileController>();

  final newPhoneController = TextEditingController();
  final dialCode = '+880'.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Phone Number')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Current Phone"),
            const SizedBox(height: 8),

            /// 🔒 CURRENT PHONE (FROM PROFILE)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 16,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Obx(
                () => Text(
                  profile.currentPhone.isEmpty
                      ? "Loading..."
                      : "${profile.currentDialCode}${profile.currentPhone}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
            const Text("New Phone"),
            const SizedBox(height: 8),

            Row(
              children: [
                Obx(() => Text(dialCode.value)),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: newPhoneController,
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                    decoration: const InputDecoration(
                      counterText: '',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            /// 🔘 BUTTON
            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () => controller.requestOtpForChangePhone(
                            newDialCode: dialCode.value,
                            newPhone: newPhoneController.text,
                          ),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text("Send OTP"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
