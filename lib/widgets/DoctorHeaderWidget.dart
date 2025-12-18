// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:beh_doctor/modules/auth/controller/DoctorProfileController.dart';
// import 'package:beh_doctor/apiconstant/apiconstant.dart';
// import 'package:beh_doctor/views/DoctorProfileScreen.dart';

// class DoctorHeaderWidget extends StatelessWidget {
//   DoctorHeaderWidget({super.key});

//   final controller = Get.find<DoctorProfileController>();

//   @override
//   Widget build(BuildContext context) {

//     return Obx(() {
//       final d = controller.doctor.value;

//       if (d == null) {
//         return const SizedBox();
//       }

//       /// IMAGE URL BUILD
//       String? photoUrl;
//       if (d.photo != null && d.photo!.isNotEmpty) {
//         photoUrl = d.photo!.startsWith("http")
//             ? d.photo!
//             : ApiConstants.imageBaseUrl + d.photo!;
//       }

//       return GestureDetector(
//         onTap: () {
//           Get.to(() => const DoctorProfileScreen());
//         },

//         child: Container(
//           margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
//           padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),

//           decoration: BoxDecoration(
//            color: const Color.fromARGB(255, 182, 228, 203),
//             borderRadius: BorderRadius.circular(12),          // Rounded card
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black12,
//                 blurRadius: 4,
//                 offset: const Offset(0, 2),
//               ),
//             ],
//           ),

//           child: Row(
//             children: [
//               /// PROFILE IMAGE
//               CircleAvatar(
//                 radius: 32,
//                 backgroundColor: const Color.fromARGB(255, 182, 228, 203),       // NO GREEN 🔥
//                 backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
//                 child: photoUrl == null
//                     ? Icon(Icons.person, size: 40, color: Colors.grey.shade600)
//                     : null,
//               ),

//               const SizedBox(width: 15),

//               /// NAME + PHONE
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     d.name ?? "Unknown",
//                     style: const TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     "${d.dialCode ?? ''}${d.phone ?? ''}",
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beh_doctor/modules/auth/controller/DoctorProfileController.dart';
import 'package:beh_doctor/apiconstant/apiconstant.dart';
import 'package:beh_doctor/views/DoctorProfileScreen.dart';

class DoctorHeaderWidget extends StatelessWidget {
  DoctorHeaderWidget({super.key});

  final controller = Get.find<DoctorProfileController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final d = controller.doctor.value;

      if (d == null) return const SizedBox();

      /// IMAGE URL BUILD
      String? photoUrl;
      if (d.photo != null && d.photo!.isNotEmpty) {
        photoUrl = d.photo!.startsWith("http")
            ? d.photo!
            : ApiConstants.imageBaseUrl + d.photo!;
      }

      return GestureDetector(
        onTap: () => Get.to(() => const DoctorProfileScreen()),

        child: Container(
          width: double.infinity,
          height: 160, // AppBar height style
          padding: const EdgeInsets.symmetric(horizontal: 20),

          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 182, 228, 203), // ✔️ your color
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// PROFILE IMAGE
              CircleAvatar(
                radius: 34,
                backgroundColor: const Color.fromARGB(255, 182, 228, 203),
                backgroundImage: photoUrl != null
                    ? NetworkImage(photoUrl)
                    : null,
                child: photoUrl == null
                    ? Icon(Icons.person, size: 40, color: Colors.grey.shade700)
                    : null,
              ),

              const SizedBox(width: 18),

              /// NAME + PHONE
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    d.name ?? "unknown".tr,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${d.dialCode ?? ''}${d.phone ?? ''}",
                    style: const TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
