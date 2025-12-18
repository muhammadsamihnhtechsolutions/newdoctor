// import 'package:beh_doctor/models/BankListResponse.dart';
// import 'package:beh_doctor/models/DistrictResponseModel.dart';
// import 'package:beh_doctor/repo/AuthRepo.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//  // your repo file

// class AddBankController extends GetxController {
//   final WithdrawAccountRepo _repo = WithdrawAccountRepo();

//   // Lists
//   var bankList = <BankModel>[].obs;
//   var districtList = <District>[].obs;

//   // Selected values
//   var selectedBank = Rxn<BankModel>();
//   var selectedDistrict = Rxn<District>();

//   // TextControllers
//   final branchController = TextEditingController();
//   final accountNameController = TextEditingController();
//   final accountNumberController = TextEditingController();

//   // Loading state
//   var isLoading = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchBanks();
//     fetchDistricts();
//   }

//   void fetchBanks() async {
//     try {
//       var response = await _repo.getBankAndMfsListResponse({"type": "bank"});
//       if (response.status == "success" && response.bankList != null) {
//         bankList.assignAll(response.bankList!);
//       } else {
//         Get.snackbar("Error", response.message ?? "Failed to load banks");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Failed to fetch banks");
//     }
//   }

//   void fetchDistricts() async {
//     try {
//       var response = await _repo.districtListResponse();
//       if (response.status == "success" && response.districtList != null) {
//         districtList.assignAll(response.districtList!);
//       } else {
//         Get.snackbar("Error", response.message ?? "Failed to load districts");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Failed to fetch districts");
//     }
//   }

//   void submit() {
//     if (selectedBank.value == null) {
//       Get.snackbar("Error", "Please select a bank");
//       return;
//     }
//     if (selectedDistrict.value == null) {
//       Get.snackbar("Error", "Please select a district");
//       return;
//     }
//     if (branchController.text.trim().isEmpty) {
//       Get.snackbar("Error", "Please enter branch name");
//       return;
//     }
//     if (accountNameController.text.trim().isEmpty) {
//       Get.snackbar("Error", "Please enter account name");
//       return;
//     }
//     if (accountNumberController.text.trim().isEmpty) {
//       Get.snackbar("Error", "Please enter account number");
//       return;
//     }

//     // Print all values to terminal
//     print("Bank Name: ${selectedBank.value!.title}");
//     print("Branch Name: ${branchController.text}");
//     print("District: ${selectedDistrict.value!.name}");
//     print("Account Name: ${accountNameController.text}");
//     print("Account Number: ${accountNumberController.text}");
//   }
// }

import 'package:beh_doctor/models/BankListResponse.dart';
import 'package:beh_doctor/models/DistrictResponseModel.dart';
import 'package:beh_doctor/models/WithdrawAccountListResponse.dart';
import 'package:beh_doctor/modules/auth/controller/WithdrawController.dart';
import 'package:beh_doctor/repo/AuthRepo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBankController extends GetxController {
  final WithdrawAccountRepo _repo = WithdrawAccountRepo();

  var bankList = <BankModel>[].obs;
  var districtList = <District>[].obs;

  var selectedBank = Rxn<BankModel>();
  var selectedDistrict = Rxn<District>();

  final branchController = TextEditingController();
  final accountNameController = TextEditingController();
  final accountNumberController = TextEditingController();

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBanks();
    fetchDistricts();
  }

  void fetchBanks() async {
    try {
      final response = await _repo.getBankAndMfsListResponse({"type": "bank"});
      if (response.status == "success") {
        bankList.assignAll(response.bankList ?? []);
      }
    } catch (_) {}
  }

  void fetchDistricts() async {
    try {
      final response = await _repo.districtListResponse();
      if (response.status == "success") {
        districtList.assignAll(response.districtList ?? []);
      }
    } catch (_) {}
  }

  // ================= SUBMIT =================
  void submit() async {
    if (selectedBank.value == null ||
        selectedDistrict.value == null ||
        branchController.text.isEmpty ||
        accountNameController.text.isEmpty ||
        accountNumberController.text.isEmpty) {
      Get.snackbar("error".tr, "please_fill_all_fields".tr);
      return;
    }

    isLoading.value = true;

    final params = {
      "accountType": "bank",
      "bankName": selectedBank.value!.title,
      "branch": branchController.text.trim(),
      "district": selectedDistrict.value!.name,
      "accountName": accountNameController.text.trim(),
      "accountNumber": accountNumberController.text.trim(),
    };

    // final response = await _repo.addNewBankAccount(params);

    // isLoading.value = false;

    // if (response.status == "success") {
    //   /// 🔥 IMPORTANT PART
    //   /// withdraw controller se fresh list lao
    //   final withdrawController = Get.find<WithdrawAccountController>();
    //   await withdrawController.fetchAccounts();

    //   Get.back();
    //   Get.snackbar("Success", "Bank account added successfully");
    // } else {
    //   Get.snackbar("Error", response.message ?? "Failed to add account");
    // }
  }
}


