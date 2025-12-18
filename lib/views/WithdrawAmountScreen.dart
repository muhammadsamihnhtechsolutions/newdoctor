import 'package:beh_doctor/models/WithdrawAccountListResponse.dart';
import 'package:beh_doctor/modules/auth/controller/TransectionController.dart';
import 'package:beh_doctor/repo/AuthRepo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithdrawAmountScreen extends StatelessWidget {
  // final WithdrawAccount account;
  final WithdrawAccount account = Get.arguments;
  // WithdrawAmountScreen({required this.account});

  final amountController = TextEditingController();

  final withdrawRepo = WithdrawAccountRepo();

  final transactionController = Get.find<TransactionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("withdraw_amount".tr)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text("${"account".tr}: ${account.accountNumber}"),
            const SizedBox(height: 16),

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "enter_amount".tr,
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            ElevatedButton(onPressed: submitWithdraw, child: Text("submit".tr)),
          ],
        ),
      ),
    );
  }

  void submitWithdraw() async {
    final amount = double.tryParse(amountController.text.trim());

    if (amount == null || amount <= 0) {
      Get.snackbar("error".tr, "valid_amount".tr);
      return;
    }

    // 🔴 BALANCE CHECK
    if (amount > transactionController.walletBalance.value) {
      Get.snackbar("error".tr, "insufficient_balance".tr);
      return;
    }

    // 🔵 API HIT
    final response = await withdrawRepo.getDoctorWalletSubmitWithdraw({
      "accountId": account.id,
      "amount": amount,
    });

    if (response.status == "success") {
      Get.snackbar(
        "success".tr,
        response.message ?? "withdraw_request_sent".tr,
      );

      // 🔄 Wallet + Transactions refresh
      await transactionController.fetchWalletStatistics();
      await transactionController.fetchTransactions();

      Get.back(); // screen close
    } else {
      Get.snackbar("error".tr, response.message ?? "withdraw_failed".tr);
    }
  }
}
