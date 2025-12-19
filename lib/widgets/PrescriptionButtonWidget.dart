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

// class PrescriptionTileWidget extends StatefulWidget {
//   final Prescription prescription;

//   const PrescriptionTileWidget({required this.prescription, super.key});

//   @override
//   State<PrescriptionTileWidget> createState() => _PrescriptionTileWidgetState();
// }

// class _PrescriptionTileWidgetState extends State<PrescriptionTileWidget> {
//   String? buildSafeImageUrl(String baseUrl, String? path) {
//     if (path == null || path.trim().isEmpty) return null;

//     // Case 1: backend already returned full URL
//     if (path.startsWith('http://') || path.startsWith('https://')) {
//       final uri = Uri.tryParse(path);
//       return (uri != null && uri.hasScheme && uri.hasAuthority) ? path : null;
//     }

//     // Case 2: relative path
//     var cleanPath = path.replaceAll('..', '');
//     cleanPath = cleanPath.replaceAll(RegExp(r'/{2,}'), '/');

//     if (cleanPath.startsWith('/')) {
//       cleanPath = cleanPath.substring(1);
//     }

//     final fullUrl = '$baseUrl$cleanPath';

//     final uri = Uri.tryParse(fullUrl);
//     return (uri != null && uri.hasScheme && uri.hasAuthority) ? fullUrl : null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Base URL

//     // Fix file path: replace ".." with "."

//     // final rawPath = widget.prescription.file ?? "";

//     // // Just remove double slashes, NOT dots
//     // final filePath = rawPath.replaceAll('//', '/').trim();

//     // // Final URL
//     // final fullUrl = "${ApiConstants.imageBaseUrl}$filePath";

//     // print("📸 FINAL URL = $fullUrl");

//     final String? imageUrl = buildSafeImageUrl(
//       ApiConstants.imageBaseUrl,
//       widget.prescription.file,
//     );

//     print("image => $imageUrl");

//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 5),
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Row(
//           children: [
//             // ==== IMAGE ====
//             Container(
//               width: 80,
//               height: 80,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade300),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               // child: (filePath.isNotEmpty)
//               //     ? Image.network(
//               //         fullUrl,
//               //         fit: BoxFit.cover,
//               //         errorBuilder: (_, __, ___) =>
//               //             const Icon(Icons.broken_image, size: 40),
//               //         loadingBuilder: (_, child, loadingProgress) {
//               //           if (loadingProgress == null) return child;
//               //           return const Center(
//               //             child: CircularProgressIndicator(strokeWidth: 2),
//               //           );
//               //         },
//               //       )
//               //     : const Icon(Icons.image_not_supported, size: 40),
//               child: imageUrl != null
//                   ? Image.network(
//                       imageUrl,
//                       fit: BoxFit.cover,
//                       errorBuilder: (_, __, ___) =>
//                           const Icon(Icons.broken_image, size: 40),
//                       loadingBuilder: (_, child, loadingProgress) {
//                         if (loadingProgress == null) return child;
//                         return const Center(
//                           child: CircularProgressIndicator(strokeWidth: 2),
//                         );
//                       },
//                     )
//                   : const Icon(Icons.image_not_supported, size: 40),
//             ),

//             const SizedBox(width: 10),

//             // ==== TITLE & DATE ====
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.prescription.title ?? "no_title".tr,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     widget.prescription.createdAt ?? "",
//                     style: const TextStyle(color: Colors.grey, fontSize: 12),
//                   ),
//                 ],
//               ),
//             ),

//             IconButton(
//               icon: const Icon(Icons.download, color: Colors.blue),
//               onPressed: () {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text(
//                       "${"open_download".tr}: ${widget.prescription.title ?? ""}",
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PrescriptionTileWidget extends StatelessWidget {
  final Prescription prescription;

  const PrescriptionTileWidget({required this.prescription, super.key});

  // ---------------- FILE HELPERS ----------------

  String? buildSafeFileUrl(String baseUrl, String? path) {
    if (path == null || path.trim().isEmpty) return null;

    // Already full URL (S3 / CDN / API)
    if (path.startsWith('http://') || path.startsWith('https://')) {
      final uri = Uri.tryParse(path);
      return (uri != null && uri.hasScheme && uri.hasAuthority) ? path : null;
    }

    // Relative path
    var cleanPath = path.replaceAll('..', '');
    cleanPath = cleanPath.replaceAll(RegExp(r'/{2,}'), '/');

    if (cleanPath.startsWith('/')) {
      cleanPath = cleanPath.substring(1);
    }

    final full = '$baseUrl$cleanPath';
    final uri = Uri.tryParse(full);

    return (uri != null && uri.hasScheme && uri.hasAuthority) ? full : null;
  }

  bool isPdf(String url) => url.toLowerCase().endsWith('.pdf');

  bool isImage(String url) =>
      url.toLowerCase().endsWith('.png') ||
      url.toLowerCase().endsWith('.jpg') ||
      url.toLowerCase().endsWith('.jpeg') ||
      url.toLowerCase().endsWith('.webp');

  // ------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final String? fileUrl = buildSafeFileUrl(
      ApiConstants.imageBaseUrl,
      prescription.file,
    );

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            // ---------- PREVIEW ----------
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: fileUrl == null
                  ? const Icon(Icons.image_not_supported, size: 40)
                  : isPdf(fileUrl)
                  ? const Icon(
                      Icons.picture_as_pdf,
                      size: 42,
                      color: Colors.red,
                    )
                  : isImage(fileUrl)
                  ? Image.network(
                      fileUrl,
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
                  : const Icon(Icons.insert_drive_file, size: 40),
            ),

            const SizedBox(width: 12),

            // ---------- INFO ----------
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    prescription.title ?? "no_title".tr,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    prescription.createdAt ?? "",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),

            // ---------- OPEN ----------
            IconButton(
              icon: const Icon(Icons.open_in_new, color: Colors.blue),
              onPressed: fileUrl == null
                  ? null
                  : () {
                      if (isPdf(fileUrl)) {
                        Get.to(() => PdfViewerScreen(url: fileUrl));
                      } else {
                        print("image url => $fileUrl");
                        Get.to(() => FullscreenImageViewer(imageUrl: fileUrl));
                      }
                      // } else if (isImage(fileUrl)) {
                      //   print("image url => $fileUrl");
                      //   Get.to(() => FullscreenImageViewer(imageUrl: fileUrl));
                      // }
                    },
            ),
          ],
        ),
      ),
    );
  }
}

class PdfViewerScreen extends StatelessWidget {
  final String url;
  const PdfViewerScreen({required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Prescription PDF")),
      body: SfPdfViewer.network(url),
    );
  }
}

class FullscreenImageViewer extends StatelessWidget {
  final String imageUrl;
  const FullscreenImageViewer({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Center(child: InteractiveViewer(child: Image.network(imageUrl))),
    );
  }
}
