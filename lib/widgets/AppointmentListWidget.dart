import 'package:beh_doctor/views/PatientInfoScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:beh_doctor/models/AppointmentModel.dart';
import 'package:beh_doctor/shareprefs.dart';

class AppointmentListWidget extends StatelessWidget {
  final List<Appointment> appointments;
  final bool isLoading;
  final String errorMessage;
  final Future<void> Function() onRefresh;
  final bool isCompleted;

  static const String imageBaseUrl =
      'https://beh-app.s3.eu-north-1.amazonaws.com/';

  const AppointmentListWidget({
    super.key,
    required this.appointments,
    required this.isLoading,
    required this.errorMessage,
  required this.onRefresh, required this.isCompleted,
  });

  String getFullUrl(String? path) {
    if (path == null || path.isEmpty) return "";
    if (path.startsWith("http")) return path;
    final cleanBase = imageBaseUrl.endsWith("/")
        ? imageBaseUrl
        : "$imageBaseUrl/";
    final cleanPath = path.startsWith("/") ? path.substring(1) : path;
    return cleanBase + cleanPath;
  }

  // Only show "X minutes ago"
  String getTimeAgo(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "";
    try {
      final dt = DateTime.parse(dateStr).toLocal();
      final diff = DateTime.now().difference(dt);

      if (diff.inMinutes < 1) return "just_now".tr;
      if (diff.inMinutes < 60) {
        return "${diff.inMinutes} ${"minutes_ago".tr}";
      }
      if (diff.inHours < 24) {
        return "${diff.inHours} ${"hours_ago".tr}";
      }
      return "${diff.inDays} ${"days_ago".tr}";
    } catch (_) {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    if (errorMessage.isNotEmpty) return Center(child: Text(errorMessage));
    if (appointments.isEmpty)
      return Center(child: Text("no_appointments_found".tr));

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        itemCount: appointments.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final Appointment  appointment = appointments[index];
          final fullImageUrl = getFullUrl(appointment.patient?.photo);
          final timeAgo = getTimeAgo(appointment.date);
          
    print("tick nh ayaa${appointment.isPrescribed}");


          return ListTile(
            leading: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: fullImageUrl.isNotEmpty
                  ? NetworkImage(fullImageUrl)
                  : null,
              child: fullImageUrl.isEmpty ? const Icon(Icons.person) : null,
            ),

            title: Text(
              appointment.patient?.name ?? "unknown_patient".tr,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),

            subtitle: Text(
              timeAgo,
              style: TextStyle(color: Colors.grey.shade600),
            ),

            trailing: isCompleted == true
                ? const Icon(Icons.check_circle, color: Colors.green)
                : null,
            onTap: () async {
              await SharedPrefs.saveAgoraChannelId(appointment.id ?? "");
              await SharedPrefs.saveDoctorAgoraToken(
                appointment.doctorAgoraToken ?? "",
              );
              Get.to(() => PatientInfoScreen(appointment: appointment));
            },
          );
        },
      ),
    );
  }
}
