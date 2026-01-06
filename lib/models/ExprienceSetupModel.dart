import 'package:flutter/material.dart';

class ExperienceSetupModel {
  TextEditingController hospitalName;
  TextEditingController designationController;
  TextEditingController departmentController;
  TextEditingController startDateController;
  TextEditingController endDateController;
  bool iStillWorkHere;

  ExperienceSetupModel({
    required this.hospitalName,
    required this.designationController,
    required this.departmentController,
    required this.startDateController,
    required this.endDateController,
    required this.iStillWorkHere,
  });

  /// 🔴 API body banane ke liye
  Map<String, dynamic> toJson() {
    return {
      "hospitalName": hospitalName.text,
      "designation": designationController.text,
      "department": departmentController.text,
      "startDate": startDateController.text,
      "endDate": iStillWorkHere ? null : endDateController.text,
      "iStillWorkHere": iStillWorkHere,
    };
  }
}
