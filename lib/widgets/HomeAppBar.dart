// import 'package:beh_doctor/apiconstant/apiconstant.dart';
// import 'package:beh_doctor/modules/auth/controller/DoctorProfileController.dart';
// import 'package:beh_doctor/views/LanguageChipgetx.dart';
//  // <--- ADD THIS
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';

// class HomeAppBarGetX extends StatelessWidget implements PreferredSizeWidget {
//   final String bellIcon;
//   final RxString language = 'en'.obs;

//   HomeAppBarGetX({super.key, required this.bellIcon});

//   @override
//   Size get preferredSize => const Size.fromHeight(70);

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.find<DoctorProfileController>();

//     final String finalBellIcon =
//         bellIcon.isEmpty ? 'assets/icons/bell.svg' : bellIcon;

//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//       child: Row(
//         children: [
//           // ---------------- PROFILE IMAGE ----------------
//           Obx(() {
//             if (controller.isLoading.value) {
//               return const CircleAvatar(
//                 radius: 24,
//                 backgroundColor: Colors.grey,
//               );
//             }

//             final image = controller.doctor.value?.photo;

//             return GestureDetector(
//               onTap: () => Get.toNamed('/profile'),
//               child: SizedBox(
//                 height: 48,
//                 width: 48,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(48),
//                   child: (image == null || image.isEmpty)
//                       ? Image.asset(
//                           'assets/images/placeholder.png',
//                           fit: BoxFit.cover,
//                         )
//                       : Image.network(
//                           image.startsWith("http")
//                               ? image
//                               : ApiConstants.imageBaseUrl + image,
//                           fit: BoxFit.cover,
//                         ),
//                 ),
//               ),
//             );
//           }),

//           const Spacer(),

//           // ---------------- LANGUAGE CHIP ----------------
//           LanguageChipGetX(),

//           const SizedBox(width: 20),

//           // ---------------- NOTIFICATION ICON ----------------
//           GestureDetector(
//             onTap: () => Get.toNamed('/notifications'),
//             child: SvgPicture.asset(
//               finalBellIcon,
//               height: 20,
//               width: 20,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:beh_doctor/apiconstant/apiconstant.dart';
import 'package:beh_doctor/modules/auth/controller/DoctorProfileController.dart';
import 'package:beh_doctor/views/LanguageChipgetx.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeAppBarGetX extends StatelessWidget implements PreferredSizeWidget {
  final String bellIcon;
  final RxString language = 'en'.obs;

  HomeAppBarGetX({super.key, required this.bellIcon});

  @override
  Size get preferredSize => const Size.fromHeight(85); // <<--- HEIGHT IMPROVED

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DoctorProfileController>();

    final String finalBellIcon = bellIcon.isEmpty
        ? 'assets/icons/bell.svg'
        : bellIcon;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ---------------- PROFILE IMAGE ----------------
          Obx(() {
            if (controller.isLoading.value) {
              return const CircleAvatar(
                radius: 26,
                backgroundColor: Colors.grey,
              );
            }

            final image = controller.doctor.value?.photo;

            return GestureDetector(
              onTap: () => Get.toNamed('/DoctorProfileScreen'),
              child: SizedBox(
                height: 52,
                width: 52,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(52),
                  child: (image == null || image.isEmpty)
                      ? Container(
                          color: Colors.grey.shade300,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 28,
                          ),
                        )
                      : Image.network(
                          image.startsWith("http")
                              ? image
                              : ApiConstants.imageBaseUrl + image,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            );
          }),

          const Spacer(),

          // ---------------- LANGUAGE CHIP ----------------
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: LanguageChipGetX(),
          ),

          // ---------------- NOTIFICATION ICON ----------------
          GestureDetector(
            onTap: () => Get.toNamed('/notifications'),
            child: const Icon(
              Icons.notifications_none,
              size: 26,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
