
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

//   // ---------------- MEDICINES ----------------
//   RxList<Map<String, String>> medicines = <Map<String, String>>[].obs;

//   // ---------------- REQUIRED FIELDS ----------------
//   RxString followUpDate = "".obs;
//   RxString referredTo = "".obs;

//   // ---------------- ADD ----------------
//   void addChiefComplaint(String v) {
//     try {
//       print("🟡 addChiefComplaint: $v");
//       v = v.trim();
//       if (v.isNotEmpty && !chiefComplaints.contains(v)) {
//         chiefComplaints.add(v);
//       }
//       print("✅ chiefComplaints: $chiefComplaints");
//     } catch (e) {
//       print("❌ addChiefComplaint error: $e");
//     }
//   }

//   void addDiagnosis(String v) {
//     try {
//       print("🟡 addDiagnosis: $v");
//       v = v.trim();
//       if (v.isNotEmpty && !diagnosisList.contains(v)) {
//         diagnosisList.add(v);
//       }
//       print("✅ diagnosisList: $diagnosisList");
//     } catch (e) {
//       print("❌ addDiagnosis error: $e");
//     }
//   }

//   void addInvestigation(String v) {
//     try {
//       print("🟡 addInvestigation: $v");
//       v = v.trim();
//       if (v.isNotEmpty && !investigationList.contains(v)) {
//         investigationList.add(v);
//       }
//       print("✅ investigationList: $investigationList");
//     } catch (e) {
//       print("❌ addInvestigation error: $e");
//     }
//   }

//   void addSurgery(String v) {
//     try {
//       print("🟡 addSurgery: $v");
//       v = v.trim();
//       if (v.isNotEmpty && !surgeryList.contains(v)) {
//         surgeryList.add(v);
//       }
//       print("✅ surgeryList: $surgeryList");
//     } catch (e) {
//       print("❌ addSurgery error: $e");
//     }
//   }

//   // ---------------- MEDICINE ----------------
//   void addMedicine(String name) {
//     try {
//       print("🟡 addMedicine: $name");
//       final v = name.trim();
//       if (v.isEmpty) return;

//       final exists = medicines.any(
//         (m) => m["name"]?.toLowerCase() == v.toLowerCase(),
//       );
//       if (exists) return;

//       medicines.add({"name": v, "note": ""});
//       print("✅ medicines: $medicines");
//     } catch (e) {
//       print("❌ addMedicine error: $e");
//     }
//   }

//   void addEmptyMedicine() {
//     try {
//       print("🟡 addEmptyMedicine");
//       medicines.add({"name": "", "note": ""});
//       print("✅ medicines: $medicines");
//     } catch (e) {
//       print("❌ addEmptyMedicine error: $e");
//     }
//   }

//   void updateMedicineNote(int index, String note) {
//     try {
//       print("🟡 updateMedicineNote index=$index note=$note");
//       if (index >= medicines.length) return;

//       medicines[index] = {
//         "name": medicines[index]["name"] ?? "",
//         "note": note.trim(),
//       };
//       print("✅ medicines: $medicines");
//     } catch (e) {
//       print("❌ updateMedicineNote error: $e");
//     }
//   }

//   void removeMedicine(int index) {
//     try {
//       print("🟡 removeMedicine index=$index");
//       if (index < medicines.length) {
//         medicines.removeAt(index);
//       }
//       print("✅ medicines: $medicines");
//     } catch (e) {
//       print("❌ removeMedicine error: $e");
//     }
//   }

//   // ---------------- VALIDATION ----------------
//   bool get isStepOneValid {
//     try {
//       final valid = chiefComplaints.isNotEmpty &&
//           diagnosisList.isNotEmpty &&
//           investigationList.isNotEmpty &&
//           surgeryList.isNotEmpty;
//       print("🔎 isStepOneValid: $valid");
//       return valid;
//     } catch (e) {
//       print("❌ isStepOneValid error: $e");
//       return false;
//     }
//   }

//   bool get hasMedicines {
//     try {
//       final v = medicines.isNotEmpty;
//       print("🔎 hasMedicines: $v");
//       return v;
//     } catch (e) {
//       print("❌ hasMedicines error: $e");
//       return false;
//     }
//   }

//   bool get isFollowUpDateValid {
//     try {
//       final valid = followUpDate.value.isEmpty ||
//           RegExp(r'^\d{4}-\d{2}-\d{2}$')
//               .hasMatch(followUpDate.value);
//       print("🔎 isFollowUpDateValid: $valid (${followUpDate.value})");
//       return valid;
//     } catch (e) {
//       print("❌ isFollowUpDateValid error: $e");
//       return false;
//     }
//   }

