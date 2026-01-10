

// import 'package:beh_doctor/modules/auth/controller/NotificationController.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';


// class NotificationScreen extends StatelessWidget {
//   NotificationScreen({super.key});

//   final NotificationController controller =
//       Get.put(NotificationController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         title: const Text(
//           "Notifications",
//           style: TextStyle(
//             color: Colors.black,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         iconTheme: const IconThemeData(color: Colors.black),
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (controller.errorMessage.isNotEmpty) {
//           return Center(
//             child: Text(
//               controller.errorMessage.value,
//               style: const TextStyle(color: Colors.red),
//             ),
//           );
//         }

//         if (controller.notifications.isEmpty) {
//           return const Center(
//             child: Text(
//               "No notifications found",
//               style: TextStyle(color: Colors.black54),
//             ),
//           );
//         }

//         return ListView.builder(
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           itemCount: controller.notifications.length,
//           itemBuilder: (context, index) {
//             final notification = controller.notifications[index];

//             /// 👇 Appointment readable text
//             String subtitleText = notification.body ?? "";
//             if (notification.criteria == "appointment" &&
//                 notification.metaData?.appointmentType != null) {
//               subtitleText =
//                   "Appointment ${notification.metaData!.appointmentType} update";
//             }

//             return Container(
//               margin: const EdgeInsets.symmetric(
//                 horizontal: 12,
//                 vertical: 6,
//               ),
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   /// 🔔 GREEN ICON
//                   Container(
//                     height: 44,
//                     width: 44,
//                     decoration: BoxDecoration(
//                       color: Colors.green.withOpacity(0.1),
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(
//                       Icons.notifications,
//                       color: Colors.green,
//                     ),
//                   ),
//                   const SizedBox(width: 12),

//                   /// 📄 TEXT AREA
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           notification.title ?? "",
//                           style: const TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black,
//                           ),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           subtitleText,
//                           style: const TextStyle(
//                             fontSize: 13,
//                             color: Colors.black87,
//                           ),
//                         ),
//                         const SizedBox(height: 6),
//                         Text(
//                           notification.createdAt ?? "",
//                           style: const TextStyle(
//                             fontSize: 11,
//                             color: Colors.grey,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }
import 'package:beh_doctor/modules/auth/controller/NotificationController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotificationController controller =
      Get.put(NotificationController());

  /// ✅ DATE TIME FORMATTER
  String formatDateTime(String? date) {
    if (date == null || date.isEmpty) return "";

    try {
      final DateTime parsedDate = DateTime.parse(date).toLocal();
      return DateFormat('dd MMM yyyy • hh:mm a').format(parsedDate);
    } catch (e) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
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

        if (controller.notifications.isEmpty) {
          return const Center(
            child: Text(
              "No notifications found",
              style: TextStyle(color: Colors.black54),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final notification = controller.notifications[index];

            /// 👇 Appointment readable text
            String subtitleText = notification.body ?? "";
            if (notification.criteria == "appointment" &&
                notification.metaData?.appointmentType != null) {
              subtitleText =
                  "Appointment ${notification.metaData!.appointmentType} update";
            }

            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔔 GREEN ICON
                  Container(
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.notifications,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 12),

                  /// 📄 TEXT AREA
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification.title ?? "",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitleText,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          formatDateTime(notification.createdAt),
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}

