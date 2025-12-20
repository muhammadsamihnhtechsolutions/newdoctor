

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

//   // ---------------- MEDICINE ----------------
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
//     if (index < medicines.length) medicines.removeAt(index);
//   }

//   // ---------------- VALIDATION ----------------
//   bool get isStepOneValid =>
//       chiefComplaints.isNotEmpty &&
//       diagnosisList.isNotEmpty &&
//       investigationList.isNotEmpty &&
//       surgeryList.isNotEmpty;

//   bool get hasMedicines => medicines.isNotEmpty;

//   bool get isFollowUpDateValid =>
//       followUpDate.value.isEmpty ||
//       RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(followUpDate.value);

//   // ---------------- STEP CONTROL ----------------
//   void nextStep() {
//     if (step.value < maxStep) step.value++;
//   }

//   void previousStep() {
//     if (step.value > 1) step.value--;
//   }

//   // ---------------- PAYLOAD (FIXED FOR API) ----------------
// // Map<String, dynamic> buildPayload(String appointmentId) {
// //   return {
// //     "appointmentId": appointmentId,
// Map<String, dynamic> buildPayload(String appointmentId) {
//   return {
//     "id": appointmentId, 


//     "note": chiefComplaints.isNotEmpty
//         ? chiefComplaints.first
//         : "",

//     // ✅ MUST BE ARRAY
//     "diagnosis": diagnosisList.isNotEmpty
//         ? [diagnosisList.first]
//         : [],

//     // ✅ MUST BE ARRAY
//     "investigations": investigationList.isNotEmpty
//         ? [investigationList.first]
//         : [],

//     // ✅ MUST BE ARRAY
//     "surgery": surgeryList.isNotEmpty
//         ? [surgeryList.first]
//         : [],

//     "medicines": medicines.map((m) {
//       return {
//         "medicine": m["name"] ?? "",
//         "instruction": (m["note"] == null || m["note"]!.isEmpty)
//             ? "Take as advised"
//             : m["note"]!.trim(),
//       };
//     }).toList(),

//     if (followUpDate.value.isNotEmpty)
//       "followUpDate": followUpDate.value,

