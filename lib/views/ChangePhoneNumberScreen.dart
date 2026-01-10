// import 'package:beh_doctor/modules/auth/controller/DoctorProfileController.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:beh_doctor/modules/auth/controller/ChangePhoneNumberController.dart';


// class ChangePhoneNumberScreen extends StatelessWidget {
//   ChangePhoneNumberScreen({super.key});

//   final controller = Get.put(ChangePhoneController());
//   final profile = Get.find<DoctorProfileController>();

//   final newPhoneController = TextEditingController();
//   final dialCode = '+880'.obs;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Change Phone Number')),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("Current Phone"),
//             const SizedBox(height: 8),

//             /// 🔒 CURRENT PHONE (FROM PROFILE)
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 12,
//                 vertical: 16,
//               ),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade400),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Obx(
//                 () => Text(
//                   profile.currentPhone.isEmpty
//                       ? "Loading..."
//                       : "${profile.currentDialCode}${profile.currentPhone}",
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 24),
//             const Text("New Phone"),
//             const SizedBox(height: 8),

//             Row(
//               children: [
//                 Obx(() => Text(dialCode.value)),
//                 const SizedBox(width: 8),
//                 Expanded(
//                   child: TextField(
//                     controller: newPhoneController,
//                     keyboardType: TextInputType.number,
//                     maxLength: 10,
//                     decoration: const InputDecoration(
//                       counterText: '',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 32),

//             /// 🔘 BUTTON
//             Obx(
//               () => SizedBox(
//                 width: double.infinity,
//                 height: 48,
//                 child: ElevatedButton(
//                   onPressed: controller.isLoading.value
//                       ? null
//                       : () => controller.requestOtpForChangePhone(
//                             newDialCode: dialCode.value,
//                             newPhone: newPhoneController.text,
//                           ),
//                   child: controller.isLoading.value
//                       ? const CircularProgressIndicator(
//                           color: Colors.white,
//                         )
//                       : const Text("Send OTP"),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:beh_doctor/modules/auth/controller/DoctorProfileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beh_doctor/modules/auth/controller/ChangePhoneNumberController.dart';

class ChangePhoneNumberScreen extends StatelessWidget {
  ChangePhoneNumberScreen({super.key});

  final controller = Get.put(ChangePhoneController());
  final profile = Get.find<DoctorProfileController>();

  final newPhoneController = TextEditingController();
  final dialCode = '+880'.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // 🔥 keyboard dismiss
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F7F9),

        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Change Phone Number',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// ================= CURRENT PHONE =================
              const Text(
                "Current Phone",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),

              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Obx(
                  () => Text(
                    profile.currentPhone.isEmpty
                        ? "Loading..."
                        : "${profile.currentDialCode}${profile.currentPhone}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              /// ================= NEW PHONE =================
              const Text(
                "New Phone",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),

              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFF008541), width: 1.2),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Obx(
                      () => Text(
                        dialCode.value,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF008541),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: newPhoneController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        cursorColor: const Color(0xFF008541),
                        decoration: const InputDecoration(
                          hintText: "Enter new phone number",
                          counterText: '',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 44),

              /// ================= SEND OTP BUTTON =================
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () => controller.requestOtpForChangePhone(
                              newDialCode: dialCode.value,
                              newPhone: newPhoneController.text,
                            ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF008541),
                      disabledBackgroundColor:
                          const Color(0xFF008541).withOpacity(0.6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 3,
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            "Send OTP",
                            style: TextStyle(
                              color: Colors.white, // ✅ white text
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
