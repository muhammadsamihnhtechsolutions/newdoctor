// import 'package:beh_doctor/controller/BottomNavController.dart';
// import 'package:beh_doctor/views/AppointmentScreen.dart';
// import 'package:beh_doctor/views/HomePage.dart';
// import 'package:beh_doctor/views/MorePage.dart';

// import 'package:beh_doctor/views/TransectionScreen.dart';
// import 'package:beh_doctor/widgets/CustomeBottomNav.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class BottomNavScreen extends GetView<BottomNavController> {
//   const BottomNavScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final pages = [
//       HomePage(),
//       TransactionScreen(),
//       // PrescriptionScreen(),

//       AppointmentTabScreen(),
//     //  WithdrawScreen(),

//       const MorePage(),
//     ];

//     return Scaffold(
//       body: PageView(
//         controller: controller.pageController,
//         physics: const NeverScrollableScrollPhysics(),
//         children: pages,
//       ),

//       bottomNavigationBar: CustomBottomNav(),
//     );
//   }
// }

import 'package:beh_doctor/controller/BottomNavController.dart';
import 'package:beh_doctor/views/AppointmentScreen.dart';
import 'package:beh_doctor/views/HomePage.dart';
import 'package:beh_doctor/views/MorePage.dart';
import 'package:beh_doctor/views/TransectionScreen.dart';
import 'package:beh_doctor/widgets/CustomeBottomNav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavScreen extends StatefulWidget {
  BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  // ✅ SAFE controller access

  final BottomNavController _bottomNavController = Get.put(
    BottomNavController(),
  );
  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(),
      TransactionScreen(),
      AppointmentTabScreen(),
      const MorePage(),
    ];

    return Scaffold(
      body: PageView(
        controller: _bottomNavController.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: pages,
      ),
      bottomNavigationBar: CustomBottomNav(),
    );
  }
}
