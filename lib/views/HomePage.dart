

// import 'package:beh_doctor/modules/AppointmentController.dart';
// import 'package:beh_doctor/theme/AppAssets.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:beh_doctor/widgets/MyStatusWidget.dart';
// import 'package:beh_doctor/widgets/UpcomingBookings.dart';
// import 'package:beh_doctor/widgets/HomeAppBar.dart';
// import 'package:lottie/lottie.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final AppointmentController _appointmentController =
//         Get.isRegistered<AppointmentController>()
//         ? Get.find<AppointmentController>()
//         : Get.put(
//             AppointmentController(autoFetchOnInit: false),
//             permanent: true,
//           );

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: HomeAppBarGetX(bellIcon: ''),
//       body: RefreshIndicator(
//         onRefresh: _appointmentController.fetchAppointments,
//         child: SingleChildScrollView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           child: Column(
//             children: [
//               MyStatusWidget(),
//               const SizedBox(height: 10),

//               Obx(() {
//                 final upcomingList =
//                     _appointmentController.upcomingAppointments;

//                 if (upcomingList.isEmpty) {
//                   return Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 16),
//                     padding: const EdgeInsets.all(20),
//                     height: 200,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade200,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // 🔥 LOTTIE ADDED HERE
//                         SizedBox(
//                           height: 100,
//                           child: Lottie.asset(AppAssets.searchEmpty),
//                         ),

//                         const SizedBox(height: 10),

//                         Text(
//                           "no_data".tr,
//                           style: const TextStyle(
//                             color: Colors.grey,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }

//                 return ListView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: upcomingList.length,
//                   itemBuilder: (context, index) {
//                     return UpcomingItemWidget(appointment: upcomingList[index]);
//                   },
//                 );
//               }),

//               const SizedBox(height: 20),

//               const SizedBox(height: 20),
//               Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Column(
//                   children: [
//                     // 🔥 TITLE
//                     Text(
//                       "latest_transactions".tr,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         color: Colors.grey,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),

//                     const SizedBox(height: 10),

//                     // 🔥 LOTTIE ANIMATION
//                     SizedBox(
//                       height: 120,
//                       child: Lottie.asset(AppAssets.searchEmpty),
//                     ),

//                     const SizedBox(height: 10),

//                     // 🔥 NO DATA TEXT
//                     Text(
//                       "no_data".tr,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(
//                         color: Colors.grey,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:beh_doctor/modules/AppointmentController.dart';
// import 'package:beh_doctor/theme/AppAssets.dart';
// import 'package:beh_doctor/views/AppointmentScreen.dart';
// import 'package:beh_doctor/views/TransectionScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'package:beh_doctor/widgets/MyStatusWidget.dart';
// import 'package:beh_doctor/widgets/UpcomingBookings.dart';
// import 'package:beh_doctor/widgets/HomeAppBar.dart';
// import 'package:lottie/lottie.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final AppointmentController appointmentController =
//         Get.isRegistered<AppointmentController>()
//             ? Get.find<AppointmentController>()
//             : Get.put(
//                 AppointmentController(autoFetchOnInit: false),
//                 permanent: true,
//               );

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: HomeAppBarGetX(bellIcon: ''),
//       body: RefreshIndicator(
//         onRefresh: appointmentController.fetchAppointments,
//         child: SingleChildScrollView(
//           physics: const AlwaysScrollableScrollPhysics(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /// ---------------- STATUS ----------------
//               const SizedBox(height: 10),
//               MyStatusWidget(),

//               const SizedBox(height: 16),

//               /// ================= UPCOMING BOOKINGS =================
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Upcoming Appointments",
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () =>     Get.to(() =>  AppointmentTabScreen()),
//                       child: const Text(
//                         "See all",
//                         style: TextStyle(
//                           color: Color(0xFF008541),
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 10),

//               Obx(() {
//                 final list = appointmentController.upcomingAppointments;
//                 final recentFive =
//                     list.length > 5 ? list.take(5).toList() : list;

