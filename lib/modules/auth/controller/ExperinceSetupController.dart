import 'dart:developer';
import 'package:beh_doctor/models/ExprienceSetupModel.dart';
import 'package:beh_doctor/repo/AuthRepo.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ExperienceSetupController extends GetxController {
  final ExperienceRepo _repo = ExperienceRepo();

  /// same as Bloc experienceList
  RxList<ExperienceSetupModel> experienceList =
      <ExperienceSetupModel>[].obs;

  // ================= ADD =================

  void addExperience() {
    experienceList.add(
      ExperienceSetupModel(
        hospitalName: TextEditingController(),
        designationController: TextEditingController(),
        departmentController: TextEditingController(),
        startDateController: TextEditingController(),
        endDateController: TextEditingController(),
        iStillWorkHere: false,
      ),
    );
  }

  void addExperienceWithUserData({
    required String hospitalName,
    required String designation,
    required String department,
    required String startDate,
    required String endDate,
    required bool stillWorkingHere,
  }) {
    experienceList.add(
      ExperienceSetupModel(
        hospitalName: TextEditingController(text: hospitalName),
        designationController: TextEditingController(text: designation),
        departmentController: TextEditingController(text: department),
        startDateController: TextEditingController(text: startDate),
        endDateController: TextEditingController(text: endDate),
        iStillWorkHere: stillWorkingHere,
      ),
    );
  }

  // ================= UPDATE =================

  void toggleStillWorking(int index, bool value) {
    experienceList[index].iStillWorkHere = value;
    experienceList.refresh(); // IMPORTANT
  }

  void removeExperience(int index) {
    experienceList.removeAt(index);
  }

  // ================= VALIDATION =================

  bool _validate() {
    for (final e in experienceList) {
      if (e.hospitalName.text.trim().isEmpty) {
        Get.snackbar("Error", "Hospital name is required");
        return false;
      }
      if (e.designationController.text.trim().isEmpty) {
        Get.snackbar("Error", "Designation is required");
        return false;
      }
      if (e.startDateController.text.trim().isEmpty) {
        Get.snackbar("Error", "Start date is required");
        return false;
      }
    }
    return true;
  }

  // ================= SUBMIT =================

  Future<void> submitExperience() async {
    if (!_validate()) return;
final body = {
  "records": experienceList.map((e) {
    return {
      "hospitalName": e.hospitalName.text.trim(),
      "designation": e.designationController.text.trim(),
      "department": e.departmentController.text.trim(),
      "startDate": e.startDateController.text.trim(),
      "endDate":
          e.iStillWorkHere ? null : e.endDateController.text.trim(),
      "currentlyWorkingHere": e.iStillWorkHere, // ✅ FIX
    };
  }).toList(),
};


    log("📦 API BODY => $body");

    final response = await _repo.uploadDoctorExperienceData(body);

    if (response.status == "success") {
      Get.snackbar("Success", response.message ?? "Experience updated");
    } else {
      Get.snackbar("Error", response.message ?? "Failed");
    }
  }
}
