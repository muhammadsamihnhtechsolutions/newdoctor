
import 'package:get/get.dart';

import 'package:beh_doctor/models/BankListResponse.dart';
import 'package:beh_doctor/models/DistrictResponseModel.dart';
import 'package:beh_doctor/models/WithdrawAccountListResponse.dart';
import 'package:beh_doctor/repo/AuthRepo.dart';

class WithdrawAccountController extends GetxController {
  final WithdrawAccountRepo repo = WithdrawAccountRepo();

  RxBool isLoading = false.obs;

  /// 0 = Bank, 1 = MFS
  RxInt selectedTab = 0.obs;

  RxList<WithdrawAccount> bankAccounts = <WithdrawAccount>[].obs;
  RxList<WithdrawAccount> mfsAccounts = <WithdrawAccount>[].obs;

  /// 🔥 LOCAL CACHE (for mapping)
  List<BankModel> bankList = [];
  List<BankModel> mfsList = [];
  List<District> districtList = [];

  @override
  void onInit() {
    super.onInit();
    fetchReferenceData();
  }

  // ---------------- LOAD BANK + MFS + DISTRICT ----------------
  Future<void> fetchReferenceData() async {
  try {
    final bankRes = await repo.getBankAndMfsListResponse({"type": "bank"});
    final allRes = await repo.getBankAndMfsListResponse({});
    final distRes = await repo.districtListResponse();

    if (bankRes.bankList != null) {
      bankList = bankRes.bankList!;
    }

    if (allRes.bankList != null) {
      mfsList = allRes.bankList!
          .where((e) => e.type == "mfs")
          .toList();
    }

    if (distRes.districtList != null) {
      districtList = distRes.districtList!;
    }
  } catch (_) {
    // intentionally ignored
  } finally {
    fetchAccounts(); // ✅ analyzer happy
  }
}

  // Future<void> fetchReferenceData() async {
  //   try {
  //     final bankRes = await repo.getBankAndMfsListResponse({"type": "bank"});
  //     final allRes = await repo.getBankAndMfsListResponse({});
  //     final distRes = await repo.districtListResponse();

  //     if (bankRes.bankList != null) {
  //       bankList = bankRes.bankList!;
  //     }

  //     if (allRes.bankList != null) {
  //       mfsList = allRes.bankList!.where((e) => e.type == "mfs").toList();
  //     }

  //     if (distRes.districtList != null) {
  //       districtList = distRes.districtList!;
  //     }
  //   } catch (_) {}

  //   fetchAccounts();
  // }

  // ---------------- FETCH ACCOUNT LIST ----------------
  Future<void> fetchAccounts() async {
    isLoading.value = true;

    final response = await repo.getWithdrawAccountList();

    if (response.withdrawAccountdata != null) {
      final all = response.withdrawAccountdata!.withdrawAccountList;

      bankAccounts.assignAll(all.where((e) => e.accountType == "bank"));
      mfsAccounts.assignAll(all.where((e) => e.accountType == "mfs"));

      // -------- BANK ACCOUNTS --------
      for (var acc in bankAccounts) {
        final bank = bankList.firstWhereOrNull(
          (b) => b.id == acc.bankName,
        );
        if (bank != null) {
          acc.bankName = bank.title ?? acc.bankName;
        }

        final district = districtList.firstWhereOrNull(
          (d) => d.id == acc.district,
        );
        if (district != null) {
          acc.district = district.name ?? acc.district;
        }
      }

      // -------- MFS ACCOUNTS --------
      for (var acc in mfsAccounts) {
        final mfs = mfsList.firstWhereOrNull(
          (m) => m.id == acc.bankName,
        );
        if (mfs != null) {
          acc.bankName = mfs.title ?? acc.bankName;
        }
      }
    }

    isLoading.value = false;
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }
  Future<void> deleteAccount(String accountId) async {
  isLoading.value = true;

  final response = await repo.deletePayoutAccount(accountId);

  if (response.status == "success") {
    await fetchAccounts(); // 🔥 list refresh
    Get.snackbar("Success", response.message ?? "Account deleted");
  } else {
    Get.snackbar("Error", response.message ?? "Failed to delete account");
  }

  isLoading.value = false;
}

}