//   // ---------------- STEP CONTROL ----------------
//   void nextStep() {
//     try {
//       print("➡️ nextStep from ${step.value}");
//       if (step.value < maxStep) step.value++;
//       print("➡️ step now ${step.value}");
//     } catch (e) {
//       print("❌ nextStep error: $e");
//     }
//   }

//   void previousStep() {
//     try {
//       print("⬅️ previousStep from ${step.value}");
//       if (step.value > 1) step.value--;
//       print("⬅️ step now ${step.value}");
//     } catch (e) {
//       print("❌ previousStep error: $e");
//     }
//   }

//   // ---------------- PAYLOAD ----------------
//   Map<String, dynamic> buildPayload(String appointmentId) {
//     try {
//       print("🟡 buildPayload appointmentId=$appointmentId");

//       final payload = {
//         "id": appointmentId,

//         "note": chiefComplaints.isNotEmpty
//             ? chiefComplaints.first
//             : "",

//         "diagnosis": diagnosisList.isNotEmpty
//             ? [diagnosisList.first]
//             : [],

//         "investigations": investigationList.isNotEmpty
//             ? [investigationList.first]
//             : [],

//         "surgery": surgeryList.isNotEmpty
//             ? [surgeryList.first]
//             : [],

//         "medicines": medicines.map((m) {
//           return {
//             "medicine": m["name"] ?? "",
//             "instruction":
//                 (m["note"] == null || m["note"]!.isEmpty)
//                     ? "Take as advised"
//                     : m["note"]!.trim(),
//           };
//         }).toList(),

//         if (followUpDate.value.isNotEmpty)
//           "followUpDate": followUpDate.value,

//         "referredTo": referredTo.value.trim(),
//       };

//       print("📦 FINAL PAYLOAD: $payload");
//       return payload;
//     } catch (e) {
//       print("❌ buildPayload error: $e");
//       return {};
//     }
//   }

//   // ---------------- RESET ----------------
//   void resetFlow() {
//     try {
//       print("🔄 resetFlow called");
//       step.value = 1;
//       chiefComplaints.clear();
//       diagnosisList.clear();
//       investigationList.clear();
//       surgeryList.clear();
//       medicines.clear();
//       followUpDate.value = "";
//       referredTo.value = "";
//       print("✅ resetFlow completed");
//     } catch (e) {
//       print("❌ resetFlow error: $e");
//     }
//   }
// }


// ///////

// import 'package:get/get.dart';
// import 'package:beh_doctor/models/MedicineTrackerModel.dart';
// import 'package:beh_doctor/repo/AuthRepo.dart';

// class PrescriptionFlowController extends GetxController {
//   // ---------------- STEP ----------------
//   RxInt step = 1.obs;
//   final int maxStep = 3;

//   // ---------------- DATA ----------------
//   RxList<String> chiefComplaints = <String>[].obs;
//   RxList<String> diagnosisList = <String>[].obs;
//   RxList<String> investigationList = <String>[].obs;
//   RxList<String> surgeryList = <String>[].obs;

//   // ---------------- MEDICINES (SELECTED) ----------------
//   RxList<Map<String, String>> medicines = <Map<String, String>>[].obs;

//   // ================= MEDICINE API (ADDED) =================
//   final MedicationRepo _medRepo = MedicationRepo();

//   RxList<Medication> medicineOptions = <Medication>[].obs;
//   RxBool isMedicineLoading = false.obs;

//   // ---------------- REQUIRED FIELDS ----------------
//   RxString followUpDate = "".obs;
//   RxString referredTo = "".obs;

//   // ================= INIT =================
//   @override
//   void onInit() {
//     super.onInit();
//     fetchMedicineNames(); // 👈 MEDICINE API HIT
//   }

//   // ================= FETCH MEDICINES =================
//  Future<void> fetchMedicineNames() async {
//   try {
//     print("🟡 fetchMedicines called");
//     isMedicineLoading.value = true;

//     final res = await _medRepo.getMedicineList();

//     medicineOptions.assignAll(res);

//     print(
//       "✅ medicines fetched: ${medicineOptions.map((e) => e.name).toList()}",
//     );
//   } catch (e) {
//     print("❌ fetchMedicines error: $e");
//   } finally {
//     isMedicineLoading.value = false;
//   }
// }


