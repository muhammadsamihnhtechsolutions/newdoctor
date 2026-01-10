

import 'package:beh_doctor/modules/auth/controller/DoctorProfileController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AppColors {
  static const Color color008541 = Color(0xFF008541);
}


class MyStatusWidget extends StatelessWidget {
  MyStatusWidget({super.key});

  final DoctorProfileController controller =
      Get.isRegistered<DoctorProfileController>()
          ? Get.find<DoctorProfileController>()
          : Get.put(DoctorProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool isOnline =
          controller.doctor.value?.availabilityStatus == "online";

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey.shade100, // ✅ soft grey (not heavy)
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "my_Status".tr,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 14),

            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "offline".tr,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color:
                          !isOnline ? AppColors.color008541 : Colors.grey,
                    ),
                  ),

                  const SizedBox(width: 12),

                  _CustomToggle(
                    value: isOnline,
                    onChanged: (v) async {
                      EasyLoading.show(status: "Please wait..");
                      String newStatus = v ? "online" : "offline";
                      await controller.updateAvailabilityStatus(newStatus);
                      EasyLoading.dismiss();
                    },
                  ),

                  const SizedBox(width: 12),

                  Text(
                    "online".tr,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color:
                          isOnline ? AppColors.color008541 : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _CustomToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _CustomToggle({
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        width: 62,
        height: 30,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: value
              ? AppColors.color008541
              : Colors.grey.shade400,
          borderRadius: BorderRadius.circular(16),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeInOut,
          alignment:
              value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(11),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 3,
                  offset: Offset(0, 1),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
