
import 'package:beh_doctor/models/WithdrawAccountListResponse.dart';
import 'package:beh_doctor/repo/AuthRepo.dart';
import 'package:get/get.dart';

class WithdrawAccountController extends GetxController {
  final WithdrawAccountRepo repo = WithdrawAccountRepo();

  RxBool isLoading = false.obs;

  /// 0 = Bank, 1 = MFS
  RxInt selectedTab = 0.obs;

  RxList<WithdrawAccount> bankAccounts = <WithdrawAccount>[].obs;
  RxList<WithdrawAccount> mfsAccounts = <WithdrawAccount>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAccounts();
  }

  // ---------------- TAB CHANGE ----------------
  void changeTab(int index) {
    selectedTab.value = index;
    print("🔄 Tab Changed to: ${index == 0 ? "BANK" : "MFS"}");
  }

  // ---------------- FETCH ACCOUNT LIST ----------------
  Future<void> fetchAccounts() async {
    isLoading.value = true;

    final response = await repo.getWithdrawAccountList();

    print("📌 STATUS: ${response.status}");
    print("📌 MESSAGE: ${response.message}");

    if (response.withdrawAccountdata != null) {
      List<WithdrawAccount> all =
          response.withdrawAccountdata!.withdrawAccountList;

      bankAccounts.assignAll(all.where((e) => e.accountType == "bank"));
      mfsAccounts.assignAll(all.where((e) => e.accountType == "mfs"));

      print("🏦 TOTAL BANK ACCOUNTS: ${bankAccounts.length}");
      print("📲 TOTAL MFS ACCOUNTS: ${mfsAccounts.length}");
    }

    isLoading.value = false;
  }
}
