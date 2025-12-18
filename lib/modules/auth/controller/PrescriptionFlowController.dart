// import 'package:get/get.dart';

// class PrescriptionFlowController extends GetxController {
//   // ---------------- STEP ----------------
//   RxInt step = 1.obs;
//   final int maxStep = 3;

//   // ---------------- DATA ----------------
//   RxList<String> chiefComplaints = <String>[].obs;
//   RxList<String> diagnosisList = <String>[].obs;
//   RxList<String> investigationList = <String>[].obs;
//   RxList<String> surgeryList = <String>[].obs;

//   // ---------------- ADD ----------------
//   void addChiefComplaint(String value) {
//     final v = value.trim();
//     if (v.isEmpty) return;
//     if (!chiefComplaints.contains(v)) {
//       chiefComplaints.add(v);
//     }
//   }

//   void addDiagnosis(String value) {
//     final v = value.trim();
//     if (v.isEmpty) return;
//     if (!diagnosisList.contains(v)) {
//       diagnosisList.add(v);
//     }
//   }

//   void addInvestigation(String value) {
//     final v = value.trim();
//     if (v.isEmpty) return;
//     if (!investigationList.contains(v)) {
//       investigationList.add(v);
//     }
//   }

//   void addSurgery(String value) {
//     final v = value.trim();
//     if (v.isEmpty) return;
//     if (!surgeryList.contains(v)) {
//       surgeryList.add(v);
//     }
//   }

//   // ---------------- REMOVE ----------------
//   void removeChiefComplaint(int index) {
//     if (index < chiefComplaints.length) {
//       chiefComplaints.removeAt(index);
//     }
//   }

//   void removeDiagnosis(int index) {
//     if (index < diagnosisList.length) {
//       diagnosisList.removeAt(index);
//     }
//   }

//   void removeInvestigation(int index) {
//     if (index < investigationList.length) {
//       investigationList.removeAt(index);
//     }
//   }

//   void removeSurgery(int index) {
//     if (index < surgeryList.length) {
//       surgeryList.removeAt(index);
//     }
//   }

//   // ---------------- VALIDATION ----------------
//   bool get isStepOneValid {
//     return chiefComplaints.isNotEmpty &&
//         diagnosisList.isNotEmpty &&
//         investigationList.isNotEmpty &&
//         surgeryList.isNotEmpty;
//   }

//   // ---------------- STEP CONTROL ----------------
//   void nextStep() {
//     if (step.value < maxStep) {
//       step.value++;
//     }
//   }

//   void previousStep() {
//     if (step.value > 1) {
//       step.value--;
//     }
//   }

//   // ---------------- RESET ----------------
//   void resetFlow() {
//     step.value = 1;
//     chiefComplaints.clear();
//     diagnosisList.clear();
//     investigationList.clear();
//     surgeryList.clear();
//   }
// }

//

import 'package:get/get.dart';

class PrescriptionFlowController extends GetxController {
  // ---------------- STEP ----------------
  RxInt step = 1.obs;
  final int maxStep = 3;

  // ---------------- DATA ----------------
  RxList<String> chiefComplaints = <String>[].obs;
  RxList<String> diagnosisList = <String>[].obs;
  RxList<String> investigationList = <String>[].obs;
  RxList<String> surgeryList = <String>[].obs;

  // ---------------- MEDICINES ----------------
  RxList<Map<String, String>> medicines = <Map<String, String>>[].obs;

  // ---------------- REQUIRED FIELDS ----------------
  RxString followUpDate = "".obs;
  RxString referredTo = "".obs;

  // ---------------- ADD ----------------
  void addChiefComplaint(String v) {
    v = v.trim();
    if (v.isNotEmpty && !chiefComplaints.contains(v)) {
      chiefComplaints.add(v);
    }
  }

  void addDiagnosis(String v) {
    v = v.trim();
    if (v.isNotEmpty && !diagnosisList.contains(v)) {
      diagnosisList.add(v);
    }
  }

  void addInvestigation(String v) {
    v = v.trim();
    if (v.isNotEmpty && !investigationList.contains(v)) {
      investigationList.add(v);
    }
  }

  void addSurgery(String v) {
    v = v.trim();
    if (v.isNotEmpty && !surgeryList.contains(v)) {
      surgeryList.add(v);
    }
  }

  // ---------------- MEDICINE ----------------
  void addMedicine(String name) {
    final v = name.trim();
    if (v.isEmpty) return;

    final exists = medicines.any(
      (m) => m["name"]?.toLowerCase() == v.toLowerCase(),
    );
    if (exists) return;

    medicines.add({"name": v, "note": ""});
  }

  void addEmptyMedicine() {
    medicines.add({"name": "", "note": ""});
  }

  void updateMedicineNote(int index, String note) {
    if (index >= medicines.length) return;
    medicines[index] = {
      "name": medicines[index]["name"] ?? "",
      "note": note.trim(),
    };
  }

  void removeMedicine(int index) {
    if (index < medicines.length) medicines.removeAt(index);
  }

  // ---------------- VALIDATION ----------------
  bool get isStepOneValid =>
      chiefComplaints.isNotEmpty &&
      diagnosisList.isNotEmpty &&
      investigationList.isNotEmpty &&
      surgeryList.isNotEmpty;

  bool get hasMedicines => medicines.isNotEmpty;

  bool get isFollowUpDateValid =>
      followUpDate.value.isEmpty ||
      RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(followUpDate.value);

  // ---------------- STEP CONTROL ----------------
  void nextStep() {
    if (step.value < maxStep) step.value++;
  }

  void previousStep() {
    if (step.value > 1) step.value--;
  }

  // ---------------- PAYLOAD (SAFE FOR API) ----------------
  Map<String, dynamic> buildPayload(String appointmentId) {
    return {
      "id": appointmentId,
      "note": chiefComplaints.join(" | "),
      "diagnosis": diagnosisList.isNotEmpty ? [diagnosisList.first] : [],
      "investigations": investigationList.isNotEmpty
          ? [investigationList.first]
          : [],
      "surgery": surgeryList.isNotEmpty ? [surgeryList.first] : [],
      "medicines": medicines.map((m) {
        return {
          "name": m["name"] ?? "",
          "note": (m["note"] == null || m["note"]!.isEmpty)
              ? "Take as advised"
              : m["note"]!.trim(),
        };
      }).toList(),
      "followUpDate": isFollowUpDateValid ? followUpDate.value : "",
      "referredTo": referredTo.value.trim(),
    };
  }

  // ---------------- RESET ----------------
  void resetFlow() {
    step.value = 1;
    chiefComplaints.clear();
    diagnosisList.clear();
    investigationList.clear();
    surgeryList.clear();
    medicines.clear();
    followUpDate.value = "";
    referredTo.value = "";
  }
}
