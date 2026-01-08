// import 'package:beh_doctor/models/BankListResponse.dart';
// import 'package:beh_doctor/models/WithdrawAccountListResponse.dart';
// import 'package:beh_doctor/modules/auth/controller/WithdrawController.dart';
// import 'package:beh_doctor/repo/AuthRepo.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AddMfsController extends GetxController {
//   final WithdrawAccountRepo _repo = WithdrawAccountRepo();

//   // MFS list
//   RxList<BankModel> mfsList = <BankModel>[].obs;

//   // Selected MFS
//   Rxn<BankModel> selectedMfs = Rxn<BankModel>();

//   // Text Controllers
//   TextEditingController accountNameController = TextEditingController();
//   TextEditingController accountNumberController = TextEditingController();

//   // Loading
//   RxBool isLoading = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchMfsList();
//   }

//   // ---------------- FETCH MFS LIST ----------------
//   void fetchMfsList() async {
//     isLoading.value = true;
//     try {
//       final response = await _repo.getBankAndMfsListResponse({});

//       if (response.status == "success" && response.bankList != null) {
//         mfsList.assignAll(response.bankList!.where((e) => e.type == "mfs"));
//       } else {
//         Get.snackbar(
//           "error".tr,
//           response.message ?? "failed_to_load_mfs_list".tr,
//         );
//       }
//     } catch (e) {
//       Get.snackbar("error".tr, "failed_to_fetch_mfs_list".tr);
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ---------------- SUBMIT ----------------
//   void submit() {
//     if (selectedMfs.value == null) {
//       Get.snackbar("error".tr, "please_select_mfs_name".tr);
//       return;
//     }

//     if (accountNameController.text.trim().isEmpty) {
//       Get.snackbar("error".tr, "please_enter_account_name".tr);
//       return;
//     }

//     if (accountNumberController.text.trim().isEmpty) {
//       Get.snackbar("error".tr, "please_enter_account_number".tr);
//       return;
//     }

//     // Logs
//     print("MFS Name: ${selectedMfs.value!.title}");
//     print("Account Name: ${accountNameController.text}");
//     print("Account Number: ${accountNumberController.text}");

//     // Add to Withdraw Account list
//     final withdrawController = Get.find<WithdrawAccountController>();

//     withdrawController.mfsAccounts.add(
//       WithdrawAccount(
//         id: DateTime.now().millisecondsSinceEpoch.toString(),
//         ownerType: "user",
//         accountType: "mfs",
//         owner: "self",
//         mfsName: selectedMfs.value!.title ?? "",
//         accountName: accountNameController.text,
//         accountNumber: accountNumberController.text,
//         createdAt: DateTime.now().toIso8601String(),
//         updatedAt: DateTime.now().toIso8601String(),
//         v: 0,
//         bankName: '',
//         branch: '',
//         district: '',
//       ),
//     );

//     Get.back();
//     Get.snackbar("success".tr, "mfs_account_added_successfully".tr);
//   }
// }

import 'package:beh_doctor/models/BankListResponse.dart';
import 'package:beh_doctor/modules/auth/controller/WithdrawController.dart';
import 'package:beh_doctor/repo/AuthRepo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMfsController extends GetxController {
  final WithdrawAccountRepo _repo = WithdrawAccountRepo();

  // MFS list
  RxList<BankModel> mfsList = <BankModel>[].obs;

  // Selected MFS
  Rxn<BankModel> selectedMfs = Rxn<BankModel>();

  // Text Controllers
  TextEditingController accountNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();

  // Loading
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMfsList();
  }

  // ---------------- FETCH MFS LIST ----------------
  void fetchMfsList() async {
    isLoading.value = true;
    try {
      final response = await _repo.getBankAndMfsListResponse({"type": "mfs"});

      if (response.status == "success" && response.bankList != null) {
        mfsList.assignAll(response.bankList!);
      } else {
        Get.snackbar("error".tr, response.message ?? "failed_to_load_mfs_list".tr);
      }
    } catch (_) {
      Get.snackbar("error".tr, "failed_to_fetch_mfs_list".tr);
    } finally {
      isLoading.value = false;
    }
  }

  // ================= SUBMIT =================
  void submit() async {
    if (selectedMfs.value == null ||
        accountNameController.text.trim().isEmpty ||
        accountNumberController.text.trim().isEmpty) {
      Get.snackbar("error".tr, "please_fill_all_fields".tr);
      return;
    }

    isLoading.value = true;

  final params = {
  "accountType": "mfs",

  // 🔴 backend ko khush rakhne ke liye
  "bankName": selectedMfs.value!.id,

  // real mfs id
  "mfsName": selectedMfs.value!.id,

  "accountName": accountNameController.text.trim(),
  "accountNumber": accountNumberController.text.trim(),
};

    final response = await _repo.addNewBankAccount(params);

    isLoading.value = false;

    if (response.status == "success") {
      /// 🔥 SAME AS BANK FLOW
      final withdrawController = Get.find<WithdrawAccountController>();
      await withdrawController.fetchAccounts();

      Get.back();
      Get.snackbar("success".tr, "mfs_account_added_successfully".tr);
    } else {
      Get.snackbar("error".tr, response.message ?? "failed_to_add_mfs_account".tr);
    }
  }
}
