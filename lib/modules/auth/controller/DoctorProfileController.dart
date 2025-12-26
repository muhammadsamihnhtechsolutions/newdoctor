
// import 'package:beh_doctor/models/DoctorProfileModel.dart';
// import 'package:beh_doctor/repo/AuthRepo.dart';
// import 'package:beh_doctor/shareprefs.dart';
// import 'package:get/get.dart';

// class DoctorProfileController extends GetxController {
//   final DoctorProfileRepo _repo = DoctorProfileRepo();

//   var doctor = Rx<DoctorProfileData?>(null);
//   var isLoading = false.obs;
//   var isUpdatingAvailability = false.obs;
//   var isUploadingImage = false.obs;

//   @override
//   void onInit() {
//     super.onInit();

//     final token = SharedPrefs.getToken();
//     if (token == null || token.isEmpty) return;

//     fetchDoctorProfile();
//   }

//   // --------------------------------------------------
//   //             GET DOCTOR PROFILE
//   // --------------------------------------------------
//   Future<void> fetchDoctorProfile() async {
//     try {
//       isLoading.value = true;

//       final apiResponse = await _repo.getDoctorProfileData();

//       if (apiResponse.data != null) {
//         doctor.value = apiResponse.data!;
//       } else {
//         doctor.value = null;
//       }
//     } catch (e) {
//       print("❌ Error fetching doctor profile: $e");
//       doctor.value = null;
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // --------------------------------------------------
//   //        UPDATE AVAILABILITY (ONLINE/OFFLINE)
//   // --------------------------------------------------
//   Future<void> updateAvailabilityStatus(String status) async {
//     try {
//       isUpdatingAvailability.value = true;

//       final response = await _repo.updateDoctorAvailability(status: status);

//       if (response.status == "success") {
//         if (doctor.value != null) {
//           doctor.value!.availabilityStatus = status;
//           doctor.refresh();
//         }
//       } else {
//         print("❌ Availability update failed: ${response.message}");
//       }
//     } catch (e) {
//       print("❌ Error updating status: $e");
//     } finally {
//       isUpdatingAvailability.value = false;
//     }
//   }

//   // --------------------------------------------------
//   //                UPLOAD PROFILE IMAGE
//   // --------------------------------------------------
//   Future<void> uploadProfileImage(String base64Image) async {
//     try {
//       isUploadingImage.value = true;

//       final response = await _repo.uploadProfileImageInBase64(base64Image);

//       if (response.status == "success") {
//         final String? newPhoto = response.data?.photo;

//         if (newPhoto != null && doctor.value != null) {
//           doctor.value!.photo = newPhoto;
//           doctor.refresh();
//         }
//       } else {
//         print("❌ Upload failed: ${response.message}");
//       }
//     } catch (e) {
//       print("❌ Error uploading image: $e");
//     } finally {
//       isUploadingImage.value = false;
//     }
//   }

//   // --------------------------------------------------
//   //            UPDATE BASIC PROFILE
//   // --------------------------------------------------
// Future<bool> updateBasicInfo(Map<String, dynamic> params) async {
//   try {
//     if (doctor.value == null) {
//       print("❌ Doctor data not loaded yet");
//       return false;
//     }

//     isLoading.value = true;

//     final response = await _repo.updateDoctorProfileBasicData(params);

//     // 🔴 FIX: NULL CHECK
//     if (response == null) {
//       print("❌ API returned null response");
//       return false;
//     }

//     if (response.status == "success") {
//       if (response.data != null) {
//         doctor.value = response.data!;
//         doctor.refresh();
//       }
//       return true;
//     } else {
//       print("❌ Basic info update failed: ${response.message}");
//       return false;
//     }
//   } catch (e) {
//     print("❌ Controller Error updating basic info: $e");
//     return false;
//   } finally {
//     isLoading.value = false;
//   }
// }

// }

// newworkstart

import 'package:beh_doctor/models/DoctorProfileModel.dart';
import 'package:beh_doctor/repo/AuthRepo.dart';
import 'package:beh_doctor/shareprefs.dart';
import 'package:get/get.dart';