//   // ================= ADD MEDICINE FROM DROPDOWN =================
//  // ================= ADD MEDICINE FROM DROPDOWN =================
// void addMedicineFromDropdown(Medication med) {
//   try {
//     print("🟡 addMedicineFromDropdown: ${med.name}");

//     final exists = medicines.any(
//       (m) => m["name"]?.toLowerCase() == med.name.toLowerCase(),
//     );

//     if (exists) return;

//     medicines.add({
//       "name": med.name,
//       "note": "",
//     });

//     print("✅ medicines: $medicines");
//   } catch (e) {
//     print("❌ addMedicineFromDropdown error: $e");
//   }
// }


//   // ---------------- ADD (OLD – SAME) ----------------
//   void addChiefComplaint(String v) {
//     v = v.trim();
//     if (v.isNotEmpty && !chiefComplaints.contains(v)) {
//       chiefComplaints.add(v);
//     }
//   }

//   void addDiagnosis(String v) {
//     v = v.trim();
//     if (v.isNotEmpty && !diagnosisList.contains(v)) {
//       diagnosisList.add(v);
//     }
//   }

//   void addInvestigation(String v) {
//     v = v.trim();
//     if (v.isNotEmpty && !investigationList.contains(v)) {
//       investigationList.add(v);
//     }
//   }

//   void addSurgery(String v) {
//     v = v.trim();
//     if (v.isNotEmpty && !surgeryList.contains(v)) {
//       surgeryList.add(v);
//     }
//   }

//   // ---------------- MEDICINE (OLD – SAME) ----------------
//   void addMedicine(String name) {
//     final v = name.trim();
//     if (v.isEmpty) return;

//     final exists = medicines.any(
//       (m) => m["name"]?.toLowerCase() == v.toLowerCase(),
//     );
//     if (exists) return;

//     medicines.add({"name": v, "note": ""});
//   }

//   void addEmptyMedicine() {
//     medicines.add({"name": "", "note": ""});
//   }

//   void updateMedicineNote(int index, String note) {
//     if (index >= medicines.length) return;

//     medicines[index] = {
//       "name": medicines[index]["name"] ?? "",
//       "note": note.trim(),
//     };
//   }

//   void removeMedicine(int index) {
//     if (index < medicines.length) {
//       medicines.removeAt(index);
//     }
//   }

//   // ---------------- PAYLOAD (SAME) ----------------
//   Map<String, dynamic> buildPayload(String appointmentId) {
//     final payload = {
//       "id": appointmentId,
//       "note": chiefComplaints.isNotEmpty ? chiefComplaints.first : "",
//       "diagnosis": diagnosisList.isNotEmpty ? [diagnosisList.first] : [],
//       "investigations":
//           investigationList.isNotEmpty ? [investigationList.first] : [],
//       "surgery": surgeryList.isNotEmpty ? [surgeryList.first] : [],
//       "medicines": medicines.map((m) {
//         return {
//           "medicine": m["name"] ?? "",
//           "instruction":
//               (m["note"] == null || m["note"]!.isEmpty)
//                   ? "Take as advised"
//                   : m["note"]!.trim(),
//         };
//       }).toList(),
//       if (followUpDate.value.isNotEmpty)
//         "followUpDate": followUpDate.value,
//       "referredTo": referredTo.value.trim(),
//     };

//     print("📦 FINAL PAYLOAD: $payload");
//     return payload;
//   }

//   // ---------------- RESET ----------------
//   void resetFlow() {
//     step.value = 1;
//     chiefComplaints.clear();
//     diagnosisList.clear();
//     investigationList.clear();
//     surgeryList.clear();
//     medicines.clear();
//     followUpDate.value = "";
//     referredTo.value = "";
//   }
// }
// 
import 'package:get/get.dart';
import 'package:beh_doctor/models/MedicineTrackerModel.dart';
import 'package:beh_doctor/models/InvestigationModel.dart';
import 'package:beh_doctor/repo/AuthRepo.dart';


class PrescriptionFlowController extends GetxController {
  // ---------------- STEP ----------------
  RxInt step = 1.obs;
  final int maxStep = 3;

  // ---------------- DATA ----------------
  RxList<String> chiefComplaints = <String>[].obs;
  RxList<String> diagnosisList = <String>[].obs;
  RxList<String> investigationList = <String>[].obs;
  RxList<String> surgeryList = <String>[].obs;

  // ---------------- MEDICINES (SELECTED) ----------------
  RxList<Map<String, String>> medicines = <Map<String, String>>[].obs;

