// import 'package:flutter/material.dart';
// import 'package:beh_doctor/models/AppoinmentDetailModel.dart';

// class PrescriptionTileWidget extends StatelessWidget {
//   final Prescription prescription;

//   const PrescriptionTileWidget({required this.prescription, super.key});

//   @override
//   Widget build(BuildContext context) {
// const String baseUrl = 'https://behapi.eyebuddy.app/'; // trailing slash
// final filePath = prescription.file?.replaceAll('..', '.') ?? '';
// final imageUrl = "$baseUrl$filePath"; // https://behapi.eyebuddy.app/patient/prescription/...

//     // file path cleanup (.. remove)

//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 5),
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           children: [
//             // Prescription Image
//         Container(
//   width: 80,
//   height: 80,
//   decoration: BoxDecoration(
//     border: Border.all(color: Colors.grey.shade300),
//     borderRadius: BorderRadius.circular(8),
//   ),
//   child: filePath.isNotEmpty
//       ? Image.network(
//           imageUrl,
//           fit: BoxFit.cover,
//           errorBuilder: (context, error, stackTrace) {
//             return const Icon(Icons.broken_image, size: 40);
//           },
//           loadingBuilder: (context, child, loadingProgress) {
//             if (loadingProgress == null) return child;
//             return const Center(child: CircularProgressIndicator());
//           },
//         )
//       : const Icon(Icons.image_not_supported, size: 40),
// ),

//             const SizedBox(width: 10),

//             // Title and date
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     prescription.title ?? "No Title",
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold, fontSize: 16),
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     prescription.createdAt ?? "",
//                     style: const TextStyle(color: Colors.grey, fontSize: 12),
//                   ),
//                 ],
//               ),
//             ),

//             // Download/View Button
//             IconButton(
//               icon: const Icon(Icons.download, color: Colors.blue),
//               onPressed: () {
//                 // TODO: implement file download or open in viewer
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                       content:
//                           Text("Open or download: ${prescription.title ?? ""}")),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:beh_doctor/apiconstant/apiconstant.dart';
import 'package:flutter/material.dart';
import 'package:beh_doctor/models/AppoinmentDetailModel.dart';
import 'package:get/get.dart';

class PrescriptionTileWidget extends StatelessWidget {
  final Prescription prescription;

  const PrescriptionTileWidget({required this.prescription, super.key});

  @override
  Widget build(BuildContext context) {
    // Base URL

    // Fix file path: replace ".." with "."

    final rawPath = prescription.file ?? "";

    // Just remove double slashes, NOT dots
    final filePath = rawPath.replaceAll('//', '/').trim();

    // Final URL
    final fullUrl = "${ApiConstants.imageBaseUrl}$filePath";

    print("📸 FINAL URL = $fullUrl");

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // ==== IMAGE ====
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: (filePath.isNotEmpty)
                  ? Image.network(
                      fullUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.broken_image, size: 40),
                      loadingBuilder: (_, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        );
                      },
                    )
                  : const Icon(Icons.image_not_supported, size: 40),
            ),

            const SizedBox(width: 10),

            // ==== TITLE & DATE ====
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    prescription.title ?? "no_title".tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    prescription.createdAt ?? "",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),

            IconButton(
              icon: const Icon(Icons.download, color: Colors.blue),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "${"open_download".tr}: ${prescription.title ?? ""}",
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
