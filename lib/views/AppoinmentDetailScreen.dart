// import 'package:beh_doctor/modules/auth/controller/AppoinmentDetailController.dart';
// import 'package:beh_doctor/repo/AuthRepo.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';


// class AppointmentDetailsWidget extends StatelessWidget {
//   final String appointmentId;

//   const AppointmentDetailsWidget({required this.appointmentId, super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Initialize the controller with the repo
//     final controller = Get.put(
//       AppointmentDetailsController(
//         repo: AppointmentRepo(),
//       ),
//     );

//     // Fetch appointment details on widget load
//     controller.fetchAppointmentDetails(appointmentId);

//     return Obx(() {
//       if (controller.isLoading.value) {
//         return const Center(child: CircularProgressIndicator());
//       }

//       final data = controller.appointmentDetails.value;

//       if (data == null) {
//         return const Center(child: Text("No data available"));
//       }

//       final eyeTest = data.appointmentDetailsData?.eyeTest;
//       final prescriptions = data.appointmentDetailsData?.prescriptions ?? [];

//       return SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Status: ${data.status}", style: const TextStyle(fontSize: 16)),
//             const SizedBox(height: 8),
//             Text("Message: ${data.message}"),
//             const SizedBox(height: 16),
//             const Text("Eye Test Data:", style: TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 4),
//             Text("Visual Acuity Left OS: ${eyeTest?.appTest?.data?.visualAcuity?.left?.os ?? '-'}"),
//             Text("Visual Acuity Right OD: ${eyeTest?.appTest?.data?.visualAcuity?.right?.od ?? '-'}"),
//             const SizedBox(height: 16),
//             const Text("Prescriptions:", style: TextStyle(fontWeight: FontWeight.bold)),
//             const SizedBox(height: 4),
//             if (prescriptions.isEmpty)
//               const Text("No prescriptions available")
//             else
//               ...prescriptions.map((p) => Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 2),
//                     child: Text(p.title ?? '-'),
//                   )),
//           ],
//         ),
//       );
//     });
//   }
// }
