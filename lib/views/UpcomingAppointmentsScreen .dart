import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beh_doctor/modules/AppointmentController.dart';
import 'package:beh_doctor/widgets/UpcomingBookings.dart';

class UpcomingAppointmentsScreen extends StatelessWidget {
  final AppointmentController controller = Get.find<AppointmentController>();

  UpcomingAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔹 Fetch appointments when screen loads
    controller.fetchAppointments();

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text("upcoming_appointments".tr),
        centerTitle: true,
      ),
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

        if (controller.upcomingAppointments.isEmpty) {
          return Center(
            child: Text(
              "no_upcoming_appointments".tr,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.only(top: 8),
          itemCount: controller.upcomingAppointments.length,
          separatorBuilder: (_, __) => const Divider(height: 0),
          itemBuilder: (context, index) {
            final appointment = controller.upcomingAppointments[index];
            return UpcomingItemWidget(appointment: appointment);
          },
        );
      }),
    );
  }
}
