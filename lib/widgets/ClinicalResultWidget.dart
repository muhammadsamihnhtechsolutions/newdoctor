
// import 'package:beh_doctor/modules/auth/controller/AppoinmentDetailController.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ClinicalResultWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<AppointmentDetailsController>();

//     return Obx(() {
//       if (controller.clinicalTests.isEmpty) {
//         return Center(child: Text("no_clinical_tests_found".tr));
//       }

//       return ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: controller.clinicalTests.length,
//         itemBuilder: (_, index) {
//           final test = controller.clinicalTests[index];

//           return Card(
//             elevation: 1,
//             margin: const EdgeInsets.only(bottom: 12),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(14),
//             ),
//             child: ListTile(
//               title: Text(test.title ?? "untitled".tr),
//               subtitle: Text(test.createdAt ?? ""),
//               trailing: const Icon(Icons.chevron_right),
//             ),
//           );
//         },
//       );
//     });
//   }
// }





import 'package:beh_doctor/apiconstant/apiconstant.dart';
import 'package:beh_doctor/modules/auth/controller/AppoinmentDetailController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';

class ClinicalResultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppointmentDetailsController>();

    return Obx(() {
      if (controller.clinicalTests.isEmpty) {
        return Center(child: Text("no_clinical_tests_found".tr));
      }

      return GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.clinicalTests.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,              // 🔹 2 per row
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.78,         // card height control
        ),
        itemBuilder: (_, index) {
          final test = controller.clinicalTests[index];

          final attachment = test.attachment;
          final fullUrl = attachment == null || attachment.isEmpty
              ? null
              : ApiConstants.imageBaseUrl + attachment;

          final isPdf = attachment != null &&
              attachment.toLowerCase().endsWith('.pdf');

          return GestureDetector(
            onTap: () {
              if (fullUrl == null) return;

              if (isPdf) {
                OpenFile.open(fullUrl);
              } else {
                Get.to(() => FullScreenImageView(imageUrl: fullUrl));
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // 🔹 white theme
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔹 PREVIEW
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: isPdf
                        ? Container(
                            height: 130,
                            width: double.infinity,
                            color: Colors.grey.shade100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.picture_as_pdf,
                                    size: 40, color: Colors.red),
                                SizedBox(height: 6),
                                Text(
                                  "PDF",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          )
                        : Image.network(
                            fullUrl ?? "",
                            height: 130,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const SizedBox.shrink(),
                          ),
                  ),

                  /// 🔹 TITLE
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      test.title ?? "untitled".tr,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
class FullScreenImageView extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageView({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context), // tap to close (optional)
        child: Center(
          child: InteractiveViewer(
            panEnabled: true,
            minScale: 1.0,
            maxScale: 5.0,
            child: Image.network(
              imageUrl,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.contain, // image proportion safe
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const CircularProgressIndicator(color: Colors.white);
              },
              errorBuilder: (_, __, ___) => const Icon(
                Icons.broken_image,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