//     "referredTo": referredTo.value.trim(),
//   };
// }


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
    try {
      print("🟡 addChiefComplaint: $v");
      v = v.trim();
      if (v.isNotEmpty && !chiefComplaints.contains(v)) {
        chiefComplaints.add(v);
      }
      print("✅ chiefComplaints: $chiefComplaints");
    } catch (e) {
      print("❌ addChiefComplaint error: $e");
    }
  }

  void addDiagnosis(String v) {
    try {
      print("🟡 addDiagnosis: $v");
      v = v.trim();
      if (v.isNotEmpty && !diagnosisList.contains(v)) {
        diagnosisList.add(v);
      }
      print("✅ diagnosisList: $diagnosisList");
    } catch (e) {
      print("❌ addDiagnosis error: $e");
    }
  }

  void addInvestigation(String v) {
    try {
      print("🟡 addInvestigation: $v");
      v = v.trim();
      if (v.isNotEmpty && !investigationList.contains(v)) {
        investigationList.add(v);
      }
      print("✅ investigationList: $investigationList");
    } catch (e) {
      print("❌ addInvestigation error: $e");
    }
  }

  void addSurgery(String v) {
    try {
      print("🟡 addSurgery: $v");
      v = v.trim();
      if (v.isNotEmpty && !surgeryList.contains(v)) {
        surgeryList.add(v);
      }
      print("✅ surgeryList: $surgeryList");
    } catch (e) {
      print("❌ addSurgery error: $e");
    }
  }

  // ---------------- MEDICINE ----------------
  void addMedicine(String name) {
    try {
      print("🟡 addMedicine: $name");
      final v = name.trim();
      if (v.isEmpty) return;

      final exists = medicines.any(
        (m) => m["name"]?.toLowerCase() == v.toLowerCase(),
      );
      if (exists) return;

      medicines.add({"name": v, "note": ""});
      print("✅ medicines: $medicines");
    } catch (e) {
      print("❌ addMedicine error: $e");
    }
  }

  void addEmptyMedicine() {
    try {
      print("🟡 addEmptyMedicine");
      medicines.add({"name": "", "note": ""});
      print("✅ medicines: $medicines");
    } catch (e) {
      print("❌ addEmptyMedicine error: $e");
    }
  }

  void updateMedicineNote(int index, String note) {
    try {
      print("🟡 updateMedicineNote index=$index note=$note");
      if (index >= medicines.length) return;

      medicines[index] = {
        "name": medicines[index]["name"] ?? "",
        "note": note.trim(),
      };
      print("✅ medicines: $medicines");
    } catch (e) {
      print("❌ updateMedicineNote error: $e");
    }
  }

  void removeMedicine(int index) {
    try {
      print("🟡 removeMedicine index=$index");
      if (index < medicines.length) {
        medicines.removeAt(index);
      }
      print("✅ medicines: $medicines");
    } catch (e) {
      print("❌ removeMedicine error: $e");
    }
  }

  // ---------------- VALIDATION ----------------
  bool get isStepOneValid {
    try {
      final valid = chiefComplaints.isNotEmpty &&
          diagnosisList.isNotEmpty &&
          investigationList.isNotEmpty &&
          surgeryList.isNotEmpty;
      print("🔎 isStepOneValid: $valid");
      return valid;
    } catch (e) {
      print("❌ isStepOneValid error: $e");
      return false;
    }
  }

  bool get hasMedicines {
    try {
      final v = medicines.isNotEmpty;
      print("🔎 hasMedicines: $v");
      return v;
    } catch (e) {
      print("❌ hasMedicines error: $e");
      return false;
    }
  }

  bool get isFollowUpDateValid {
    try {
      final valid = followUpDate.value.isEmpty ||
          RegExp(r'^\d{4}-\d{2}-\d{2}$')
              .hasMatch(followUpDate.value);
      print("🔎 isFollowUpDateValid: $valid (${followUpDate.value})");
      return valid;
    } catch (e) {
      print("❌ isFollowUpDateValid error: $e");
      return false;
    }
  }

  // ---------------- STEP CONTROL ----------------
  void nextStep() {
    try {
      print("➡️ nextStep from ${step.value}");
      if (step.value < maxStep) step.value++;
      print("➡️ step now ${step.value}");
    } catch (e) {
      print("❌ nextStep error: $e");
    }
  }

  void previousStep() {
    try {
      print("⬅️ previousStep from ${step.value}");
      if (step.value > 1) step.value--;
      print("⬅️ step now ${step.value}");
    } catch (e) {
      print("❌ previousStep error: $e");
    }
  }

  // ---------------- PAYLOAD ----------------
  Map<String, dynamic> buildPayload(String appointmentId) {
    try {
      print("🟡 buildPayload appointmentId=$appointmentId");

      final payload = {
        "id": appointmentId,

        "note": chiefComplaints.isNotEmpty
            ? chiefComplaints.first
            : "",

        "diagnosis": diagnosisList.isNotEmpty
            ? [diagnosisList.first]
            : [],

        "investigations": investigationList.isNotEmpty
            ? [investigationList.first]
            : [],

        "surgery": surgeryList.isNotEmpty
            ? [surgeryList.first]
            : [],

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
    } catch (e) {
      print("❌ buildPayload error: $e");
      return {};
    }
  }

  // ---------------- RESET ----------------
  void resetFlow() {
    try {
      print("🔄 resetFlow called");
      step.value = 1;
      chiefComplaints.clear();
      diagnosisList.clear();
      investigationList.clear();
      surgeryList.clear();
      medicines.clear();
      followUpDate.value = "";
      referredTo.value = "";
      print("✅ resetFlow completed");
    } catch (e) {
      print("❌ resetFlow error: $e");
    }
  }
}

