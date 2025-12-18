import 'package:beh_doctor/modules/auth/controller/LanguageController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// -------------------------- LANGUAGE CHIP --------------------------
class LanguageChipGetX extends StatelessWidget {
  final LanguageController controller = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: 70,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(63),
          border: Border.all(color: const Color(0xFF008541)),
        ),
        child: Row(
          children: [
            // BANGLA
            Expanded(
              child: GestureDetector(
                onTap: () => controller.changeLanguage('bn'),
                child: Container(
                  decoration: BoxDecoration(
                    color: controller.selectedLang.value == 'bn'
                        ? const Color(0xFF008541)
                        : Colors.transparent,
                    borderRadius: BorderRadius.horizontal(
                      left: const Radius.circular(63),
                      right: controller.selectedLang.value == 'bn'
                          ? const Radius.circular(63)
                          : Radius.zero,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'বাং',
                    style: TextStyle(
                      fontSize: 9,
                      color: controller.selectedLang.value == 'bn'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            ),

            // ENGLISH
            Expanded(
              child: GestureDetector(
                onTap: () => controller.changeLanguage('en'),
                child: Container(
                  decoration: BoxDecoration(
                    color: controller.selectedLang.value == 'en'
                        ? const Color(0xFF008541)
                        : Colors.transparent,
                    borderRadius: BorderRadius.horizontal(
                      right: const Radius.circular(63),
                      left: controller.selectedLang.value == 'en'
                          ? const Radius.circular(63)
                          : Radius.zero,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'ENG',
                    style: TextStyle(
                      fontSize: 9,
                      color: controller.selectedLang.value == 'en'
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class LanguageChipGetX extends StatelessWidget {
//   final LanguageController controller = Get.put(LanguageController());

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Container(
//         width: 70,
//         height: 30,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(63),
//           border: Border.all(color: const Color(0xFF008541)),
//         ),
//         child: Row(
//           children: [
//             // BANGLA
//             Expanded(
//               child: GestureDetector(
//                 onTap: () => controller.changeLanguage('bn'),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: controller.selectedLang.value == 'bn'
//                         ? const Color(0xFF008541)
//                         : Colors.transparent,
//                   ),
//                   alignment: Alignment.center,
//                   child: Text(
//                     'বাং',
//                     style: TextStyle(
//                       fontSize: 9,
//                       color: controller.selectedLang.value == 'bn'
//                           ? Colors.white
//                           : Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             // ENGLISH
//             Expanded(
//               child: GestureDetector(
//                 onTap: () => controller.changeLanguage('en'),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: controller.selectedLang.value == 'en'
//                         ? const Color(0xFF008541)
//                         : Colors.transparent,
//                   ),
//                   alignment: Alignment.center,
//                   child: Text(
//                     'ENG',
//                     style: TextStyle(
//                       fontSize: 9,
//                       color: controller.selectedLang.value == 'en'
//                           ? Colors.white
//                           : Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
