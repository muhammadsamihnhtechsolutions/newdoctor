import 'package:beh_doctor/modules/auth/controller/WithdrawController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MfsAccountsWidget extends StatelessWidget {
  MfsAccountsWidget({super.key});

  final controller = Get.find<WithdrawAccountController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.mfsAccounts.isEmpty) {
        return Center(child: Text("no_mfs_accounts_found".tr));
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.mfsAccounts.length,
        itemBuilder: (context, index) {
          final acc = controller.mfsAccounts[index];

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: ListTile(
              title: Text(
                acc.accountName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${"mfs_type".tr}: ${acc.bankName}"),
                  Text("${"account_number".tr}: ${acc.accountNumber}"),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

