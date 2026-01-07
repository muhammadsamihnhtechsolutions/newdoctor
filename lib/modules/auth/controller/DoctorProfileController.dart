
// import 'dart:convert';
// import 'dart:io';

// import 'package:beh_doctor/models/DoctorProfileModel.dart';
// import 'package:beh_doctor/models/UploadProfileImage.dart';
// import 'package:beh_doctor/repo/AuthRepo.dart';
// import 'package:beh_doctor/shareprefs.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class DoctorProfileController extends GetxController {
//   final DoctorProfileRepo _repo = DoctorProfileRepo();

//   var doctor = Rx<DoctorProfileData?>(null);

//   var isLoading = false.obs;
//   var isUpdatingAvailability = false.obs;
//   var isUploadingImage = false.obs;

//   RxString selectedHospitalId = "".obs;
//   RxString selectedSpecialtyId = "".obs;

//   /// ✅ lists
//   RxList<DoctorSpecialty> specialtyList = <DoctorSpecialty>[].obs;
//   RxList<DoctorHospital> hospitalList = <DoctorHospital>[].obs;

//   /// backend payload
//   RxList<String> selectedHospitalIds = <String>[].obs;
//   RxList<String> selectedSpecialtyIds = <String>[].obs;

//   /// 🔑 ADDITION (FOR CHANGE PHONE FLOW)
//   String get currentPhone => doctor.value?.phone ?? '';
//   String get currentDialCode => doctor.value?.dialCode ?? '';

//   @override
//   void onInit() {
//     super.onInit();

//     final token = SharedPrefs.getToken();
//     if (token == null || token.isEmpty) return;

//     fetchDoctorProfile();
//     fetchSpecialties();
//     fetchHospitals();
//   }

//   Future<void> fetchDoctorProfile() async {
//     try {
//       isLoading.value = true;
//       print("🔄 Fetching doctor profile...");

//       final apiResponse = await _repo.getDoctorProfileData();

//       print("📥 Profile API Response: ${apiResponse.toJson()}");

//       if (apiResponse.data != null) {
//         doctor.value = apiResponse.data!;

//         selectedSpecialtyIds.assignAll(
//           apiResponse.data!.specialty
//               .map((e) => e.id)
//               .whereType<String>()
//               .toList(),
//         );

//         selectedHospitalIds.assignAll(
//           apiResponse.data!.hospital
//               .map((e) => e.id)
//               .whereType<String>()
//               .toList(),
//         );

