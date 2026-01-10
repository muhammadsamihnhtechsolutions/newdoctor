
import 'package:beh_doctor/modules/auth/controller/DoctorProfileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConsultationFeeTab extends StatelessWidget {
  const ConsultationFeeTab({super.key});

  static const Color _green = Color(0xFF008541);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DoctorProfileController>();

    return Obx(() {
      final doctor = controller.doctor.value;

      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (doctor == null) {
        return const Center(child: Text("No profile data"));
      }

      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Consultation Fee
            _feeField(
              title: "Consultation Fee",
              value: doctor.consultationFee ?? "0",
            ),

            const SizedBox(height: 12),

            /// Follow Up Fee
            _feeField(
              title: "Follow Up Fee",
              value: doctor.followupFee ?? "0",
            ),

            const SizedBox(height: 16),

            /// About
            const Text(
              "Write about yourself",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                border: Border.all(color: _green),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                doctor.about?.isNotEmpty == true
                    ? doctor.about!
                    : "No description added",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _feeField({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: _green),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              const Text(
                "Tk.",
                style: TextStyle(
                  fontSize: 14,
                  color: _green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
