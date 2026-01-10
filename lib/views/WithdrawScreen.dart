

import 'package:beh_doctor/modules/auth/controller/WithdrawController.dart';
import 'package:beh_doctor/routes/AppRoutes.dart';
import 'package:beh_doctor/theme/Appcolars.dart';
import 'package:beh_doctor/views/AddBankAcountScreen.dart';
import 'package:beh_doctor/views/AddMfsScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WithdrawScreen extends StatelessWidget {
  WithdrawScreen({super.key});

  final controller = Get.put(WithdrawAccountController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("withdraw".tr),
        centerTitle: true,
      ),

      body: Column(
        children: [
          const SizedBox(height: 12),

          // ---------------- TAB BUTTONS ----------------
          Obx(() {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF008541), width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  _innerTab(
                    title: "bank_accounts".tr,
                    isSelected: controller.selectedTab.value == 0,
                    onTap: () => controller.changeTab(0),
                  ),
                  _innerTab(
                    title: "mfs".tr,
                    isSelected: controller.selectedTab.value == 1,
                    onTap: () => controller.changeTab(1),
                  ),
                ],
              ),
            );
          }),

          const SizedBox(height: 12),

          // ---------------- ACCOUNT LIST ----------------
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final bool isBank = controller.selectedTab.value == 0;
              final List accounts = isBank
                  ? controller.bankAccounts
                  : controller.mfsAccounts;

              if (accounts.isEmpty) {
                return Center(child: Text("no_accounts_found".tr));
              }

              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 70),
                itemCount: accounts.length,
                itemBuilder: (_, i) {
                  final acc = accounts[i];

                  // ✅ YAHAN NAVIGATION ADD KI GAI HAI (ONLY CHANGE)
                  return InkWell(
                    onTap: () {
                      Get.toNamed(Routes.WithdrawAmountScreen, arguments: acc);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            acc.accountName,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _row("bank_name".tr, acc.bankName),
                          if (acc.branch.isNotEmpty)
                            _row("branch".tr, acc.branch),
                          if (acc.district.isNotEmpty)
                            _row("district".tr, acc.district),
                          _row("account".tr, acc.accountNumber),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),

      // ---------------- ADD NEW ACCOUNT BUTTON ----------------
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (controller.selectedTab.value == 0) {
            Get.to(() => AddBankScreen());
          } else {
            Get.to(() => AddMfsScreen());
          }
        },
        child: Container(
          padding: const EdgeInsets.all(14),
          child: Container(
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.color008541,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                "add_new_account".tr,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- HELPERS ----------------

  Widget _row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text("$title:", style: const TextStyle(fontSize: 14)),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  Widget _innerTab({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF008541) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
