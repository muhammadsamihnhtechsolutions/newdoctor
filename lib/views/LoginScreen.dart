

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:beh_doctor/modules/auth/controller/LoginController.dart';
// import 'package:beh_doctor/views/LanguageChipgetx.dart' as shared_chip;

// // ---------------- LOGIN SCREEN ----------------
// class LoginScreen extends StatelessWidget {
//   final LoginController controller = Get.put(LoginController());

//   LoginScreen({super.key});

//   static const Color appGreen = Color(0xFF008541);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,

//       // ----------- APPBAR WITH LANGUAGE TOGGLE -----------
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//         title: const Text("", style: TextStyle(color: Colors.black)),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 12),
//             child: shared_chip.LanguageChipGetX(),
//           ),
//         ],
//       ),

//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),

//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 20),

//               // --------- TITLE ---------
//               Text(
//                 "welcome".tr,
//                 style: TextStyle(
//                   color: appGreen,
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),

//               const SizedBox(height: 40),

//               // -------- PHONE FIELD ----------
//               IntlPhoneField(
//                 decoration: InputDecoration(
//                   labelText: 'enter_phone_number'.tr,
//                   labelStyle: TextStyle(color: Colors.grey.shade600),
//                   filled: true,
//                   fillColor: Colors.grey.shade100,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(14),
//                     borderSide: BorderSide(color: appGreen),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(14),
//                     borderSide: const BorderSide(color: appGreen, width: 2),
//                   ),
//                 ),
//                 initialCountryCode: 'BD',
//                 showDropdownIcon: false,
//                 cursorColor: appGreen,
//                 onChanged: (phone) {
//                   controller.phone.value = phone.number;
//                   controller.dialCode.value = phone.countryCode;
//                 },
//               ),

//               const SizedBox(height: 50),

//               // -------- CONTINUE BUTTON --------
//               Obx(
//                 () => SizedBox(
//                   width: double.infinity,
//                   height: 55,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: appGreen,
//                       elevation: 0,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(14),
//                       ),
//                     ),
//                     onPressed: controller.isLoading.value
//                         ? null
//                         : () => controller.sendOtp(),
//                     child: controller.isLoading.value
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : Text(
//                             "continue".tr,
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 25),

//               // -------- TERMS & CONDITIONS --------
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "by_continuing".tr,
//                     style: const TextStyle(fontSize: 12, color: Colors.black54),
//                   ),
//                   Text(
//                     "terms_conditions".tr,
//                     style: const TextStyle(
//                       fontSize: 12,
//                       color: appGreen,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 5),

//               Text(
//                 "privacy_policy_applies".tr,
//                 style: const TextStyle(
//                   fontSize: 12,
//                   color: appGreen,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:beh_doctor/views/PrivacyPolichyPage.dart';
import 'package:beh_doctor/views/TermsAndConditionsPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:beh_doctor/modules/auth/controller/LoginController.dart';
import 'package:beh_doctor/views/LanguageChipgetx.dart' as shared_chip;

// ---------------- LOGIN SCREEN ----------------
class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  LoginScreen({super.key});

  static const Color appGreen = Color(0xFF008541);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ----------- APPBAR WITH LANGUAGE TOGGLE -----------
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text("", style: TextStyle(color: Colors.black)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: shared_chip.LanguageChipGetX(),
          ),
        ],
      ),

      // ✅ FOCUS / CURSOR FIX ADDED (ONLY CHANGE)
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).unfocus(); // 👈 cursor remove
        },
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                // --------- TITLE ---------
                Text(
                  "welcome".tr,
                  style: TextStyle(
                    color: appGreen,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 40),

                // -------- PHONE FIELD ----------
                Obx(
                  () => IntlPhoneField(
                    decoration: InputDecoration(
                      labelText: 'enter_phone_number'.tr,
                      labelStyle: TextStyle(color: Colors.grey.shade600),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      errorText: controller.phone.value.isNotEmpty &&
                              controller.phone.value.length < 10
                          ? 'enter_phone_number'.tr
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: appGreen),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide:
                            const BorderSide(color: appGreen, width: 2),
                      ),
                    ),

                    /// 🇧🇩 Bangladesh fixed
                    initialCountryCode: 'BD',
                    showDropdownIcon: false,
                    disableLengthCheck: true,
                    cursorColor: appGreen,

                    onChanged: (phone) {
                      controller.phone.value = phone.number;
                      controller.dialCode.value = '+880';
                    },
                  ),
                ),

                const SizedBox(height: 50),

                // -------- CONTINUE BUTTON --------
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appGreen,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),

                      onPressed: controller.isLoading.value ||
                              !controller.isPhoneValid
                          ? null
                          : () => controller.sendOtp(),

                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "continue".tr,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // -------- TERMS & CONDITIONS --------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "by_continuing".tr,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const TermsAndConditionsPage());
                      },
                      child: const Text(
                        "terms_conditions",
                        style: TextStyle(
                          fontSize: 12,
                          color: appGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                GestureDetector(
                  onTap: () {
                    Get.to(() => const PrivacyPolicyPage());
                  },
                  child: Text(
                    "privacy_policy_applies".tr,
                    style: const TextStyle(
                      fontSize: 12,
                      color: appGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
