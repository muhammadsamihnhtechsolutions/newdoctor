import 'package:beh_doctor/modules/auth/controller/TransectionController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EarningHistoryScreen extends StatelessWidget {
  final TransactionController controller = Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    controller.fetchWalletStatistics();

    return Scaffold(
      appBar: AppBar(title: Text('earning_history'.tr)),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.transactions.isEmpty) {
          return Center(child: Text('no_transactions_found'.tr));
        }

        return ListView.builder(
          itemCount: controller.transactions.length,
          itemBuilder: (context, index) {
            final t = controller.transactions[index];
            return ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text(t.note ?? 'transaction'.tr),
              subtitle: Text(
                '${"amount".tr}: \$${t.amount?.toStringAsFixed(2) ?? 0}',
              ),
              trailing: Text(
                t.createdAt != null ? t.createdAt!.split('T')[0] : '',
              ),
            );
          },
        );
      }),
    );
  }
}
