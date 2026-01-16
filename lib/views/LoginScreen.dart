


// import 'package:beh_doctor/views/PrivacyPolichyPage.dart';
// import 'package:beh_doctor/views/TermsAndConditionsPage.dart';
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

//       body: GestureDetector(
//         behavior: HitTestBehavior.translucent,
//         onTap: () {
//           FocusScope.of(context).unfocus();
//         },
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 20),

//                 // --------- TITLE ---------
//                 Text(
//                   "welcome".tr,
//                   style: TextStyle(
//                     color: appGreen,
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),

//                 const SizedBox(height: 40),

//                 // -------- PHONE FIELD ----------
//                 Obx(
//                   () => IntlPhoneField(
//                     decoration: InputDecoration(
//                       labelText: 'enter_phone_number'.tr,
//                       labelStyle: TextStyle(color: Colors.grey.shade600),
//                       filled: true,
//                       fillColor: Colors.grey.shade100,
//                       errorText:
//                           controller.loginInputPhone.value.isNotEmpty &&
//                                   controller.loginInputPhone.value.length < 10
//                               ? 'enter_phone_number'.tr
//                               : null,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(14),
//                         borderSide: BorderSide(color: appGreen),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(14),
//                         borderSide:
//                             const BorderSide(color: appGreen, width: 2),
//                       ),
//                     ),

//                     /// 🇧🇩 Bangladesh fixed
//                     initialCountryCode: 'BD',
//                     showDropdownIcon: false,
//                     disableLengthCheck: true,
//                     cursorColor: appGreen,

//                     onChanged: (phone) {
//                       controller.loginInputPhone.value = phone.number;
//                       controller.loginInputDialCode.value = '+880';
//                     },
//                   ),
//                 ),

//                 const SizedBox(height: 50),

//                 // -------- CONTINUE BUTTON --------
//                 Obx(
//                   () => SizedBox(
//                     width: double.infinity,
//                     height: 55,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: appGreen,
//                         elevation: 0,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(14),
//                         ),
//                       ),
//                       onPressed: controller.isLoading.value ||
//                               !controller.isPhoneValid
//                           ? null
//                           : () => controller.sendOtp(),
//                       child: controller.isLoading.value
//                           ? const CircularProgressIndicator(
//                               color: Colors.white,
//                             )
//                           : Text(
//                               "continue".tr,
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 25),

//                 // -------- TERMS & CONDITIONS --------
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "by_continuing".tr,
//                       style: const TextStyle(
//                         fontSize: 12,
//                         color: Colors.black54,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Get.to(() => const TermsAndConditionsPage());
//                       },
//                       child: const Text(
//                         "terms_conditions",
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: appGreen,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 5),

//                 GestureDetector(
//                   onTap: () {
//                     Get.to(() => const PrivacyPolicyPage());
//                   },
//                   child: Text(
//                     "privacy_policy_applies".tr,
//                     style: const TextStyle(
//                       fontSize: 12,
//                       color: appGreen,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
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
import 'package:beh_doctor/modules/auth/controller/LoginController.dart';
import 'package:beh_doctor/views/LanguageChipgetx.dart' as shared_chip;
import 'package:flutter/services.dart';

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
        title: const Text(""),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: shared_chip.LanguageChipGetX(),
          ),
        ],
      ),

      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
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

                // -------- PHONE FIELD (MANUAL – SAME LOOK) --------
                Obx(
                  () => TextFormField(
                    keyboardType: TextInputType.phone,
                    cursorColor: appGreen,
                    maxLength: 10,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: InputDecoration(
                      counterText: "",
                      labelText: 'enter_phone_number'.tr,
                      labelStyle:
                          TextStyle(color: Colors.grey.shade600),
                      filled: true,
                      fillColor: Colors.grey.shade100,

                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 14),
                        child: Text(
                          "+880",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      prefixIconConstraints:
                          const BoxConstraints(minWidth: 0, minHeight: 0),

                      errorText:
                          controller.loginInputPhone.value.isNotEmpty &&
                                  !controller.isPhoneValid
                              ? 'enter_phone_number'.tr
                              : null,

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide:
                            const BorderSide(color: appGreen),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                            color: appGreen, width: 2),
                      ),
                    ),
                    onChanged: (value) {
                      controller.loginInputPhone.value =
                          value.trim();
                      controller.loginInputDialCode.value =
                          "+880";
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
          : () async {
              debugPrint("🟢 CONTINUE CLICKED (SEND OTP)");

              try {
                await controller.sendOtp();
              } catch (e, s) {
                debugPrint("❌ CRASH ON SEND OTP: $e");
                debugPrintStack(stackTrace: s);

                Get.snackbar(
                  "error".tr,
                  "Something crashed. Check logs.",
                );
              }
            },

      child: controller.isLoading.value
          ? const SizedBox(
              height: 22,
              width: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
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
)

                // Obx(
                //   () => SizedBox(
                //     width: double.infinity,
                //     height: 55,
                //     child: ElevatedButton(
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: appGreen,
                //         elevation: 0,
                //         shape: RoundedRectangleBorder(
                //           borderRadius:
                //               BorderRadius.circular(14),
                //         ),
                //       ),
                //       onPressed: controller.isLoading.value ||
                //               !controller.isPhoneValid
                //           ? null
                //           : controller.sendOtp,
                //       child: controller.isLoading.value
                //           ? const CircularProgressIndicator(
                //               color: Colors.white,
                //             )
                //           : Text(
                //               "continue".tr,
                //               style: const TextStyle(
                //                 fontSize: 18,
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.white,
                //               ),
                //             ),
                //     ),
                //   ),
                // ),
,
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
                        Get.to(() =>
                            const TermsAndConditionsPage());
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
                    Get.to(() =>
                        const PrivacyPolicyPage());
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
