

// import 'package:beh_doctor/apiconstant/apiconstant.dart';
// import 'package:beh_doctor/models/AppointmentModel.dart';
// import 'package:beh_doctor/modules/auth/controller/AgoraCallController.dart';
// import 'package:beh_doctor/theme/Appcolars.dart';
// import 'package:beh_doctor/views/PrescriptionScreen.dart';
// import 'package:beh_doctor/views/TestResultScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:beh_doctor/shareprefs.dart';

// class PatientInfoScreen extends StatelessWidget {
//   final Appointment appointment;

//   PatientInfoScreen({super.key, required this.appointment});

//   String buildImageUrl(String path) {
//     if (path.startsWith('http')) return path;
//     return "${ApiConstants.imageBaseUrl}$path";
//   }

//   @override
//   Widget build(BuildContext context) {
//     final patient = appointment.patient;

//     String? profileImage =
//         (patient?.photo != null && patient!.photo!.isNotEmpty)
//             ? buildImageUrl(patient.photo!)
//             : null;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: const BackButton(color: Colors.black),
//         title: const Text(
//           "Patient Information",
//           style: TextStyle(
//             fontSize: 17,
//             fontWeight: FontWeight.w600,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Patient Info",
//               style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 10),

//             // ---------------- PATIENT CARD ----------------
//             Container(
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade100,
//                 borderRadius: BorderRadius.circular(14),
//               ),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 32,
//                     backgroundImage:
//                         profileImage != null ? NetworkImage(profileImage) : null,
//                     child: profileImage == null
//                         ? const Icon(Icons.person, size: 30)
//                         : null,
//                   ),
//                   const SizedBox(width: 14),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         patient?.name ?? "Unknown",
//                         style: const TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         "${patient?.gender ?? ''} • ${appointment.age ?? ''} Years • ${appointment.weight ?? ''} KG",
//                         style: const TextStyle(
//                           fontSize: 12,
//                           color: Colors.black54,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 22),

//             // ---------------- PATIENT RECORDS (GREY BG FIXED) ----------------
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade100,
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Patient Records",
//                     style: TextStyle(
//                       fontSize: 15,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: _recordBox(
//                           title: "Previous\nPrescriptions",
//                           onTap: () {
//                             Get.to(() => PrescriptionListScreen(
//                                   patientId: patient?.id ?? "",
//                                 ));
//                           },
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       Expanded(
//                         child: _recordBox(
//                           title: "Test\nResults",
//                           onTap: () {
//                             Get.to(() => TestResultScreen(
//                                   appointmentId: appointment.id ?? "",
//                                   appointment: appointment,
//                                 ));
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 22),

//             // ---------------- EYE TEST ----------------
//             const Text(
//               "Eye Test",
//               style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 10),

//             Builder(
//               builder: (_) {
//                 final eyeTests = appointment.eyePhotos;

//                 if (eyeTests == null || eyeTests.isEmpty) {
//                   return _emptyBox("No eye test image");
//                 }

//                 return Wrap(
//                   spacing: 12,
//                   runSpacing: 12,
//                   children: eyeTests.map((path) {
//                     return _imageBox(buildImageUrl(path));
//                   }).toList(),
//                 );
//               },
//             ),

//             const SizedBox(height: 22),

//             // ---------------- APPOINTMENT REASON (FIXED PROPERLY) ----------------
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade100,
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Appointment Reason",
//                     style: TextStyle(
//                       fontSize: 16, // 🔼 bigger
//                       fontWeight: FontWeight.bold, // 🔥 bold
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     appointment.reason ?? "No reason provided",
//                     style: const TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     appointment.description ?? "No description provided",
//                     style: const TextStyle(
//                       fontSize: 13,
//                       fontWeight: FontWeight.normal, // ✅ normal
//                       color: Colors.black87,
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 22),

//             // ---------------- ADDITIONAL ATTACHMENTS ----------------
         

// //             // ---------------------- ATTACHMENTS ----------------------
//             const Text(
//               "Additional Attachments",
//               style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 12),

