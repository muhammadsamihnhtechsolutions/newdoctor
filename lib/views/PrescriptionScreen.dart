// import 'package:beh_doctor/modules/auth/controller/PrescriptionListController.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:beh_doctor/widgets/PrescriptionButtonWidget.dart';

// class PrescriptionListScreen extends StatelessWidget {
//   final String patientId;
//   PrescriptionListScreen({required this.patientId, super.key});

//   final PrescriptionController _controller = Get.put(PrescriptionController());

//   @override
//   Widget build(BuildContext context) {
//     // Fetch prescriptions when screen opens
//     _controller.fetchPrescriptions(patientId);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Prescriptions"),
//         centerTitle: true,
//       ),
//       body: Obx(() {
//         if (_controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (_controller.errorMessage.value.isNotEmpty) {
//           return Center(child: Text(_controller.errorMessage.value));
//         }

//         if (_controller.prescriptionList.isEmpty) {
//           return const Center(child: Text("No prescriptions found"));
//         }

//         return ListView.separated(
//           padding: const EdgeInsets.all(10),
//           itemCount: _controller.prescriptionList.length,
//           separatorBuilder: (_, __) => const SizedBox(height: 10),
//           itemBuilder: (context, index) {
//             final prescription = _controller.prescriptionList[index];
//             return PrescriptionTileWidget(prescription: prescription);
//           },
//         );
//       }),
//     );
//   }
// }

import 'package:beh_doctor/modules/auth/controller/PrescriptionListController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beh_doctor/widgets/PrescriptionButtonWidget.dart';

class PrescriptionListScreen extends StatefulWidget {
  final String patientId;

  const PrescriptionListScreen({required this.patientId, super.key});

  @override
  State<PrescriptionListScreen> createState() => _PrescriptionListScreenState();
}

class _PrescriptionListScreenState extends State<PrescriptionListScreen> {
  // final PrescriptionController _controller = Get.put(PrescriptionController());
  final PrescriptionController _controller = Get.put(
    PrescriptionController(),
    permanent: false,
  );

  @override
  void initState() {
    super.initState();
    // Fetch only ONCE when screen opens
    _controller.fetchPrescriptions(widget.patientId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("prescriptions".tr), centerTitle: true),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(
              _controller.errorMessage.value,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (_controller.prescriptions.isEmpty) {
          return Center(
            child: Text(
              "no_prescriptions_found".tr,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(10),
          itemCount: _controller.prescriptions.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            return PrescriptionTileWidget(
              prescription: _controller.prescriptions[index],
            );
          },
        );
      }),
    );
  }
}
