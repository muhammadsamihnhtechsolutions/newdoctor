import 'package:beh_doctor/modules/auth/controller/AppoinmentDetailController.dart';
import 'package:beh_doctor/views/PrescriptionScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beh_doctor/routes/AppRoutes.dart';
import 'package:beh_doctor/modules/auth/controller/AgoraCallController.dart';

class CallOptionsBottomSheet extends StatelessWidget {
  const CallOptionsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AgoraCallController>();
    final appt = controller.currentAppointment;
    final patient = appt?.patient;

    return Container(
      padding: const EdgeInsets.all(20),
      height: MediaQuery.of(context).size.height * 0.65,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---- drag handle ----
          Center(
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "patient_options".tr,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 16),

          // ---------------- PATIENT RECORD STYLE OPTIONS ----------------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _recordStyleButton(
                    title: "previous_prescriptions".tr,
                    onTap: () {
                      if (patient?.id == null) {
                        Get.snackbar("error".tr, "patient_id_missing".tr);
                        return;
                      }

                      Get.back(); // 🔥 CLOSE BOTTOM SHEET

                      Future.delayed(const Duration(milliseconds: 150), () {
                        Get.lazyPut(() => AppointmentDetailsController());
                        Get.to(
                          () => PrescriptionListScreen(patientId: patient!.id!),
                        );
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _recordStyleButton(
                    title: "test_result".tr,
                    onTap: () {
                      if (appt == null) {
                        Get.snackbar("error".tr, "appointment_data_missing".tr);
                        return;
                      }

                      Get.back(); // 🔥 CLOSE BOTTOM SHEET

                      Future.delayed(const Duration(milliseconds: 150), () {
                        Get.lazyPut(() => AppointmentDetailsController());
                        Get.toNamed(Routes.AppTestWidget, arguments: appt);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ---------------- APPOINTMENT REASON ----------------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "appointment_reason".tr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  appt?.reason ?? "no_reason_provided".tr,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- RECORD STYLE BUTTON ----------------
  Widget _recordStyleButton({
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 72,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.green.shade200),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, size: 20, color: Colors.green),
          ],
        ),
      ),
    );
  }
}
