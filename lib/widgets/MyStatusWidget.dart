// import 'package:beh_doctor/modules/auth/controller/DoctorProfileController.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class MyStatusWidget extends StatelessWidget {
//   MyStatusWidget({super.key});

//   final controller = Get.put(DoctorProfileController());

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       bool isOnline = controller.doctor.value?.availabilityStatus == "online";

//       return Container(
//         padding: const EdgeInsets.all(15),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "My status",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 Text(
//                   "Offline",
//                   style: TextStyle(
//                     color: !isOnline ? Colors.green : Colors.grey,
//                     fontSize: 16,
//                   ),
//                 ),
//                 Switch(
//                   value: isOnline,
//                   onChanged: (v) {
//                     String newStatus = v ? "online" : "offline";
//                     controller.updateAvailabilityStatus(newStatus);
//                   },
//                   activeColor: Colors.green,
//                 ),
//                 Text(
//                   "Online",
//                   style: TextStyle(
//                     color: isOnline ? Colors.green : Colors.grey,
//                     fontSize: 16,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }

// import 'package:beh_doctor/modules/auth/controller/DoctorProfileController.dart';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class MyStatusWidget extends StatelessWidget {
//   MyStatusWidget({super.key});

//   final controller = Get.put(DoctorProfileController());

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       bool isOnline = controller.doctor.value?.availabilityStatus == "online";

//       return Container(
//         padding: const EdgeInsets.all(15),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "My status",
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.grey,
//               ),
//             ),

//             const SizedBox(height: 10),

//             Center(
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                 Text(
//   "offline",
//   style: TextStyle(
//     color: !isOnline ? Colors.AppColors.color008541 : Colors.grey,
//     fontSize: 16,
//   ),
// ),

//                   const SizedBox(width: 10),

//                   /// ✔ Custom Toggle (No errors, No packages)
//                   _CustomToggle(
//                     value: isOnline,
//                     onChanged: (v) {
//                       String newStatus = v ? "online" : "offline";
//                       controller.updateAvailabilityStatus(newStatus);
//                     },
//                   ),

//                   const SizedBox(width: 10),
//                   Text(
//                     "Online",
//                     style: TextStyle(
//                       color: isOnline ? Colors.green : Colors.grey,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }

// /// ---------------------------------------------------------------------------
// ///   CUSTOM RECTANGULAR-ROUNDED TOGGLE  (No Packages, No Errors)
// /// ---------------------------------------------------------------------------

// class _CustomToggle extends StatelessWidget {
//   final bool value;
//   final ValueChanged<bool> onChanged;

//   const _CustomToggle({
//     required this.value,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => onChanged(!value),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         width: 65,
//         height: 32,
//         padding: const EdgeInsets.symmetric(horizontal: 4),
//         decoration: BoxDecoration(
//           color: value ? Colors.green : Colors.grey.shade400,
//           borderRadius: BorderRadius.circular(18), // 👈 not full round
//         ),
//         child: AnimatedAlign(
//           duration: const Duration(milliseconds: 200),
//           alignment: value ? Alignment.centerRight : Alignment.centerLeft,
//           child: Container(
//             width: 24,
//             height: 24,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(12), // thumb
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

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
      bool isOnline = controller.doctor.value?.availabilityStatus == "online";

      return Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "my_status".tr,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 10),

            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "offline".tr,
                    style: TextStyle(
                      color: !isOnline ? AppColors.color008541 : Colors.grey,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(width: 10),

                  _CustomToggle(
                    value: isOnline,
                    onChanged: (v) async {
                      EasyLoading.show(status: "Please wait..");
                      String newStatus = v ? "online" : "offline";
                      await controller.updateAvailabilityStatus(newStatus);
                      EasyLoading.dismiss();
                    },
                  ),

                  const SizedBox(width: 10),
                  Text(
                    "online".tr,
                    style: TextStyle(
                      color: isOnline ? AppColors.color008541 : Colors.grey,
                      fontSize: 16,
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

  const _CustomToggle({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 65,
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: value ? AppColors.color008541 : Colors.grey.shade400,
          borderRadius: BorderRadius.circular(18),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 50),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
