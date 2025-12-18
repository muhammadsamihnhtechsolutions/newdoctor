// import 'package:beh_doctor/views/DoctorProfileScreen.dart';
// import 'package:beh_doctor/views/EarningHistoryScreen.dart';
// import 'package:beh_doctor/views/WithdrawScreen.dart';
// import 'package:beh_doctor/widgets/DoctorHeaderWidget.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//  // Import your DoctorProfileScreen

// class MorePage extends StatelessWidget {
//   const MorePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade100,
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [

//             // ---------------- PROFILE HEADER ----------------
//                const SizedBox(height: 20),
//             DoctorHeaderWidget(),

//             const SizedBox(height: 20),

//             // ---------------- PAYMENT SECTION ----------------
//             sectionTitle("PAYMENT"),
//             menuTile("Payout Accounts", Icons.account_balance_wallet, onTap: () {
//               // Navigate to Payout Accounts Screen
//               Get.to(() => WithdrawScreen());
//             }),

//             menuTile("Earning History", Icons.history, onTap: () {
//               Get.to(() => EarningHistoryScreen());
//             }),

//             const SizedBox(height: 20),

//             // ---------------- SETTINGS SECTION ----------------
//             sectionTitle("SETTINGS"),
//             menuTile("Change Mobile Number", Icons.phone_android),
//             // Language option
//             menuTile("Language", Icons.language),

//             // Profile navigation tile
//             menuTile("Profile", Icons.person, onTap: () {
//               Get.to(() => DoctorProfileScreen());
//             }),

//             const SizedBox(height: 20),

//             // ---------------- LEGAL SECTION ----------------
//             sectionTitle("LEGAL"),
//             menuTile("Terms and Conditions", Icons.description),
//             menuTile("Privacy Policy", Icons.privacy_tip),
//             menuTile("Payment Terms", Icons.receipt_long),

//             const SizedBox(height: 20),

//             // ---------------- HELP SECTION ----------------
//             sectionTitle("HELP"),
//             menuTile("Emergency Call", Icons.call),

//             const SizedBox(height: 50),
//           ],
//         ),
//       ),
//     );
//   }

//   // ------------------- SECTION TITLE WIDGET -------------------
//   Widget sectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//       child: Text(
//         title,
//         style: const TextStyle(
//           fontSize: 13,
//           fontWeight: FontWeight.bold,
//           color: Colors.grey,
//         ),
//       ),
//     );
//   }

//   // ------------------- MENU TILE WIDGET -------------------
//   Widget menuTile(String title, IconData icon, {VoidCallback? onTap}) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//         margin: const EdgeInsets.only(bottom: 1),
//         color: Colors.white,
//         child: Row(
//           children: [
//             Icon(icon, color: Colors.green),
//             const SizedBox(width: 15),
//             Expanded(
//               child: Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//             const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:beh_doctor/modules/auth/controller/LogOutController.dart';
import 'package:beh_doctor/views/DoctorProfileScreen.dart';
import 'package:beh_doctor/views/EarningHistoryScreen.dart';
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
      body: SingleChildScrollView(
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
            menuTile("change_mobile_number".tr, Icons.phone_android),
            menuTile("language".tr, Icons.language),
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
            ElevatedButton(
              onPressed: () {
                Get.put(LogoutController()).logout();
              },
              child: Text("logout".tr),
            ),
          ],
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
