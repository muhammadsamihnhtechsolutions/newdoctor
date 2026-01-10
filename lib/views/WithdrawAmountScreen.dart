


// import 'package:beh_doctor/models/WithdrawAccountListResponse.dart';
// import 'package:beh_doctor/modules/auth/controller/TransectionController.dart';
// import 'package:beh_doctor/repo/AuthRepo.dart';
// import 'package:beh_doctor/views/WithdrawSuccesScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class WithdrawAmountScreen extends StatelessWidget {
//   final WithdrawAccount account = Get.arguments;

//   final amountController = TextEditingController();
//   final withdrawRepo = WithdrawAccountRepo();
//   final transactionController = Get.find<TransactionController>();

//   final RxBool isLoading = false.obs;

//   final Color appGreen = const Color(0xFF008541);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Withdraw"),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// ---------------- Withdraw To Card ----------------
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade100,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Withdraw to",
//                     style: TextStyle(color: appGreen, fontSize: 14),
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     account.accountName,
//                     style: const TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   _row("Bank Name",
//                       account.displayBankName ?? account.bankName),
//                   _row("Branch",
//                       account.branch.isEmpty ? "-" : account.branch),
//                   _row("District",
//                       account.displayDistrict ?? account.district),
//                   _row("A/C", account.accountNumber),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 24),

//             /// ---------------- Amount + Balance ----------------
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   "Amount",
//                   style: TextStyle(fontWeight: FontWeight.w600),
//                 ),
//                 Obx(() => Text(
//                       "Available: ${transactionController.walletBalance.value.toStringAsFixed(2)} TK",
//                       style: TextStyle(color: appGreen),
//                     )),
//               ],
//             ),

//             const SizedBox(height: 8),

//             TextField(
//               controller: amountController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 hintText: "Enter amount",
//                 suffixText: "Max",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),

//             const Spacer(),

//             /// ---------------- Withdraw Button ----------------
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: Obx(() => ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: appGreen,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     onPressed:
//                         isLoading.value ? null : submitWithdraw,
//                     child: isLoading.value
//                         ? const SizedBox(
//                             height: 22,
//                             width: 22,
//                             child: CircularProgressIndicator(
//                               strokeWidth: 2.5,
//                               valueColor:
//                                   AlwaysStoppedAnimation<Color>(
//                                       Colors.white),
//                             ),
//                           )
//                         : const Text(
//                             "Withdraw",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                   )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _row(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 3),
//       child: Row(
//         children: [
//           SizedBox(width: 80, child: Text(title)),
//           const Text(": "),
//           Expanded(child: Text(value)),
//         ],
//       ),
//     );
//   }

//   void submitWithdraw() async {
//     final amount = double.tryParse(amountController.text.trim());

//     if (amount == null || amount <= 0) {
//       Get.snackbar("Error", "Enter valid amount");
//       return;
//     }

//     if (amount > transactionController.walletBalance.value) {
//       Get.snackbar("Error", "Insufficient balance");
//       return;
//     }

//     /// ✅ LOADING START
//     isLoading.value = true;

//     final response = await withdrawRepo.getDoctorWalletSubmitWithdraw({
//       "paymentAccount": account.id,
//       "amount": amount,
//     });

//     /// ✅ LOADING STOP
//     isLoading.value = false;

//     if (response.status == "success") {
//       Get.snackbar("Success", response.message ?? "Withdraw request sent");

//       await transactionController.fetchWalletStatistics();
//       await transactionController.fetchTransactions();

//   Get.to(() => const WithdrawSuccessScreen());
//     } else {
//       Get.snackbar("Error", response.message ?? "Withdraw failed");
//     }
//   }
// }


import 'package:beh_doctor/models/WithdrawAccountListResponse.dart';
import 'package:beh_doctor/modules/auth/controller/TransectionController.dart';
import 'package:beh_doctor/repo/AuthRepo.dart';
import 'package:beh_doctor/views/WithdrawSuccesScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class WithdrawAmountScreen extends StatelessWidget {
  final WithdrawAccount account = Get.arguments;

  final amountController = TextEditingController();
  final withdrawRepo = WithdrawAccountRepo();
  final transactionController = Get.find<TransactionController>();

  final RxBool isLoading = false.obs;

  final Color appGreen = const Color(0xFF008541);

  /// 🔔 LOCAL NOTIFICATION INSTANCE
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  WithdrawAmountScreen({super.key}) {
    _initNotifications();
  }

  void _initNotifications() {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();

    const settings = InitializationSettings(
      android: android,
      iOS: ios,
    );

    _notificationsPlugin.initialize(settings);
  }

  Future<void> _showWithdrawSuccessNotification() async {
    const androidDetails = AndroidNotificationDetails(
      'withdraw_channel',
      'Withdraw Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const notificationDetails =
        NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      0,
      'Withdraw Successful',
      'Your withdraw request has been submitted successfully.',
      notificationDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Withdraw"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ---------------- Withdraw To Card ----------------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Withdraw to",
                    style: TextStyle(color: appGreen, fontSize: 14),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    account.accountName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _row("Bank Name",
                      account.displayBankName ?? account.bankName),
                  _row("Branch",
                      account.branch.isEmpty ? "-" : account.branch),
                  _row("District",
                      account.displayDistrict ?? account.district),
                  _row("A/C", account.accountNumber),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// ---------------- Amount + Balance ----------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Amount",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Obx(() => Text(
                      "Available: ${transactionController.walletBalance.value.toStringAsFixed(2)} TK",
                      style: TextStyle(color: appGreen),
                    )),
              ],
            ),

            const SizedBox(height: 8),

            /// 🟢 AMOUNT FIELD (GREEN BORDER + CURSOR)
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              cursorColor: appGreen,
              decoration: InputDecoration(
                hintText: "Enter amount",
                suffixText: "Max",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: appGreen),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: appGreen, width: 2),
                ),
              ),
            ),

            const Spacer(),

            /// ---------------- Withdraw Button ----------------
            SizedBox(
              width: double.infinity,
              height: 50,
              child: Obx(
                () => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: isLoading.value ? null : submitWithdraw,
                  child: isLoading.value
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          "Withdraw",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(width: 80, child: Text(title)),
          const Text(": "),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void submitWithdraw() async {
    final amount = double.tryParse(amountController.text.trim());

    if (amount == null || amount <= 0) {
      Get.snackbar("Error", "Enter valid amount");
      return;
    }

    if (amount > transactionController.walletBalance.value) {
      Get.snackbar("Error", "Insufficient balance");
      return;
    }

    /// ⏳ LOADING START (same screen)
    isLoading.value = true;

    final response = await withdrawRepo.getDoctorWalletSubmitWithdraw({
      "paymentAccount": account.id,
      "amount": amount,
    });

    isLoading.value = false;

    if (response.status == "success") {
      await transactionController.fetchWalletStatistics();
      await transactionController.fetchTransactions();

      /// 🔔 LOCAL NOTIFICATION (FG + BG)
      await _showWithdrawSuccessNotification();

      /// ➡️ SUCCESS SCREEN
      Get.to(() => const WithdrawSuccessScreen());
    }
  }
}
