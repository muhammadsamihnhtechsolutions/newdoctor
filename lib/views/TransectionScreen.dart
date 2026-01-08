
// import 'package:beh_doctor/modules/auth/controller/TransectionController.dart';
// import 'package:beh_doctor/theme/Appcolars.dart';
// import 'package:beh_doctor/views/WithdrawScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class TransactionScreen extends StatelessWidget {
//   final TransactionController controller = Get.put(TransactionController());

//   TransactionScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     controller.fetchWalletStatistics();
//     controller.fetchTransactions();

//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         title: Text('earning'.tr),
//         // backgroundColor: const Color.fromARGB(255, 168, 16, 16),
//         backgroundColor: AppColors.white,
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         return Column(
//           children: [
//             /// -----------------------
//             /// 🔥 TOP WALLET BOX (Screenshot Style UI)
//             /// -----------------------
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 10,
//                     spreadRadius: 2,
//                     offset: Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   /// TOP ROW
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // BALANCE
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "balance".tr,
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             "\$${controller.walletBalance.value.toStringAsFixed(2)}",
//                             style: const TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),

//                       // TOTAL EARNING
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text(
//                             "total_earning".tr,
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey[600],
//                             ),
//                           ),
//                           const SizedBox(height: 4),
//                           Text(
//                             "\$${controller.totalEarning.value.toStringAsFixed(2)}",
//                             style: const TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 18),

//                   /// WITHDRAW BUTTON (same as your screenshot)
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Get.to(() => WithdrawScreen()); // <-- Navigation
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.color008541,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                       ),
//                       child: Text(
//                         "withdraw".tr,
//                         style: const TextStyle(
//                           color: AppColors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             /// -----------------------
//             /// 🔥 TRANSACTIONS LIST
//             /// -----------------------
//             Expanded(
//               child: ListView.builder(
//                 itemCount: controller.transactions.length,
//                 itemBuilder: (context, index) {
//                   final tx = controller.transactions[index];
//                   return ListTile(
//                     title: Text(tx.transactionType ?? ''),
//                     subtitle: Text(tx.note ?? ''),
//                     trailing: Text(
//                       "\$${tx.amount?.toStringAsFixed(2) ?? '0.00'}",
//                       style: const TextStyle(fontWeight: FontWeight.w600),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }
// }

import 'package:beh_doctor/modules/auth/controller/TransectionController.dart';
import 'package:beh_doctor/theme/Appcolars.dart';
import 'package:beh_doctor/views/WithdrawScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionScreen extends StatelessWidget {
  final TransactionController controller = Get.put(TransactionController());

  TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchWalletStatistics();
    controller.fetchTransactions();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text('earning'.tr),
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            // ================= WALLET CARD =================
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TOP ROW
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // BALANCE
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "balance".tr,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "৳ ${controller.walletBalance.value.toStringAsFixed(2)} TK",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      // TOTAL EARNING
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "total_earning".tr,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "৳ ${controller.totalEarning.value.toStringAsFixed(2)} TK",
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  /// WITHDRAW BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => WithdrawScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.color008541,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "withdraw".tr,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ================= TRANSACTION LIST =================
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: controller.transactions.length,
                itemBuilder: (context, index) {
                  final tx = controller.transactions[index];

                  final bool isCredit =
                      (tx.transactionType ?? '').toLowerCase().contains('credit') ||
                      (tx.transactionType ?? '').toLowerCase().contains('receive');

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
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
                        // ARROW ICON
                        CircleAvatar(
                          radius: 18,
                          backgroundColor:
                              isCredit ? Colors.green.shade50 : Colors.red.shade50,
                          child: Icon(
                            isCredit
                                ? Icons.arrow_downward
                                : Icons.arrow_upward,
                            color: isCredit ? Colors.green : Colors.red,
                            size: 20,
                          ),
                        ),

                        const SizedBox(width: 12),

                        // DETAILS
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tx.transactionType ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                tx.note ?? '',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // AMOUNT
                        Text(
                          "৳ ${tx.amount?.toStringAsFixed(2) ?? '0.00'}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: isCredit ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
