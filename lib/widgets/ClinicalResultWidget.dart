// import 'package:beh_doctor/modules/auth/controller/AppoinmentDetailController.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ClinicalResultWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<AppointmentDetailsController>();

//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Obx(() {
//         if (controller.clinicalTests.isEmpty) {
//           return const Text("No Clinical Tests Found");
//         }

//         return ListView.builder(
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           itemCount: controller.clinicalTests.length,
//           itemBuilder: (_, index) {
//             final test = controller.clinicalTests[index];

//             return Card(
//               margin: const EdgeInsets.symmetric(vertical: 6),
//               child: ListTile(
//                 title: Text(test.title ?? "Untitled"),
//                 subtitle: Text(test.createdAt ?? ""),
//                 trailing: Icon(Icons.chevron_right),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }

import 'package:beh_doctor/modules/auth/controller/AppoinmentDetailController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClinicalResultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppointmentDetailsController>();

    return Obx(() {
      if (controller.clinicalTests.isEmpty) {
        return Center(child: Text("no_clinical_tests_found".tr));
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.clinicalTests.length,
        itemBuilder: (_, index) {
          final test = controller.clinicalTests[index];

          return Card(
            elevation: 1,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: ListTile(
              title: Text(test.title ?? "untitled".tr),
              subtitle: Text(test.createdAt ?? ""),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        },
      );
    });
  }
}
