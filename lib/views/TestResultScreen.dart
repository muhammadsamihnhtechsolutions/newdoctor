
import 'package:beh_doctor/models/AppointmentModel.dart';
import 'package:beh_doctor/modules/auth/controller/AppoinmentDetailController.dart';
import 'package:beh_doctor/widgets/AppTestWidget.dart';
import 'package:beh_doctor/widgets/ClinicalResultWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestResultScreen extends StatefulWidget {
  final String appointmentId;

  const TestResultScreen({
    super.key,
    required this.appointmentId,
    required Appointment appointment,
  });

  @override
  State<TestResultScreen> createState() => _TestResultScreenState();
}

class _TestResultScreenState extends State<TestResultScreen> {
  final RxInt selectedTab = 0.obs;
  late final AppointmentDetailsController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.put(
      AppointmentDetailsController(),
      permanent: true,
    );

    /// 🔥 API CALL ONLY ONCE
    controller.fetchAppointmentDetails(widget.appointmentId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text(
          "Test Results",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),

      body: Column(
        children: [
          const SizedBox(height: 12),

          /// ================= TAB UI =================
          Obx(() {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF008541)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  _innerTab(
                    title: "App Test",
                    isSelected: selectedTab.value == 0,
                    onTap: () => selectedTab.value = 0,
                  ),
                  _innerTab(
                    title: "Clinical Results",
                    isSelected: selectedTab.value == 1,
                    onTap: () => selectedTab.value = 1,
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 12),

          /// ================= BODY =================
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              return selectedTab.value == 0
                  ? const AppTestWidget()
                  : ClinicalResultWidget();
            }),
          ),
        ],
      ),
    );
  }

  /// ---------- TAB BUTTON ----------
  Widget _innerTab({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF008541) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
