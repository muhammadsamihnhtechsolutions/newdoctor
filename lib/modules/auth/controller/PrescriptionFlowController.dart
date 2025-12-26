
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
  Rx<Investigation?> selectedInvestigation = Rx<Investigation?>(null);

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
