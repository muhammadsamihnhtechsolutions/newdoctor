
import 'package:beh_doctor/modules/auth/controller/LogOutController.dart';
import 'package:beh_doctor/theme/Appcolars.dart';
import 'package:beh_doctor/views/ChangePhoneNumberScreen.dart';
import 'package:beh_doctor/views/DoctorProfileScreen.dart';
import 'package:beh_doctor/views/EarningHistoryScreen.dart';
import 'package:beh_doctor/views/LanguageSelecionScreen.dart';
import 'package:beh_doctor/views/WithdrawScreen.dart';
import 'package:beh_doctor/widgets/DoctorHeaderWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  final Color appGreen = const Color(0xFF008541);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Header
              DoctorHeaderWidget(),
              const SizedBox(height: 20),

              // ---------------- PAYMENT ----------------
              sectionTitle("payment".tr),
              menuTile(
                "payout_accounts".tr,
                Icons.account_balance_wallet,
                onTap: () {
                  Get.to(() => WithdrawScreen());
                },
              ),
              menuTile(
                "earning_history".tr,
                Icons.history,
                onTap: () {
                  Get.to(() => EarningHistoryScreen());
                },
              ),

              const SizedBox(height: 20),

              // ---------------- SETTINGS ----------------
              sectionTitle("settings".tr),
              menuTile("change_mobile_number".tr, Icons.phone_android,
              onTap: () {
                  Get.to(() => ChangePhoneNumberScreen());
                },
              ),
              menuTile("language".tr, Icons.language,  onTap: () {
                  Get.to(() => LanguageSelectionScreen());
                },
              ),
              menuTile(
                "profile".tr,
                Icons.person,
                onTap: () {
                  Get.to(() => DoctorProfileScreen());
                },
              ),

              const SizedBox(height: 20),

              // ---------------- LEGAL ----------------
              sectionTitle("legal".tr),
              menuTile(
                "terms_and_conditions".tr,
                Icons.description,
                onTap: () {
                  Get.toNamed('/TermsAndConditionsPage');
                },
              ),
              menuTile(
                "privacy_policy".tr,
                Icons.privacy_tip,
                onTap: () {
                  Get.toNamed('/PrivacyPolicyPage');
                },
              ),

              menuTile(
                "payment_terms".tr,
                Icons.receipt_long,
                onTap: () {
                  Get.toNamed('/paymentterms');
                },
              ),

              const SizedBox(height: 20),

              // ---------------- HELP ----------------
              sectionTitle("help".tr),
              menuTile("emergency_call".tr, Icons.call),
              const SizedBox(height: 50),

Center(
  child: SizedBox(
    width: Get.width * 0.7,
    height: 46,
    child: GetX<LogoutController>(
      init: LogoutController(),
      builder: (controller) {
        return OutlinedButton.icon(
          onPressed: controller.isLoading.value
              ? null
              : () {
                  // controller.logout();
                  controller.showLogoutConfirmation();

                },

          icon: controller.isLoading.value
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.white,
                  ),
                )
              : const Icon(
                  Icons.logout,
                  color: AppColors.white,
                  size: 20,
                ),

          label: Text(
            controller.isLoading.value
                ? "logging_out".tr
                : "logout".tr,
            style: const TextStyle(
              color: AppColors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),

          style: OutlinedButton.styleFrom(
            backgroundColor: const Color(0xFF008541),
            side: const BorderSide(
              color: AppColors.white,
              width: 1.2,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        );
      },
    ),
  ),
),

const SizedBox(height: 50),


//               const SizedBox(height: 50),
//             Center(
//   child: SizedBox(
//     width: Get.width * 0.7,
//     height: 46,
//     child: OutlinedButton.icon(
//       onPressed: () {
//         Get.put(LogoutController()).logout();
//       },
//       icon: const Icon(
//         Icons.logout,
//         color:AppColors.white,
//         size: 20,
//       ),
//       label: Text(
//         "logout".tr,
//         style: const TextStyle(
//               color:AppColors.white,
//           fontSize: 15,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       style: OutlinedButton.styleFrom(
//         backgroundColor:  Color(0xFF008541),
//         side: const BorderSide(
//           color:AppColors.white,
//           width: 1.2,
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(14),
//         ),
//       ),
//     ),
//   ),
// ),

//               const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- SECTION TITLE ----------------
  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }

  // ---------------- MENU TILE ----------------
  Widget menuTile(String title, IconData icon, {VoidCallback? onTap}) {
    const Color appGreen = Color(0xFF008541);

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        margin: const EdgeInsets.only(bottom: 1),
        color: Colors.white,
        child: Row(
          children: [
            Icon(icon, color: appGreen, size: 24),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
