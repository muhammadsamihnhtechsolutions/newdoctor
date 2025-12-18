// import 'dart:convert';
// import 'package:beh_doctor/models/AppoinmentDetailModel.dart' show TestResult;
// import 'package:beh_doctor/repo/AuthRepo.dart';
// import 'package:get/get.dart';


// class TestResultController extends GetxController {

//   RxBool isLoading = false.obs;

//   /// --- Test Result Docs List ---
//   RxList<TestResult> testResults = <TestResult>[].obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchTestResults();
//   }

//   Future<void> fetchTestResults() async {
//     try {
//       isLoading.value = true;

//       /// ---- API CALL ----
//       final res = await TestResultRepo().getTestResultData();

//       /// ---- Save Docs ----
//       testResults.value = res.testResultResponseData?.docs ?? [];

//     } catch (e) {
//       print("⚠️ Error fetching test results: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   /// Parse left/right from attachment JSON
//   Map<String, dynamic> parseAttachment(String? att) {
//     if (att == null || att.isEmpty) {
//       return {"left": "--", "right": "--"};
//     }

//     try {
//       final data = json.decode(att);

//       return {
//         "left": data["left"] ?? data["od"] ?? "--",
//         "right": data["right"] ?? data["os"] ?? "--",
//       };
//     } catch (_) {
//       return {"left": att, "right": "--"};
//     }
//   }
// }
