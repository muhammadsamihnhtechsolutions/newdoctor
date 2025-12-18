// controller/appointment_details_controller.dart
// import 'package:beh_doctor/models/AppoinmentDetailModel.dart';
// import 'package:beh_doctor/repo/AuthRepo.dart';
// import 'package:beh_doctor/views/AgoraDoctorCallScreen.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';


// class AppointmentDetailsController extends GetxController {
//   final AppointmentRepo repo;

//   AppointmentDetailsController(Set<Object> set, {required this.repo});

//   var isLoading = false.obs;
//   var appointmentDetails = Rxn<AppointmentDetailsResponseModel>();

//   /// Fetch appointment details by ID
//   Future<void> fetchAppointmentDetails(String appointmentId) async {
//     try {
      
//       isLoading.value = true;
//       final data = await repo.getDoctorAppointmentDetails(appointmentId);
  

//       // 🔹 Print the full response in terminal for debugging
//       print("✅ Fetched Appointment Details: ${data.toJson()}");
      

//       appointmentDetails.value = data;
//     } catch (e) {
//       print("❌ Error fetching appointment details: $e");
//       appointmentDetails.value = AppointmentDetailsResponseModel(
//         status: 'error',
//         message: 'An error occurred',
//         appointmentDetailsData: null,
        
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }
 

// }

// 
import 'package:beh_doctor/models/AppoinmentDetailModel.dart';
import 'package:beh_doctor/repo/AuthRepo.dart';
import 'package:get/get.dart';


class AppointmentDetailsController extends GetxController {
  final AppointmentRepo _repo = AppointmentRepo();

  // ------------------------------
  // 🔵 REACTIVE VARIABLES
  // ------------------------------
  RxList<TestResult> clinicalTests = <TestResult>[].obs;
  Rx<AppTestData?> appTestData = Rx<AppTestData?>(null);

  RxBool isLoading = false.obs;

  // ------------------------------
  // 🔥 FETCH APPOINTMENT DETAILS
  // ------------------------------
  Future<void> fetchAppointmentDetails(String id) async {

    try {
      isLoading.value = true;
      
      print("📡 API Call → fetchAppointmentDetails($id)");

      final response = await _repo.getDoctorAppointmentDetails(id);

      print("📥 Status: ${response.status}");
      print("📩 Message: ${response.message}");

      if (response.appointmentDetailsData == null) {
        print("❌ appointmentDetailsData == NULL");
        return;
      }

      final data = response.appointmentDetailsData!;
      final eyeTest = data.eyeTest;

      print("🧿 EyeTest Loaded: clinical=${eyeTest.clinicalList.length}, app=${eyeTest.appTest != null}");

      // -----------------------------------------------
      // CLINICAL LIST
      // -----------------------------------------------
      clinicalTests.value = eyeTest.clinicalList;

      print("\n=====================");
      print("🧪 CLINICAL TEST LIST");
      print("=====================");

      for (var i = 0; i < clinicalTests.length; i++) {
        print("▶ Clinical #$i → ${clinicalTests[i].toJson()}");
      }

      // -----------------------------------------------
      // APP TEST DATA
      // -----------------------------------------------
      appTestData.value = eyeTest.appTest;

      print("\n=====================");
      print("📊 APP TEST DATA");
      print("=====================");

      if (appTestData.value == null) {
        print("⚠️ AppTest NULL hai");
        return;
      }

      final app = appTestData.value!;
      print("🆔 ID: ${app.id}");
      print("👤 Patient: ${app.patient}");
      print("🕒 CreatedAt: ${app.createdAt}");
      print("📌 Status: ${app.status}");
      print("🔖 Type: ${app.type}");

      // APP DATA → nested vision parameters
      final appData = app.data;

      if (appData == null) {
        print("❌ app.data == NULL");
        return;
      }

      print("\n----- 👁 VISUAL ACUITY -----");
      print(appData.visualAcuity?.toJson());

      print("\n----- 🎨 COLOR VISION -----");
      print(appData.colorVision?.toJson());

      print("\n----- 📏 NEAR VISION -----");
      print(appData.nearVision?.toJson());

      print("\n----- 🌫 AMD VISION -----");
      print(appData.amdVision?.toJson());

    } catch (e) {
      print("❌ ERROR (fetchAppointmentDetails): $e");
    } finally {
      isLoading.value = false;
    }
  }
}