//                 if (recentFive.isEmpty) {
//                   return Container(
//                     margin: const EdgeInsets.symmetric(
//                         horizontal: 16, vertical: 8),
//                     padding: const EdgeInsets.all(20),
//                     height: 200,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade200,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                           height: 100,
//                           child: Lottie.asset(AppAssets.searchEmpty),
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           "no_data".tr,
//                           style: const TextStyle(
//                             color: Colors.grey,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }

//                 return ListView.builder(
//                   itemCount: recentFive.length,
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.only(bottom: 8),
//                       child: UpcomingItemWidget(
//                         appointment: recentFive[index],
//                       ),
//                     );
//                   },
//                 );
//               }),

//               const SizedBox(height: 24),

//               /// ================= RECENT TRANSACTIONS =================
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "Recent Transactions",
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () =>  Get.to(() =>  TransactionScreen()),
//                       child: const Text(
//                         "See all",
//                         style: TextStyle(
//                           color: Color(0xFF008541),
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 10),

//               /// ⚠️ Replace this with your Transaction list widget
//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 16),
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade200,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 120,
//                       child: Lottie.asset(AppAssets.searchEmpty),
//                     ),
//                     const SizedBox(height: 10),
//                     Text(
//                       "no_data".tr,
//                       style: const TextStyle(
//                         color: Colors.grey,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               const SizedBox(height: 30),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// 
import 'package:beh_doctor/controller/BottomNavController.dart';
import 'package:beh_doctor/modules/AppointmentController.dart';
import 'package:beh_doctor/modules/auth/controller/TransectionController.dart';
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
    final AppointmentController appointmentController =
        Get.isRegistered<AppointmentController>()
            ? Get.find<AppointmentController>()
            : Get.put(
                AppointmentController(autoFetchOnInit: false),
                permanent: true,
              );

    final TransactionController transactionController =
        Get.isRegistered<TransactionController>()
            ? Get.find<TransactionController>()
            : Get.put(TransactionController(), permanent: true);

    final BottomNavController bottomNavController =
        Get.find<BottomNavController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBarGetX(bellIcon: ''),
      body: RefreshIndicator(
        onRefresh: () async {
          await appointmentController.fetchAppointments();
          await transactionController.fetchTransactions();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              MyStatusWidget(),

              const SizedBox(height: 16),

              /// ================= UPCOMING BOOKINGS =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Upcoming Appointments",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => bottomNavController.changeTab(2),
                      child: const Text(
                        "See all",
                        style: TextStyle(
                          color: Color(0xFF008541),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              Obx(() {
                final list = appointmentController.upcomingAppointments;
                final recentFive =
                    list.length > 5 ? list.take(5).toList() : list;

                if (recentFive.isEmpty) {
                  return _emptyBox();
                }

                return ListView.builder(
                  itemCount: recentFive.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: UpcomingItemWidget(
                        appointment: recentFive[index],
                      ),
                    );
                  },
                );
              }),

              const SizedBox(height: 24),

              /// ================= RECENT TRANSACTIONS =================
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recent Transactions",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => bottomNavController.changeTab(1),
                      child: const Text(
                        "See all",
                        style: TextStyle(
                          color: Color(0xFF008541),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// 🔥 LAST 5 TRANSACTIONS
              Obx(() {
                final list = transactionController.transactions;
                final recentFive =
                    list.length > 5 ? list.take(5).toList() : list;

                if (recentFive.isEmpty) {
                  return _emptyBox();
                }

                return ListView.builder(
                  itemCount: recentFive.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (context, index) {
                    final t = recentFive[index];
                    final isCredit = (t.transactionType ?? '')
                        .toLowerCase()
                        .contains('credit');

                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: isCredit
                                ? Colors.green[100]
                                : Colors.red[100],
                            child: Icon(
                              isCredit
                                  ? Icons.call_received
                                  : Icons.call_made,
                              color:
                                  isCredit ? Colors.green : Colors.red,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  t.note ?? 'Transaction',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "৳${t.amount?.toStringAsFixed(2) ?? '0.00'}",
                                  style: TextStyle(
                                    color: isCredit
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            t.createdAt != null
                                ? t.createdAt!.split('T')[0]
                                : '',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptyBox() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      height: 180,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 90,
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
}