// class AddBankController extends GetxController {
// // API calls ke liye repo
//   final WithdrawAccountRepo _repo = WithdrawAccountRepo();

//   // Lists
//   var bankList = <BankModel>[].obs;
//   var districtList = <District>[].obs;

//   // Selected
//   var selectedBank = Rxn<BankModel>();
//   var selectedDistrict = Rxn<District>();

//   // Text Controllers
//   final branchController = TextEditingController();
//   final accountNameController = TextEditingController();
//   final accountNumberController = TextEditingController();

//   // Loading
//   var isLoading = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchBanks();
//     fetchDistricts();
//   }

//   // ---------------- FETCH BANKS ----------------
//   void fetchBanks() async {
//     isLoading.value = true;
//     try {
//       final response = await _repo.getBankAndMfsListResponse({"type": "bank"});
//       if (response.status == "success" && response.bankList != null) {
//         bankList.assignAll(response.bankList!);
//       } else {
//         Get.snackbar("Error", response.message ?? "Failed to fetch banks");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Failed to fetch banks");
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ---------------- FETCH DISTRICTS ----------------
//   void fetchDistricts() async {
//     isLoading.value = true;
//     try {
//       final response = await _repo.districtListResponse();
//       if (response.status == "success" && response.districtList != null) {
//         districtList.assignAll(response.districtList!);
//       } else {
//         Get.snackbar("Error", response.message ?? "Failed to fetch districts");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "Failed to fetch districts");
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ---------------- SUBMIT ----------------
//   void submit() {
//     if (selectedBank.value == null) {
//       Get.snackbar("Error", "Please select a bank");
//       return;
//     }
//     if (selectedDistrict.value == null) {
//       Get.snackbar("Error", "Please select a district");
//       return;
//     }
//     if (branchController.text.trim().isEmpty) {
//       Get.snackbar("Error", "Please enter branch name");
//       return;
//     }
//     if (accountNameController.text.trim().isEmpty) {
//       Get.snackbar("Error", "Please enter account name");
//       return;
//     }
//     if (accountNumberController.text.trim().isEmpty) {
//       Get.snackbar("Error", "Please enter account number");
//       return;
//     }

//     // Terminal print
//     print("Bank Name: ${selectedBank.value!.title}");
//     print("Branch Name: ${branchController.text}");
//     print("District: ${selectedDistrict.value!.name}");
//     print("Account Name: ${accountNameController.text}");
//     print("Account Number: ${accountNumberController.text}");

//     // Add to WithdrawController
//     final withdrawController = Get.find<WithdrawAccountController>();
//     withdrawController.bankAccounts.add(
//       WithdrawAccount(
//         id: DateTime.now().millisecondsSinceEpoch.toString(),
//         ownerType: "user",
//         accountType: "bank",
//         owner: "self",
//         bankName: selectedBank.value!.title ?? "",
//         branch: branchController.text,
//         district: selectedDistrict.value!.name ?? "",
//         accountName: accountNameController.text,
//         accountNumber: accountNumberController.text,
//         createdAt: DateTime.now().toIso8601String(),
//         updatedAt: DateTime.now().toIso8601String(),
//         v: 0, mfsName: '',
//       ),
//     );

//     // Navigate back
//     Get.back();
//   }
// }

