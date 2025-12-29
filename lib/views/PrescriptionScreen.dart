

import 'package:beh_doctor/modules/auth/controller/PrescriptionListController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beh_doctor/widgets/PrescriptionButtonWidget.dart';

class PrescriptionListScreen extends StatefulWidget {
  final String patientId;

  const PrescriptionListScreen({
    required this.patientId,
    super.key,
  });

  @override
  State<PrescriptionListScreen> createState() =>
      _PrescriptionListScreenState();
}

class _PrescriptionListScreenState extends State<PrescriptionListScreen> {
  final PrescriptionController _controller =
      Get.put(PrescriptionController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.fetchPrescriptions(widget.patientId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // ✅ WHITE BACKGROUND
      appBar: AppBar(
        title: Text("prescriptions".tr),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Obx(() {
          /// 🔹 LOADING
          if (_controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          /// 🔹 ERROR
          if (_controller.errorMessage.value.isNotEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  _controller.errorMessage.value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          }

          /// 🔹 EMPTY
          if (_controller.prescriptions.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.description_outlined,
                    size: 48,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "no_prescriptions_found".tr,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          /// 🔹 LIST
          return ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            itemCount: _controller.prescriptions.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return PrescriptionTileWidget(
                prescription: _controller.prescriptions[index],
              );
            },
          );
        }),
      ),
    );
  }
}
