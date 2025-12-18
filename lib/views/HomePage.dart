// import 'package:beh_doctor/models/AppointmentModel.dart';
// import 'package:beh_doctor/modules/AppointmentController.dart';
// import 'package:beh_doctor/views/PrescriptionScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:beh_doctor/widgets/MyStatusWidget.dart';
// import 'package:beh_doctor/widgets/UpcomingBookings.dart';
// import 'package:beh_doctor/widgets/HomeAppBar.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final AppointmentController _appointmentController = Get.put(AppointmentController());

//     // Fetch appointments on open
//     _appointmentController.fetchAppointments();

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: HomeAppBarGetX(bellIcon: ''),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             MyStatusWidget(),
//             const SizedBox(height: 10),
//        UpcomingItemWidget(
//   appointment: _appointmentController.upcomingAppointments.isNotEmpty
//       ? _appointmentController.upcomingAppointments.first
//       : Appointment(),
// ),

//             const SizedBox(height: 20),

//             // 🔹 Prescription Button
//             Obx(() {
//               if (_appointmentController.upcomingAppointments.isEmpty) {
//                 return const SizedBox.shrink(); // No upcoming appointment yet
//               }
//               final patientId = _appointmentController.upcomingAppointments.first.patient?.id ?? '';
//               if (patientId.isEmpty) return const SizedBox.shrink();

//               return ElevatedButton(
//                 onPressed: () {
//                   Get.to(() => PrescriptionListScreen(patientId: patientId));
//                 },
//                 child: const Text("View Prescriptions"),
//               );
//             }),

//             const SizedBox(height: 20),
//             const Padding(
//               padding: EdgeInsets.all(15),
//               child: Text(
//                 "Latest Transactions\nYou don't have any transaction",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.grey),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:beh_doctor/modules/AppointmentController.dart';
import 'package:beh_doctor/theme/AppAssets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:beh_doctor/widgets/MyStatusWidget.dart';
import 'package:beh_doctor/widgets/UpcomingBookings.dart';
import 'package:beh_doctor/widgets/HomeAppBar.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppointmentController _appointmentController =
        Get.isRegistered<AppointmentController>()
        ? Get.find<AppointmentController>()
        : Get.put(
            AppointmentController(autoFetchOnInit: false),
            permanent: true,
          );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBarGetX(bellIcon: ''),
      body: RefreshIndicator(
        onRefresh: _appointmentController.fetchAppointments,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              MyStatusWidget(),
              const SizedBox(height: 10),

              Obx(() {
                final upcomingList =
                    _appointmentController.upcomingAppointments;

                if (upcomingList.isEmpty) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(20),
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // 🔥 LOTTIE ADDED HERE
                        SizedBox(
                          height: 100,
                          child: Lottie.asset(AppAssets.searchEmpty),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "no_data".tr,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: upcomingList.length,
                  itemBuilder: (context, index) {
                    return UpcomingItemWidget(appointment: upcomingList[index]);
                  },
                );
              }),

              const SizedBox(height: 20),

              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    // 🔥 TITLE
                    Text(
                      "latest_transactions".tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // 🔥 LOTTIE ANIMATION
                    SizedBox(
                      height: 120,
                      child: Lottie.asset(AppAssets.searchEmpty),
                    ),

                    const SizedBox(height: 10),

                    // 🔥 NO DATA TEXT
                    Text(
                      "no_data".tr,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
