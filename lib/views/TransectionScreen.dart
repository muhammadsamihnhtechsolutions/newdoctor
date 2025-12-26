
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
        // backgroundColor: const Color.fromARGB(255, 168, 16, 16),
        backgroundColor: AppColors.white,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            /// -----------------------
            /// 🔥 TOP WALLET BOX (Screenshot Style UI)
            /// -----------------------
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 3),
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
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "\$${controller.walletBalance.value.toStringAsFixed(2)}",
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
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "\$${controller.totalEarning.value.toStringAsFixed(2)}",
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

                  /// WITHDRAW BUTTON (same as your screenshot)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => WithdrawScreen()); // <-- Navigation
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
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// -----------------------
            /// 🔥 TRANSACTIONS LIST
            /// -----------------------
            Expanded(
              child: ListView.builder(
                itemCount: controller.transactions.length,
                itemBuilder: (context, index) {
                  final tx = controller.transactions[index];
                  return ListTile(
                    title: Text(tx.transactionType ?? ''),
                    subtitle: Text(tx.note ?? ''),
                    trailing: Text(
                      "\$${tx.amount?.toStringAsFixed(2) ?? '0.00'}",
                      style: const TextStyle(fontWeight: FontWeight.w600),
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