//         print("✅ Preselected specialty IDs: $selectedSpecialtyIds");
//         print("✅ Preselected hospital IDs: $selectedHospitalIds");
//       } else {
//         doctor.value = null;
//         print("⚠️ Doctor profile data is null");
//       }
//     } catch (e) {
//       print("❌ Error fetching doctor profile: $e");
//       doctor.value = null;
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> fetchSpecialties() async {
//     try {
//       print("🔄 Fetching specialties...");
//       final list = await _repo.getDoctorSpecialties();
//       specialtyList.assignAll(list);

//       for (var s in specialtyList) {
//         print("📥 Specialty: ${s.toMap()}");
//       }
//     } catch (e) {
//       print("❌ Error fetching specialties: $e");
//     }
//   }

//   Future<void> fetchHospitals() async {
//     try {
//       print("🔄 fetchHospitals() called");

//       final list = await _repo.getHospitals();

//       print("📥 Hospital raw list length: ${list.length}");

//       for (var h in list) {
//         print("🏥 Hospital => id: ${h.id}, name: ${h.name}");
//       }

//       hospitalList.assignAll(list);
//       print("✅ hospitalList assigned, total: ${hospitalList.length}");
//     } catch (e, st) {
//       print("❌ Error fetching hospitals: $e");
//       print(st);
//     }
//   }

//   Future<void> updateAvailabilityStatus(String status) async {
//     try {
//       isUpdatingAvailability.value = true;
//       print("🔄 Updating availability status to $status...");

//       final response = await _repo.updateDoctorAvailability(status: status);

//       print("📥 Availability API Response: ${response.toJson()}");

//       if (response.status == "success") {
//         if (doctor.value != null) {
//           doctor.value!.availabilityStatus = status;
//           doctor.refresh();
//           print("✅ Availability updated to $status");
//         }
//       }
//     } catch (e) {
//       print("❌ Error updating availability status: $e");
//     } finally {
//       isUpdatingAvailability.value = false;
//     }
//   }

//   Future<void> uploadProfileImage(String base64Image) async {
//     try {
//       isUploadingImage.value = true;

//       final UploadProfileImageResponse response =
//           await _repo.uploadProfileImageInBase64(base64Image);

//       if (response.status == "success") {
//         final imageUrl = response.uploadInfo?.location;

//         if (imageUrl != null && doctor.value != null) {
//           doctor.value!.photo = imageUrl;
//           doctor.refresh();
//         }
//       }
//     } finally {
//       isUploadingImage.value = false;
//     }
//   }

//   Future<bool> updateBasicInfo(Map<String, dynamic> params) async {
//     try {
//       if (doctor.value == null) return false;

//       isLoading.value = true;
//       final response = await _repo.updateDoctorProfileBasicData(params);

//       if (response.status == "success") {
//         if (response.data != null) {
//           doctor.value = response.data!;
//           doctor.refresh();
//         }
//         return true;
//       }
//       return false;
//     } catch (e) {
//       return false;
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<bool> createDoctorProfile(Map<String, dynamic> params) async {
//     try {
//       isLoading.value = true;

//       final response = await _repo.updateDoctorProfileBasicData(params);

//       if (response.status == "success") {
//         if (response.data != null) {
//           doctor.value = response.data!;
//           doctor.refresh();
//         }
//         return true;
//       }
//       return false;
//     } catch (e) {
//       return false;
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ================= IMAGE PICKER =================

//   final ImagePicker _picker = ImagePicker();

//   Future<void> pickImage(BuildContext context) async {
//     showModalBottomSheet(
//       context: context,
//       builder: (_) {
//         return SafeArea(
//           child: Wrap(
//             children: [
//               ListTile(
//                 leading: const Icon(Icons.camera_alt),
//                 title: const Text("Camera"),
//                 onTap: () async {
//                   Navigator.pop(context);
//                   await _pick(ImageSource.camera);
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.photo_library),
//                 title: const Text("Gallery"),
//                 onTap: () async {
//                   Navigator.pop(context);
//                   await _pick(ImageSource.gallery);
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Future<void> _pick(ImageSource source) async {
//     final XFile? picked =
//         await _picker.pickImage(source: source, imageQuality: 60);

//     if (picked == null) return;

//     final bytes = await File(picked.path).readAsBytes();
//     final base64Image = base64Encode(bytes);

//     await uploadProfileImage(base64Image);
//   }
// }
import 'dart:convert';
import 'dart:io';

import 'package:beh_doctor/models/DoctorProfileModel.dart';
import 'package:beh_doctor/models/UploadProfileImage.dart';
import 'package:beh_doctor/repo/AuthRepo.dart';
import 'package:beh_doctor/shareprefs.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DoctorProfileController extends GetxController {
  final DoctorProfileRepo _repo = DoctorProfileRepo();

  var doctor = Rx<DoctorProfileData?>(null);

  var isLoading = false.obs;
  var isUpdatingAvailability = false.obs;
  var isUploadingImage = false.obs;

  /// dropdown selected
  RxString selectedHospitalId = ''.obs;
  RxString selectedSpecialtyId = ''.obs;

  /// dropdown lists
  RxList<DoctorSpecialty> specialtyList = <DoctorSpecialty>[].obs;
  RxList<DoctorHospital> hospitalList = <DoctorHospital>[].obs;

  /// backend payload
  RxList<String> selectedHospitalIds = <String>[].obs;
  RxList<String> selectedSpecialtyIds = <String>[].obs;

  /// 🔑 FOR CHANGE PHONE FLOW (PROFILE SOURCE)
  String get currentPhone => doctor.value?.phone ?? '';
  String get currentDialCode => doctor.value?.dialCode ?? '';

  @override
  void onInit() {
    super.onInit();

    final token = SharedPrefs.getToken();
    if (token == null || token.isEmpty) return;

    fetchDoctorProfile();
    fetchSpecialties();
    fetchHospitals();
  }

  // ================= PROFILE =================

  Future<void> fetchDoctorProfile() async {
    try {
      isLoading.value = true;

      final apiResponse = await _repo.getDoctorProfileData();

      if (apiResponse.data != null) {
        doctor.value = apiResponse.data!;

        /// ✅ SAFE UNIQUE IDS
        selectedSpecialtyIds.assignAll(
          apiResponse.data!.specialty
              .map((e) => e.id)
              .whereType<String>()
              .toSet()
              .toList(),
        );

        selectedHospitalIds.assignAll(
          apiResponse.data!.hospital
              .map((e) => e.id)
              .whereType<String>()
              .toSet()
              .toList(),
        );

        /// set first as selected (dropdown safe)
        if (selectedSpecialtyIds.isNotEmpty) {
          selectedSpecialtyId.value = selectedSpecialtyIds.first;
        }

        if (selectedHospitalIds.isNotEmpty) {
          selectedHospitalId.value = selectedHospitalIds.first;
        }
      } else {
        doctor.value = null;
      }
    } catch (e) {
      doctor.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  // ================= SPECIALTIES =================

  Future<void> fetchSpecialties() async {
    try {
      final list = await _repo.getDoctorSpecialties();

      /// ✅ REMOVE DUPLICATES (DROPDOWN FIX)
      final unique = <String, DoctorSpecialty>{};
      for (var s in list) {
        if (s.id != null) {
          unique[s.id!] = s;
        }
      }

      specialtyList.assignAll(unique.values.toList());

      /// dropdown value safety
      if (selectedSpecialtyId.value.isNotEmpty &&
          !specialtyList.any((e) => e.id == selectedSpecialtyId.value)) {
        selectedSpecialtyId.value = '';
      }
    } catch (_) {}
  }

  // ================= HOSPITALS =================

  Future<void> fetchHospitals() async {
    try {
      final list = await _repo.getHospitals();

      /// ✅ REMOVE DUPLICATES
      final unique = <String, DoctorHospital>{};
      for (var h in list) {
        if (h.id != null) {
          unique[h.id!] = h;
        }
      }

      hospitalList.assignAll(unique.values.toList());

      /// dropdown value safety
      if (selectedHospitalId.value.isNotEmpty &&
          !hospitalList.any((e) => e.id == selectedHospitalId.value)) {
        selectedHospitalId.value = '';
      }
    } catch (_) {}
  }

  // ================= AVAILABILITY =================

  Future<void> updateAvailabilityStatus(String status) async {
    try {
      isUpdatingAvailability.value = true;

      final response =
          await _repo.updateDoctorAvailability(status: status);

      if (response.status == "success" && doctor.value != null) {
        doctor.value!.availabilityStatus = status;
        doctor.refresh();
      }
    } catch (_) {
    } finally {
      isUpdatingAvailability.value = false;
    }
  }

  // ================= IMAGE =================

  Future<void> uploadProfileImage(String base64Image) async {
    try {
      isUploadingImage.value = true;

      final UploadProfileImageResponse response =
          await _repo.uploadProfileImageInBase64(base64Image);

      if (response.status == "success") {
        final imageUrl = response.uploadInfo?.location;
        if (imageUrl != null && doctor.value != null) {
          doctor.value!.photo = imageUrl;
          doctor.refresh();
        }
      }
    } finally {
      isUploadingImage.value = false;
    }
  }

  Future<bool> updateBasicInfo(Map<String, dynamic> params) async {
    try {
      if (doctor.value == null) return false;

      isLoading.value = true;

      final response =
          await _repo.updateDoctorProfileBasicData(params);

      if (response.status == "success" && response.data != null) {
        doctor.value = response.data!;
        doctor.refresh();
        return true;
      }
      return false;
    } catch (_) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> createDoctorProfile(Map<String, dynamic> params) async {
    try {
      isLoading.value = true;

      final response =
          await _repo.updateDoctorProfileBasicData(params);

      if (response.status == "success" && response.data != null) {
        doctor.value = response.data!;
        doctor.refresh();
        return true;
      }
      return false;
    } catch (_) {
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // ================= IMAGE PICKER =================

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () async {
                Navigator.pop(context);
                await _pick(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Gallery"),
              onTap: () async {
                Navigator.pop(context);
                await _pick(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pick(ImageSource source) async {
    final XFile? picked =
        await _picker.pickImage(source: source, imageQuality: 60);

    if (picked == null) return;

    final bytes = await File(picked.path).readAsBytes();
    final base64Image = base64Encode(bytes);

    await uploadProfileImage(base64Image);
  }
}
