import 'dart:convert';
import 'package:get/get.dart';
import 'package:beh_doctor/models/TransectionModel.dart'; // apna model
import 'package:beh_doctor/repo/AuthRepo.dart'; // repo import
import 'package:shared_preferences/shared_preferences.dart';

class TransactionController extends GetxController {
  final TransactionRepo repo = TransactionRepo();

  var isLoading = false.obs;

  // Transactions list
  var transactions = <Transaction>[].obs;

  // Wallet info
  var walletBalance = 0.0.obs;
  var totalEarning = 0.0.obs;

  // Pagination
  var currentPage = 1;
  var totalPages = 1;

  @override
  void onInit() {
    super.onInit();
    loadTransactionsFromPrefs(); // pehle cache load karo
    fetchWalletStatistics(); // phir API call karo
  }

  // Fetch wallet statistics
  Future<void> fetchWalletStatistics() async {
    try {
      isLoading(true);

      final response = await repo.getWalletStatistics();

      if (response.status == 'success' && response.walletStatistics != null) {
        walletBalance.value = response.walletStatistics!.balance ?? 0.0;
        totalEarning.value = response.walletStatistics!.totalEarning ?? 0.0;

        // Agar balance > 0 ho to transactions fetch karo
        if (walletBalance.value > 0) {
          await fetchTransactions();
        }
      } else {
        Get.snackbar('error'.tr, response.message ?? 'something_went_wrong'.tr);
      }
    } finally {
      isLoading(false);
    }
  }

  // Fetch transactions
  Future<void> fetchTransactions({int page = 1}) async {
  final params = {'page': page, 'limit': 20};
  final response = await repo.getTransactionsList(params);

  if (response.status == 'success' && response.transactionsData != null) {
    transactions.value = response.transactionsData!.transactionList ?? [];
    currentPage = response.transactionsData!.page ?? 1;
    totalPages = response.transactionsData!.totalPages ?? 1;

    saveTransactionsToPrefs(transactions);
  } else {
    Get.snackbar('error'.tr, response.message ?? 'something_went_wrong'.tr);
  }
}

  // Save transactions to SharedPreferences
  Future<void> saveTransactionsToPrefs(List<Transaction> list) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> jsonList = list.map((t) => jsonEncode(t.toJson())).toList();
    await prefs.setStringList('transactions', jsonList);
  }

  // Load transactions from SharedPreferences
  Future<void> loadTransactionsFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList('transactions') ?? [];
    transactions.value = jsonList
        .map((e) => Transaction.fromJson(jsonDecode(e)))
        .toList();
  }
}