//             appointment.additionalFiles != null &&
//                     appointment.additionalFiles!.isNotEmpty
//                 ? Wrap(
//                     spacing: 14,
//                     runSpacing: 14,
//                     children: appointment.additionalFiles!.map((filePath) {
//                       String fullUrl = "${ApiConstants.imageBaseUrl}$filePath";
//                       return Container(
//                         width: 105,
//                         height: 105,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(16),
//                           color: Colors.grey.shade200,
//                           image: DecorationImage(
//                             image: NetworkImage(fullUrl),
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   )
//                 : Container(
//                     height: 120,
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade100,
//                       borderRadius: BorderRadius.circular(16),
//                       border: Border.all(color: Colors.grey.shade300),
//                     ),
//                     child: const Center(
//                       child: Text(
//                         "No attachments found",
//                         style: TextStyle(color: Colors.black45),
//                       ),
//                     ),
//                   ),

//             const SizedBox(height: 30),
          

//             // ---------------- CALL NOW BUTTON ----------------
//             SizedBox(
//               width: double.infinity,
//               height: 48,
//               child: ElevatedButton(
//                 onPressed: () async {
//                   final controller = Get.put(AgoraCallController());
//                   await SharedPrefs.saveAgoraChannelId(appointment.id ?? "");
//                   await SharedPrefs.saveDoctorAgoraToken(
//                       appointment.doctorAgoraToken ?? "");
//                   controller.setAppointment(appointment);
//                   await controller.callNow();
//                 },
//                 style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.color008541,
//                   foregroundColor: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.videocam, size: 20),
//                     SizedBox(width: 8),
//                     Text(
//                       "Call Now",
//                       style:
//                           TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 16),
//           ],
//         ),
//       ),
//     );
//   }

//   // ---------------- RECORD BOX ----------------
//   Widget _recordBox({required String title, required VoidCallback onTap}) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         height: 72,
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(14),
//           border: Border.all(color: Colors.green.shade200),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Text(
//                 title,
//                 textAlign: TextAlign.center,
//                 style:
//                     const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
//               ),
//             ),
//             const Icon(
//               Icons.chevron_right,
//               color: Colors.green,
//               size: 20,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

// Widget _imageBox(String imageUrl) {
//   return GestureDetector(
//     onTap: () {
//       showDialog(
//         context: Get.context!,
//         barrierColor: Colors.black,
//         builder: (dialogContext) { 
//           return GestureDetector(
//             onTap: () => Navigator.pop(dialogContext), 
//             child: Center(
//               child: Image.network(
//                 imageUrl,
//                 fit: BoxFit.contain,
//               ),
//             ),
//           );
//         },
//       );
//     },
//     child: Container(
//       width: 100,
//       height: 100,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(14),
//         color: Colors.grey.shade200,
//         image: DecorationImage(
//           image: NetworkImage(imageUrl),
//           fit: BoxFit.cover,
//         ),
//       ),
//     ),
//   );
// }


