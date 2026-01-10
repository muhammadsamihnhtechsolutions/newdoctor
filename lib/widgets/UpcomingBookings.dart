
import 'package:beh_doctor/models/AppointmentModel.dart';
import 'package:beh_doctor/views/PatientInfoScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpcomingItemWidget extends StatelessWidget {
  final Appointment appointment;

  static const String imageBaseUrl =
      'https://beh-app.s3.eu-north-1.amazonaws.com/';

  const UpcomingItemWidget({super.key, required this.appointment});

  // 🔹 Local "X minutes ago"
  String getTimeAgo(DateTime? date) {
    if (date == null) return "";
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) return "just_now".tr;
    if (diff.inMinutes < 60) return "${diff.inMinutes} ${"minutes_ago".tr}";
    if (diff.inHours < 24) return "${diff.inHours} ${"hours_ago".tr}";
    return "${diff.inDays} ${"days_ago".tr}";
  }

  @override
  Widget build(BuildContext context) {
    DateTime? appointmentDate;

    if (appointment.date != null) {
      try {
        appointmentDate = DateTime.parse(appointment.date!);
        appointment.appointmentDate = appointmentDate;
      } catch (_) {}
    }

    String timeAgo = getTimeAgo(appointmentDate);

    return InkWell(
      onTap: () => Get.to(() => PatientInfoScreen(appointment: appointment)),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🔹 Profile Image with BASE URL
            CircleAvatar(
              radius: 26,
              backgroundColor: Colors.grey.shade300,
              backgroundImage:
                  (appointment.patient?.photo != null &&
                      appointment.patient!.photo!.isNotEmpty)
                  ? NetworkImage(imageBaseUrl + appointment.patient!.photo!)
                  : null,
              child:
                  (appointment.patient?.photo == null ||
                      appointment.patient!.photo!.isEmpty)
                  ? const Icon(Icons.person, size: 28)
                  : null,
            ),

            const SizedBox(width: 14),

            // 🔹 Name + Time Ago
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appointment.patient?.name ?? "unknown_patient".tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    timeAgo,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ),
            ),

            // 🔹 Right side arrow
            const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Color(0xFF1FAF54),
            ),
          ],
        ),
      ),
    );
  }
}
