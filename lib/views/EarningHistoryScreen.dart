

import 'package:beh_doctor/modules/auth/controller/TransectionController.dart';
import 'package:beh_doctor/theme/Appcolars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EarningHistoryScreen extends StatelessWidget {
  final TransactionController controller = Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    controller.fetchWalletStatistics();

    return Scaffold(
appBar: AppBar(
  backgroundColor: Colors.white,
  elevation: 0,
  title: Text(
    'earning_history'.tr,
    style: const TextStyle(color: Colors.black),
  ),
  iconTheme: const IconThemeData(color: Colors.black), // back arrow black
),

      backgroundColor: AppColors.white,
      
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.transactions.isEmpty) {
          return Center(child: Text('no_transactions_found'.tr));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: controller.transactions.length,
          itemBuilder: (context, index) {
            final t = controller.transactions[index];
            final isCredit =
                (t.transactionType ?? '').toLowerCase().contains('credit');

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 6),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        isCredit ? Colors.green[100] : Colors.red[100],
                    child: Icon(
                      isCredit ? Icons.call_received : Icons.call_made,
                      color: isCredit ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.note ?? 'transaction'.tr,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "৳${t.amount?.toStringAsFixed(2) ?? '0.00'}",
                          style: TextStyle(
                            color: isCredit ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    t.createdAt != null
                        ? t.createdAt!.split('T')[0]
                        : '',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
