// import 'package:beh_doctor/models/AppointmentModel.dart';
// import 'package:beh_doctor/views/PatientInfoScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class UpcomingItemWidget extends StatelessWidget {
//   final Appointment appointment;

//   const UpcomingItemWidget({super.key, required this.appointment});

//   @override
//   Widget build(BuildContext context) {
//     DateTime? appointmentDate;
//     if (appointment.date != null) {
//       try {
//         appointmentDate = DateTime.parse(appointment.date!).toUtc();
//         appointment.appointmentDate = appointmentDate;
//       } catch (_) {
//         appointmentDate = null;
//       }
//     }

//     String formattedDate = appointmentDate != null
//         ? DateFormat('dd MMM yyyy, hh:mm a').format(appointmentDate)
//         : (appointment.date ?? "");

//     return InkWell(
//       onTap: () {
//         Get.to(() => PatientInfoScreen(appointment: appointment));
//       },
//       child: Container(
//         color: Colors.white,
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         child: Row(
//           children: [
//             CircleAvatar(
//               radius: 25,
//               backgroundImage: appointment.patient?.photo != null
//                   ? NetworkImage(appointment.patient!.photo!)
//                   : null,
//               child: appointment.patient?.photo == null
//                   ? const Icon(Icons.person)
//                   : null,
//             ),
//             const SizedBox(width: 10),

//             // NAME + DATE
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     appointment.patient?.name ?? "Unknown",
//                     style: const TextStyle(
//                         fontWeight: FontWeight.w600, fontSize: 16),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     formattedDate,
//                     style: const TextStyle(color: Colors.grey),
//                   ),
//                 ],
//               ),
//             ),

//             const Icon(Icons.arrow_forward_ios,
//                 size: 18, color: Color(0xFF1FAF54)) // 🔹 green theme
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:beh_doctor/models/AppointmentModel.dart';
// import 'package:beh_doctor/views/PatientInfoScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class UpcomingItemWidget extends StatelessWidget {
//   final Appointment appointment;

//   const UpcomingItemWidget({super.key, required this.appointment});

//   // 🔹 Calculate "X minutes ago"
//   String getTimeAgo(DateTime? date) {
//     if (date == null) return "";
//     final now = DateTime.now().toUtc();
//     final diff = now.difference(date);

//     if (diff.inMinutes < 1) return "Just now";
//     if (diff.inMinutes < 60) return "${diff.inMinutes} minutes ago";
//     if (diff.inHours < 24) return "${diff.inHours} hours ago";
//     return "${diff.inDays} days ago";
//   }

//   @override
//   Widget build(BuildContext context) {
//     DateTime? appointmentDate;

//     if (appointment.date != null) {
//       try {
//         appointmentDate = DateTime.parse(appointment.date!).toUtc();
//         appointment.appointmentDate = appointmentDate;
//       } catch (_) {}
//     }

//     String timeAgo = getTimeAgo(appointmentDate);

//     return InkWell(
//       onTap: () => Get.to(() => PatientInfoScreen(appointment: appointment)),
//       child: Container(
//         color: Colors.white,
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // 🔹 Profile Image (with baseURL)
//             CircleAvatar(
//               radius: 26,
//               backgroundColor: Colors.grey.shade300,
//               backgroundImage: (appointment.patient?.photo != null &&
//                       appointment.patient!.photo!.isNotEmpty)
//                   ? NetworkImage(
//                       "https://your-base-url.com/${appointment.patient!.photo!}")
//                   : null,
//               child: (appointment.patient?.photo == null ||
//                       appointment.patient!.photo!.isEmpty)
//                   ? const Icon(Icons.person, size: 28)
//                   : null,
//             ),

//             const SizedBox(width: 14),

//             // 🔹 Name + time ago
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     appointment.patient?.name ?? "Unknown",
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w600,
//                       fontSize: 16,
//                     ),
//                   ),

//                   const SizedBox(height: 6),

//                   Text(
//                     timeAgo,
//                     style: const TextStyle(
//                       color: Colors.grey,
//                       fontSize: 13,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // 🔹 Arrow aligned right
//             const Icon(
//               Icons.arrow_forward_ios,
//               color: Color(0xFF1FAF54),
//               size: 18,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

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
