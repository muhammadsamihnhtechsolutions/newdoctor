import 'package:beh_doctor/controller/BottomNavController.dart';
import 'package:beh_doctor/views/BottomNavScreen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithdrawSuccessScreen extends StatelessWidget {
  const WithdrawSuccessScreen({super.key});

  final Color appGreen = const Color(0xFF008541);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const Spacer(),

            /// ✅ SUCCESS ICON
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                color: appGreen.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: appGreen,
                size: 70,
              ),
            ),

            const SizedBox(height: 20),

            /// ✅ TITLE
            const Text(
              "Withdraw Request Successful",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 10),

            /// ✅ DESCRIPTION
            const Text(
              "Your withdraw request has been submitted successfully.\n"
              "You will receive your payment within 2 working days.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),

            const Spacer(),

            /// ✅ BACK TO HOME BUTTON
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: appGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                // onPressed: () {
                //   // NAVIGATE TO BOTTOM NAV SCREEN
                //   Get.offAll(() =>  BottomNavScreen());
                // },
                
                onPressed: () {
  final bottomNav = Get.find<BottomNavController>();
  bottomNav.changeTab(0);
  Get.offAll(() => BottomNavScreen());
}
,
                child: const Text(
                  "Back to Home",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
