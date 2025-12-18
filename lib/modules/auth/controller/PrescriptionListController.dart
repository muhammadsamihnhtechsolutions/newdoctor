// import 'package:beh_doctor/models/AppoinmentDetailModel.dart';
// import 'package:beh_doctor/repo/AuthRepo.dart';
// import 'package:get/get.dart';


// class PrescriptionController extends GetxController {
//   final PrescriptionRepo _repo = PrescriptionRepo();

//   // 🔹 Observables
//   var prescriptionList = <Prescription>[].obs;
//   var isLoading = false.obs;
//   var errorMessage = ''.obs;
//   var toastMessage = ''.obs;

//   // 🔹 Reset state (like cubit reset)
//   void resetState() {
//     prescriptionList.clear();
//     isLoading.value = false;
//     errorMessage.value = '';
//     toastMessage.value = '';
//   }

//   // 🔹 Fetch prescription list by patient ID
//   Future<void> fetchPrescriptions(String patientId) async {
//     try {
//       isLoading.value = true;
//       errorMessage.value = '';
//       toastMessage.value = '';

//       final response = await _repo.getPrescriptionList(patientId);

//       if (response.status == 'success') {
//         prescriptionList.value = response.prescriptionListData?.prescriptionList ?? [];
//         toastMessage.value = response.message ?? '';
//       } else {
//         prescriptionList.clear();
//         errorMessage.value = response.message ?? "Something went wrong";
//       }
//     } catch (e) {
//       errorMessage.value = "An error occurred";
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

import 'package:beh_doctor/models/AppoinmentDetailModel.dart';
import 'package:beh_doctor/repo/AuthRepo.dart';
import 'package:get/get.dart';

class PrescriptionController extends GetxController {
  final PrescriptionRepo _repo = PrescriptionRepo();

  // 🔹 Observables
  var prescriptions = <Prescription>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var toastMessage = ''.obs;

  // 🔹 Reset state
  void resetState() {
    prescriptions.clear();
    isLoading.value = false;
    errorMessage.value = '';
    toastMessage.value = '';
  }

  // 🔹 Fetch prescription list by patient ID
  Future<void> fetchPrescriptions(String patientId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      toastMessage.value = '';

      final response = await _repo.getPrescriptionList(patientId);

      if (response.status == 'success') {
        // ✅ Proper mapping: response.data.docs
   prescriptions.value = response.prescriptionListData?.prescriptionList ?? [];


      } else {
        prescriptions.clear();
        errorMessage.value = response.message ?? "Something went wrong";
      }
    } catch (e) {
      prescriptions.clear();
      errorMessage.value = "An error occurred: $e";
    } finally {
      isLoading.value = false;
    }
  }
}
