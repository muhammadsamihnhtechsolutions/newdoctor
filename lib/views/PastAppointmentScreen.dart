import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beh_doctor/modules/AppointmentController.dart';
import 'package:beh_doctor/widgets/UpcomingBookings.dart';

class PastAppointmentScreen extends StatelessWidget {
  final AppointmentController controller = Get.find<AppointmentController>();

  PastAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔹 Fetch appointments when screen loads
    controller.fetchAppointments();

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(title: Text("past_appointments".tr), centerTitle: true),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (controller.pastAppointments.isEmpty) {
          return Center(
            child: Text(
              "no_past_appointments".tr,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.only(top: 8),
          itemCount: controller.pastAppointments.length,
          separatorBuilder: (_, __) => const Divider(height: 0),
          itemBuilder: (context, index) {
            final appointment = controller.pastAppointments[index];
            return UpcomingItemWidget(appointment: appointment);
          },
        );
      }),
    );
  }
}
