// import 'package:beh_doctor/models/AppoinmentDetailModel.dart';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:beh_doctor/models/AppointmentModel.dart';
// import 'package:beh_doctor/repo/AuthRepo.dart';

// class AppointmentController extends GetxController {
//   AppointmentController({this.autoFetchOnInit = true});

//   final bool autoFetchOnInit;
//   final AppointmentRepo _repo = AppointmentRepo();

//   var isLoading = false.obs;

//   Timer? _autoRefreshTimer;

//   // 🔥 Updated: Two separate lists
//   var upcomingAppointments = <Appointment>[].obs;
//   var pastAppointments = <Appointment>[].obs;
//   var clinicalTests = <TestResult>[].obs; // clinical list
//   var appTestData = Rxn<AppTestData>();
//   // RxList<String> eyeTests = <String>[].obs;

//   var errorMessage = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     if (autoFetchOnInit) {
//       fetchAppointments();
//     }
//   }

//   @override
//   void onClose() {
//     _autoRefreshTimer?.cancel();
//     super.onClose();
//   }

//   void _startAutoRefresh() {
//     _autoRefreshTimer?.cancel();
//     _autoRefreshTimer = Timer.periodic(const Duration(seconds: 15), (_) {
//       if (isLoading.value) return;
//       fetchAppointments();
//     });
//   }

//   // 🔥 Single API call → but split into two lists
//   Future<void> fetchAppointments() async {
//     try {
//       isLoading.value = true;
//       errorMessage.value = "";

//       final response = await _repo.getAppointmentList();

//       if (response.status == "success" && response.data != null) {
//         // 🔥 Extract all appointments and split into upcoming and past
//         List<Appointment> allAppointments = response.data!.docs ?? [];
//         print("========= 📌 FULL APPOINTMENT API LOGS START =========");

//         for (var apt in allAppointments) {
//           print("--------------------------------------------------");
//           print("👤 Patient: ${apt.patient?.name}");
//           print("📞 Phone: ${apt.patient?.phone}");
//           print("👨‍⚕️ Doctor: ${apt.doctor?.name}");

//           print("🕒 Appointment Date: ${apt.appointmentDate}");
//           print("📅 Raw Date String: ${apt.date}");
//           print("📌 Status: ${apt.status}");
//           // print("test result: ${apt.}");

//           print("💳 Payment ID: ${apt.paymentId}");
//           print("💰 Method: ${apt.paymentMethod}");
//           print("💸 Total Amount: ${apt.totalAmount}");
//           print("🏷️ VAT: ${apt.vat}");
//           print("🏷️ Discount: ${apt.discount}");
//           print("💵 Grand Total: ${apt.grandTotal}");
//           print("appointment id: ${apt.id}");

//           print("📁 Eye Photos: ${apt.eyePhotos}");
//           print("📁 Additional Files: ${apt.additionalFiles}");

//           print("📡 Agora Doctor Token: ${apt.doctorAgoraToken}");
//           print("📡 Agora Patient Token: ${apt.patientAgoraToken}");
//           print(appTestData);

//           print("--------------------------------------------------");
//         }

//         print("========= 📌 FULL APPOINTMENT API LOGS END =========");

//         for (var apt in upcomingAppointments) {
//           print("Upcoming: ${apt.patient?.name}, ${apt.appointmentDate}");
//         }
//         for (var apt in pastAppointments) {
//           print("Past: ${apt.patient?.name}, ${apt.appointmentDate}");
//         }
        
//         final now = DateTime.now();
// final tenHoursAgo = now.subtract(const Duration(hours: 10));

// upcomingAppointments.value = allAppointments.where((apt) {
//   final aptDateTime = apt.appointmentDate!.toLocal();

//   // upcoming = now se 10 ghantay se purani NA ho
//   return aptDateTime.isAfter(tenHoursAgo);
// }).toList();

// pastAppointments.value = allAppointments.where((apt) {
//   final aptDateTime = apt.appointmentDate!.toLocal();

//   // past = now se 10 ghantay se purani ho
//   return aptDateTime.isBefore(tenHoursAgo);
// }).toList();

// // 24ghntynew
// // final now = DateTime.now();
// // final today = DateTime(now.year, now.month, now.day);
// // upcomingAppointments.value = allAppointments.where((apt) {
// //   final aptDateTime = apt.appointmentDate!.toLocal();
// //   final aptDate =
// //       DateTime(aptDateTime.year, aptDateTime.month, aptDateTime.day);

// //   // today OR future
// //   return !aptDate.isBefore(today);
// // }).toList();

// // pastAppointments.value = allAppointments.where((apt) {
// //   final aptDateTime = apt.appointmentDate!.toLocal();
// //   final aptDate =
// //       DateTime(aptDateTime.year, aptDateTime.month, aptDateTime.day);

// //   // strictly before today
// //   return aptDate.isBefore(today);
// // }).toList();
// // 24purana
//         // final today = DateTime.now();

