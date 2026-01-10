

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