//   Widget _emptyBox(String text) {
//     return Container(
//       height: 110,
//       width: double.infinity,
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         color: Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Text(
//         text,
//         style: const TextStyle(fontSize: 13, color: Colors.black45),
//       ),
//     );
//   }
// }

import 'package:beh_doctor/apiconstant/apiconstant.dart';
import 'package:beh_doctor/models/AppointmentModel.dart';
import 'package:beh_doctor/modules/auth/controller/AgoraCallController.dart';
import 'package:beh_doctor/theme/Appcolars.dart';
import 'package:beh_doctor/views/PrescriptionScreen.dart';
import 'package:beh_doctor/views/TestResultScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beh_doctor/shareprefs.dart';
import 'package:url_launcher/url_launcher.dart';

class PatientInfoScreen extends StatelessWidget {
  final Appointment appointment;

  PatientInfoScreen({super.key, required this.appointment});

  String buildImageUrl(String path) {
    if (path.startsWith('http')) return path;
    return "${ApiConstants.imageBaseUrl}$path";
  }

  bool _isImage(String path) {
    final p = path.toLowerCase();
    return p.endsWith('.jpg') ||
        p.endsWith('.jpeg') ||
        p.endsWith('.png') ||
        p.endsWith('.webp');
  }

  bool _isPdf(String path) {
    return path.toLowerCase().endsWith('.pdf');
  }

  void _openImage(BuildContext context, String url) {
    showDialog(
      context: context,
      barrierColor: Colors.black,
      builder: (_) => GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: InteractiveViewer(
            child: Image.network(url, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }

  Future<void> _openPdf(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final patient = appointment.patient;

    String? profileImage =
        (patient?.photo != null && patient!.photo!.isNotEmpty)
            ? buildImageUrl(patient.photo!)
            : null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Patient Information",
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Patient Info",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),

            // ---------------- PATIENT CARD ----------------
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundImage:
                        profileImage != null ? NetworkImage(profileImage) : null,
                    child: profileImage == null
                        ? const Icon(Icons.person, size: 30)
                        : null,
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        patient?.name ?? "Unknown",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${patient?.gender ?? ''} • ${appointment.age ?? ''} Years • ${appointment.weight ?? ''} KG",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // ---------------- PATIENT RECORDS ----------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Patient Records",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _recordBox(
                          title: "Previous\nPrescriptions",
                          onTap: () {
                            Get.to(() => PrescriptionListScreen(
                                  patientId: patient?.id ?? "",
                                ));
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _recordBox(
                          title: "Test\nResults",
                          onTap: () {
                            Get.to(() => TestResultScreen(
                                  appointmentId: appointment.id ?? "",
                                  appointment: appointment,
                                ));
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // ---------------- EYE TEST ----------------
            const Text(
              "Eye Test",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),

            Builder(
              builder: (_) {
                final eyeTests = appointment.eyePhotos;

                if (eyeTests == null || eyeTests.isEmpty) {
                  return _emptyBox("No eye test image");
                }

                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: eyeTests.map((path) {
                    return _imageBox(buildImageUrl(path));
                  }).toList(),
                );
              },
            ),

            const SizedBox(height: 22),

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
                  const Text(
                    "Appointment Reason",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    appointment.reason ?? "No reason provided",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    appointment.description ?? "No description provided",
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            // ---------------- ADDITIONAL ATTACHMENTS ----------------
            const Text(
              "Additional Attachments",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),

            appointment.additionalFiles != null &&
                    appointment.additionalFiles!.isNotEmpty
                ? Wrap(
                    spacing: 14,
                    runSpacing: 14,
                    children: appointment.additionalFiles!.map((filePath) {
                      final fullUrl = buildImageUrl(filePath);

                      return GestureDetector(
                        onTap: () {
                          if (_isImage(filePath)) {
                            _openImage(context, fullUrl);
                          } else if (_isPdf(filePath)) {
                            _openPdf(fullUrl);
                          }
                        },
                        child: Container(
                          width: 105,
                          height: 105,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.grey.shade200,
                            image: _isImage(filePath)
                                ? DecorationImage(
                                    image: NetworkImage(fullUrl),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: !_isImage(filePath)
                              ? const Icon(
                                  Icons.picture_as_pdf,
                                  color: Colors.red,
                                  size: 40,
                                )
                              : null,
                        ),
                      );
                    }).toList(),
                  )
                : Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: const Center(
                      child: Text(
                        "No attachments found",
                        style: TextStyle(color: Colors.black45),
                      ),
                    ),
                  ),

            const SizedBox(height: 30),

            // ---------------- CALL NOW BUTTON ----------------
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () async {
                  final controller = Get.put(AgoraCallController());
                  await SharedPrefs.saveAgoraChannelId(appointment.id ?? "");
                  await SharedPrefs.saveDoctorAgoraToken(
                      appointment.doctorAgoraToken ?? "");
                  controller.setAppointment(appointment);
                  await controller.callNow();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.color008541,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.videocam, size: 20),
                    SizedBox(width: 8),
                    Text(
                      "Call Now",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // ---------------- RECORD BOX ----------------
  Widget _recordBox({required String title, required VoidCallback onTap}) {
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
                style:
                    const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.green,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageBox(String imageUrl) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: Get.context!,
          barrierColor: Colors.black,
          builder: (_) => GestureDetector(
            onTap: () => Navigator.pop(Get.context!),
            child: Center(
              child: Image.network(imageUrl, fit: BoxFit.contain),
            ),
          ),
        );
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Colors.grey.shade200,
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _emptyBox(String text) {
    return Container(
      height: 110,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 13, color: Colors.black45),
      ),
    );
  }
}