class DoctorProfileController extends GetxController {
  final DoctorProfileRepo _repo = DoctorProfileRepo();

  var doctor = Rx<DoctorProfileData?>(null);
  var isLoading = false.obs;
  var isUpdatingAvailability = false.obs;
  var isUploadingImage = false.obs;

  @override
  void onInit() {
    super.onInit();

    final token = SharedPrefs.getToken();
    if (token == null || token.isEmpty) return;

    fetchDoctorProfile();
  }

  // --------------------------------------------------
  //             GET DOCTOR PROFILE
  // --------------------------------------------------
  Future<void> fetchDoctorProfile() async {
    try {
      isLoading.value = true;

      final apiResponse = await _repo.getDoctorProfileData();

      if (apiResponse.data != null) {
        doctor.value = apiResponse.data!;
      } else {
        doctor.value = null;
      }
    } catch (e) {
      print("❌ Error fetching doctor profile: $e");
      doctor.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  // --------------------------------------------------
  //        UPDATE AVAILABILITY (ONLINE/OFFLINE)
  // --------------------------------------------------
  Future<void> updateAvailabilityStatus(String status) async {
    try {
      isUpdatingAvailability.value = true;

      final response = await _repo.updateDoctorAvailability(status: status);

      if (response.status == "success") {
        if (doctor.value != null) {
          doctor.value!.availabilityStatus = status;
          doctor.refresh();
        }
      } else {
        print("❌ Availability update failed: ${response.message}");
      }
    } catch (e) {
      print("❌ Error updating status: $e");
    } finally {
      isUpdatingAvailability.value = false;
    }
  }

  // --------------------------------------------------
  //                UPLOAD PROFILE IMAGE
  // --------------------------------------------------
  Future<void> uploadProfileImage(String base64Image) async {
    try {
      isUploadingImage.value = true;

      final response = await _repo.uploadProfileImageInBase64(base64Image);

      if (response.status == "success") {
        final String? newPhoto = response.data?.photo;

        if (newPhoto != null && doctor.value != null) {
          doctor.value!.photo = newPhoto;
          doctor.refresh();
        }
      } else {
        print("❌ Upload failed: ${response.message}");
      }
    } catch (e) {
      print("❌ Error uploading image: $e");
    } finally {
      isUploadingImage.value = false;
    }
  }

  // --------------------------------------------------
  //            UPDATE BASIC PROFILE
  // --------------------------------------------------
Future<bool> updateBasicInfo(Map<String, dynamic> params) async {
  try {
    if (doctor.value == null) {
      print("❌ Doctor data not loaded yet");
      return false;
    }

    isLoading.value = true;

    final response = await _repo.updateDoctorProfileBasicData(params);

    // 🔴 FIX: NULL CHECK
    if (response == null) {
      print("❌ API returned null response");
      return false;
    }

    if (response.status == "success") {
      if (response.data != null) {
        doctor.value = response.data!;
        doctor.refresh();
      }
      return true;
    } else {
      print("❌ Basic info update failed: ${response.message}");
      return false;
    }
  } catch (e) {
    print("❌ Controller Error updating basic info: $e");
    return false;
  } finally {
    isLoading.value = false;
  }
}

// --------------------------------------------------
//              CREATE BASIC PROFILE
// --------------------------------------------------
Future<bool> createDoctorProfile(Map<String, dynamic> params) async {
  try {
    isLoading.value = true;

    final response = await _repo.updateDoctorProfileBasicData(params);
    // 👆 SAME API → backend decide karega create vs update

    if (response.status == "success") {
      if (response.data != null) {
        doctor.value = response.data!;
        doctor.refresh(); // 🔥 VERY IMPORTANT
      }
      return true;
    } else {
      print("❌ Create profile failed: ${response.message}");
      return false;
    }
  } catch (e) {
    print("❌ Controller Error creating profile: $e");
    return false;
  } finally {
    isLoading.value = false;
  }
}

}
