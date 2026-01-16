import 'package:beh_doctor/modules/auth/controller/WithdrawController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankAccountsWidget extends StatelessWidget {
  BankAccountsWidget({super.key});

  final controller = Get.find<WithdrawAccountController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.bankAccounts.isEmpty) {
        return Center(child: Text("no_bank_accounts_found".tr));
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.bankAccounts.length,
        itemBuilder: (context, index) {
          final acc = controller.bankAccounts[index];

          return Card(
            
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            
            elevation: 2,
            child: ListTile(
              
              title: Text(
                acc.bankName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${"account_name".tr}: ${acc.accountName}"),
                  Text("${"account_number".tr}: ${acc.accountNumber}"),
                  if (acc.branch.isNotEmpty)
                    Text("${"branch".tr}: ${acc.branch}"),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