//         // upcomingAppointments.value = allAppointments.where((apt) {
//         //   final aptDate = apt.appointmentDate!
//         //       .toLocal(); // server se aaya UTC, convert to local
//         //   // Check if appointment is today or in future
//         //   return aptDate.isAfter(today) ||
//         //       (aptDate.year == today.year &&
//         //           aptDate.month == today.month &&
//         //           aptDate.day == today.day);
//         // }).toList();

//         // pastAppointments.value = allAppointments.where((apt) {
//         //   final aptDate = apt.appointmentDate!.toLocal();
//         //   // Past appointments: strictly before today
//         //   return aptDate.isBefore(today) &&
//         //       !(aptDate.year == today.year &&
//         //           aptDate.month == today.month &&
//         //           aptDate.day == today.day);
//         // }).toList();

//         // 🔹 Debug prints

//         print("Upcoming Appointments:");
//         for (var apt in upcomingAppointments) {
//           print("  ${apt.patient?.name}, ${apt.appointmentDate}");
//         }

//         print("Past Appointments:");
//         for (var apt in pastAppointments) {
//           print("  ${apt.patient?.name}, ${apt.appointmentDate}");
//         }
//       } else {
//         errorMessage.value = response.message ?? "Something went wrong";
//       }
//     } catch (e) {
//       errorMessage.value = "An error occurred";
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   var selectedTab = 0.obs;
//   PageController pageController = PageController();

//   void changeTab(int index) {
//     selectedTab.value = index;
//     pageController.jumpToPage(index);
//   }
// }


import 'package:beh_doctor/models/AppoinmentDetailModel.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beh_doctor/models/AppointmentModel.dart';
import 'package:beh_doctor/repo/AuthRepo.dart';

class AppointmentController extends GetxController {
  AppointmentController({this.autoFetchOnInit = true});

  final bool autoFetchOnInit;
  final AppointmentRepo _repo = AppointmentRepo();

  var isLoading = false.obs;

  Timer? _autoRefreshTimer;

  // 🔥 Two separate lists
  var upcomingAppointments = <Appointment>[].obs;
  var pastAppointments = <Appointment>[].obs;

  var clinicalTests = <TestResult>[].obs;
  var appTestData = Rxn<AppTestData>();

  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    if (autoFetchOnInit) {
      fetchAppointments();
    }
  }

  @override
  void onClose() {
    _autoRefreshTimer?.cancel();
    super.onClose();
  }

  void _startAutoRefresh() {
    _autoRefreshTimer?.cancel();
    _autoRefreshTimer = Timer.periodic(const Duration(seconds: 15), (_) {
      if (isLoading.value) return;
      fetchAppointments();
    });
  }

  // 🔥 Single API call → split using isPrescribed ONLY
  Future<void> fetchAppointments() async {
    try {
      isLoading.value = true;
      errorMessage.value = "";

      final response = await _repo.getAppointmentList();

      if (response.status == "success" && response.data != null) {
        List<Appointment> allAppointments = response.data!.docs ?? [];

        print("========= 📌 FULL APPOINTMENT API LOGS START =========");

        for (var apt in allAppointments) {
          print("--------------------------------------------------");
          print("👤 Patient: ${apt.patient?.name}");
          print("📞 Phone: ${apt.patient?.phone}");
          print("👨‍⚕️ Doctor: ${apt.doctor?.name}");
          print("📅 Appointment Date: ${apt.appointmentDate}");
          print("📌 Status: ${apt.status}");
          print("🧾 isPrescribed: ${apt.isPrescribed}");
          print("🆔 Appointment ID: ${apt.id}");
          print("--------------------------------------------------");
        }

        print("========= 📌 FULL APPOINTMENT API LOGS END =========");

        // ✅ FINAL FIXED LOGIC (AS PER YOUR REQUIREMENT)

        upcomingAppointments.value = allAppointments.where((apt) {
          // Upcoming = prescription NOT submitted
          return apt.isPrescribed != true;
        }).toList();

        pastAppointments.value = allAppointments.where((apt) {
          // Past = prescription submitted
          return apt.isPrescribed == true;
        }).toList();

        // 🔹 Debug
        print("Upcoming Appointments:");
        for (var apt in upcomingAppointments) {
          print("  ${apt.patient?.name} | Prescribed: ${apt.isPrescribed}");
        }

        print("Past Appointments:");
        for (var apt in pastAppointments) {
          print("  ${apt.patient?.name} | Prescribed: ${apt.isPrescribed}");
        }
      } else {
        errorMessage.value = response.message ?? "Something went wrong";
      }
    } catch (e) {
      errorMessage.value = "An error occurred";
    } finally {
      isLoading.value = false;
    }
  }

  var selectedTab = 0.obs;
  PageController pageController = PageController();

  void changeTab(int index) {
    selectedTab.value = index;
    pageController.jumpToPage(index);
  }
}
