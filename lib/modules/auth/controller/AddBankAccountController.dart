

import 'package:beh_doctor/models/BankListResponse.dart';
import 'package:beh_doctor/models/DistrictResponseModel.dart';
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

  // ✅ yahan ID bhejo
  "bankName": selectedBank.value!.id,

  "branch": branchController.text.trim(),

  // ✅ yahan bhi ID
  "district": selectedDistrict.value!.id,

  "accountName": accountNameController.text.trim(),
  "accountNumber": accountNumberController.text.trim(),
};


    final response = await _repo.addNewBankAccount(params);

    isLoading.value = false;

    if (response.status == "success") {
      /// 🔥 IMPORTANT PART
      /// withdraw controller se fresh list lao
      final withdrawController = Get.find<WithdrawAccountController>();
      await withdrawController.fetchAccounts();

      Get.back();
      Get.snackbar("Success", "Bank account added successfully");
    } else {
      Get.snackbar("Error", response.message ?? "Failed to add account");
    }
  }
}