  // ================= MEDICINE API (PURANA – SAME) =================
  final MedicationRepo _medRepo = MedicationRepo();
  RxList<Medication> medicineOptions = <Medication>[].obs;
  RxBool isMedicineLoading = false.obs;

  // ================= INVESTIGATION API (NEW – ADDED ONLY) =================
  final InvestigationRepo _investigationRepo = InvestigationRepo();
  RxList<Investigation> investigationOptions = <Investigation>[].obs;
  RxBool isInvestigationLoading = false.obs;

  // ---------------- REQUIRED FIELDS ----------------
  RxString followUpDate = "".obs;
  RxString referredTo = "".obs;

  // ================= INIT =================
  @override
  void onInit() {
    super.onInit();
    fetchMedicineNames();       // ✅ PURANA
    fetchInvestigations();      // ✅ NEW
  }

  // ================= FETCH MEDICINES (PURANA – SAME) =================
  Future<void> fetchMedicineNames() async {
    try {
      print("🟡 fetchMedicineNames called");
      isMedicineLoading.value = true;

      final res = await _medRepo.getMedicineList();
      medicineOptions.assignAll(res);

      print(
        "✅ medicines fetched: ${medicineOptions.map((e) => e.name).toList()}",
      );
    } catch (e) {
      print("❌ fetchMedicineNames error: $e");
    } finally {
      isMedicineLoading.value = false;
    }
  }

  // ================= FETCH INVESTIGATIONS (NEW) =================
  Future<void> fetchInvestigations() async {
    try {
      print("🟡 fetchInvestigations called");
      isInvestigationLoading.value = true;

      final res = await _investigationRepo.getInvestigationList();
      investigationOptions.assignAll(res);

      print(
        "✅ investigations fetched: ${investigationOptions.map((e) => e.name).toList()}",
      );
    } catch (e) {
      print("❌ fetchInvestigations error: $e");
    } finally {
      isInvestigationLoading.value = false;
    }
  }

  // ================= ADD INVESTIGATION FROM DROPDOWN (NEW) =================
  void addInvestigationFromDropdown(Investigation inv) {
    try {
      print("🟡 addInvestigationFromDropdown: ${inv.name}");

      final v = inv.name.trim();
      if (v.isEmpty) return;

      if (!investigationList.contains(v)) {
        investigationList.add(v);
      }

      print("✅ investigationList: $investigationList");
    } catch (e) {
      print("❌ addInvestigationFromDropdown error: $e");
    }
  }

  // ---------------- ADD (PURANA – SAME) ----------------
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

  void addSurgery(String v) {
    v = v.trim();
    if (v.isNotEmpty && !surgeryList.contains(v)) {
      surgeryList.add(v);
    }
  }

  // ---------------- MEDICINE (PURANA – SAME) ----------------
  void addMedicineFromDropdown(Medication med) {
    try {
      print("🟡 addMedicineFromDropdown: ${med.name}");

      final exists = medicines.any(
        (m) => m["name"]?.toLowerCase() == med.name.toLowerCase(),
      );
      if (exists) return;

      medicines.add({
        "name": med.name,
        "note": "",
      });

      print("✅ medicines: $medicines");
    } catch (e) {
      print("❌ addMedicineFromDropdown error: $e");
    }
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
    if (index < medicines.length) {
      medicines.removeAt(index);
    }
  }

  // ---------------- PAYLOAD (PURANA – SAME) ----------------
  Map<String, dynamic> buildPayload(String appointmentId) {
    final payload = {
      "id": appointmentId,
      "note": chiefComplaints.isNotEmpty ? chiefComplaints.first : "",
      "diagnosis": diagnosisList.isNotEmpty ? [diagnosisList.first] : [],
      "investigations":
          investigationList.isNotEmpty ? [investigationList.first] : [],
      "surgery": surgeryList.isNotEmpty ? [surgeryList.first] : [],
      "medicines": medicines.map((m) {
        return {
          "medicine": m["name"] ?? "",
          "instruction":
              (m["note"] == null || m["note"]!.isEmpty)
                  ? "Take as advised"
                  : m["note"]!.trim(),
        };
      }).toList(),
      if (followUpDate.value.isNotEmpty)
        "followUpDate": followUpDate.value,
      "referredTo": referredTo.value.trim(),
    };

    print("📦 FINAL PAYLOAD: $payload");
    return payload;
  }

  // ---------------- RESET (PURANA – SAME) ----------------
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
