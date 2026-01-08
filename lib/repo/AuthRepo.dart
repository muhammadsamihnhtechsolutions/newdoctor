
import 'dart:developer';
import 'package:beh_doctor/apiconstant/apiconstant.dart';
import 'package:beh_doctor/apiconstant/apiservice.dart';
import 'package:beh_doctor/models/AppoinmentDetailModel.dart';
import 'package:beh_doctor/models/AppointmentModel.dart';
import 'package:beh_doctor/models/BankListResponse.dart';
import 'package:beh_doctor/models/CommonApiResponceModel.dart';
import 'package:beh_doctor/models/DistrictResponseModel.dart';
import 'package:beh_doctor/models/DoctorProfileModel.dart';
import 'package:beh_doctor/models/InvestigationModel.dart';
import 'package:beh_doctor/models/MedicineTrackerModel.dart';

import 'package:beh_doctor/models/TransectionModel.dart';
import 'package:beh_doctor/models/UploadProfileImage.dart';
import 'package:beh_doctor/models/VerifyOtpModel.dart';
import 'package:beh_doctor/models/WalletStatistics.dart';
import 'package:beh_doctor/models/WithdrawAccountListResponse.dart';
import 'package:beh_doctor/models/prescriptionListSubmit.dart';

// import 'package:beh_doctor/models/GetDoctorApiResponse.dart'; // Ensure this import exists and the file defines GetDoctorApiResponse


class AuthRepo {
  final ApiService _apiService = ApiService();

  // --------------------------------------------------------
  // 🔹 REQUEST OTP (LOGIN)
  // --------------------------------------------------------
  Future<VerifyOtpApiResponse> requestOtp({
    required String phone,
    required String dialCode,
  }) async {
    try {
      final response = await _apiService.getPostResponse(
        '${ApiConstants.baseUrl}/api/doctor/auth/request',
        {
          "phone": phone,
          "dialCode": dialCode,
        },
      );

      return VerifyOtpApiResponse.fromMap(response);
    } catch (err) {
      return VerifyOtpApiResponse(
        status: 'error',
        message: 'Failed to request OTP',
      );
    }
  }

  // --------------------------------------------------------
  // 🔹 VERIFY OTP (LOGIN)
  // --------------------------------------------------------
  Future<VerifyOtpApiResponse> verifyOtp({
    required String traceId,
    required String otpCode,
    required String deviceToken,
    String? preToken,
  }) async {
    try {
      final verifyOtpModel = VerifyOtpModel(
        traceId: traceId,
        code: otpCode,
        deviceToken: deviceToken,
      );

      final response = await _apiService.getPostResponse(
        '${ApiConstants.baseUrl}/api/doctor/auth/verifyAuth',
        verifyOtpModel.toMap(),
      );

      return VerifyOtpApiResponse.fromMap(response);
    } catch (err) {
      return VerifyOtpApiResponse(
        status: 'error',
        message: 'Failed to verify OTP',
      );
    }
  }

  // ========================================================
  // 🔹 CHANGE PHONE → REQUEST OTP
  // ========================================================
Future<String?> requestChangePhoneOtp({
  required String currentDialCode,
  required String currentPhone,
  required String newDialCode,
  required String newPhone,
}) async {
  final res = await _apiService.getPostResponse(
    '${ApiConstants.baseUrl}/api/doctor/changePhone/request',
    {
      "currentDialCode": currentDialCode,
      "currentPhone": currentPhone,
      "dialCode": newDialCode,
      "phone": newPhone,
    },
  ) as Map<String, dynamic>;

  if (res['status'] == 'success') {
    return res['data']?['traceId'];
  }
  return null;
}


  // ========================================================
  // 🔹 CHANGE PHONE → VERIFY OTP
  // ========================================================
  Future<VerifyOtpApiResponse> verifyChangePhoneOtp({
    required String traceId,
    required String otpCode,
  }) async {
    try {
      final model = VerifyOtpModel(
        traceId: traceId,
        code: otpCode,
      );

      final response = await _apiService.getPostResponse(
        '${ApiConstants.baseUrl}/api/doctor/changePhone/verify',
        model.toMap(),
      );

      return VerifyOtpApiResponse.fromMap(response);
    } catch (_) {
      return VerifyOtpApiResponse(
        status: 'error',
        message: 'Failed to verify change phone OTP',
      );
    }
  }

  // --------------------------------------------------------
  // 🔹 RESEND OTP (LOGIN + CHANGE PHONE — BOTH)
  // --------------------------------------------------------
  Future<void> resendOtp({
    required String traceId,
    required String dialCode,
  }) async {
    try {
      await _apiService.getPostResponse(
        '${ApiConstants.baseUrl}/api/common/resendOtp',
        {
          "traceId": traceId,
          "dialCode": dialCode,
        },
      );
    } catch (_) {}
  }
}


class DoctorProfileRepo {
  final ApiService _apiService = ApiService();

  // =================================================
  //             GET DOCTOR PROFILE
  // =================================================
  Future<GetDoctorApiResponse> getDoctorProfileData() async {
    try {
      final response = await _apiService.getGetResponse(
        '${ApiConstants.baseUrl}/api/doctor/profile',
      );

      return GetDoctorApiResponse.fromMap(response);
    } catch (err) {
      return GetDoctorApiResponse(
        status: 'error',
        message: 'An error occurred',
      );
    }
  }

  // =================================================
  //         UPDATE AVAILABILITY STATUS
  // =================================================
  Future<GetDoctorApiResponse> updateDoctorAvailability({
    required String status,
  }) async {
    try {
      print("🔄 Updating doctor availability to: $status");

      final response = await _apiService.getPatchResponse(
        "${ApiConstants.baseUrl}/api/doctor/profile/updateAvailabilityStatus/$status",
        {},
      );

      print("✅ Availability Update Response: $response");

      return GetDoctorApiResponse.fromMap(
        response as Map<String, dynamic>,
      );
    } catch (err) {
      print("❌ Error updating availability: $err");

      return GetDoctorApiResponse(
        status: 'error',
        message: 'An error occurred',
      );
    }
  }

  // =================================================
  //           UPLOAD PROFILE IMAGE (BASE64)
  // =================================================
Future<UploadProfileImageResponse> uploadProfileImageInBase64(
    String base64Image) async {
  try {
    final response = await _apiService.getPostResponse(
      "${ApiConstants.baseUrl}/api/doctor/profile/uploadProfilePhoto",
      {
        "base64String": base64Image,
      },
    );

    return UploadProfileImageResponse.fromJson(
      response as Map<String, dynamic>,
    );
  } catch (e) {
    return UploadProfileImageResponse(
      status: "error",
      message: "Image upload failed",
    );
  }
}


  // =================================================
  //           UPDATE / CREATE BASIC PROFILE
  // =================================================
  Future<GetDoctorApiResponse> updateDoctorProfileBasicData(
      Map<String, dynamic> params) async {
    print("📤 Sending Params: $params");

    try {
      final response = await _apiService.getPostResponse(
        "${ApiConstants.baseUrl}/api/doctor/profile/updateBasicProfile",
        params,
      );

      print("📥 RAW UPDATE RESPONSE: $response");

      return GetDoctorApiResponse.fromMap(response);
    } catch (e) {
      print("❌ Repo Error: $e");
      return GetDoctorApiResponse(
        status: "error",
        message: "Failed to update profile",
      );
    }
  }

  // =================================================
  //                GET SPECIALTIES
  // =================================================
  Future<List<DoctorSpecialty>> getDoctorSpecialties() async {
    try {
      final response = await _apiService.getGetResponse(
        ApiConstants.specialtiesList,
      );

      if (response['status'] == 'success' && response['data'] != null) {
        return (response['data'] as List)
            .map((e) => DoctorSpecialty.fromMap(e))
            .toList();
      }
      return [];
    } catch (e) {
      print("❌ Repo Error (Specialties): $e");
      return [];
    }
  }

  // =================================================
  //                  GET HOSPITALS
  // =================================================
  Future<List<DoctorHospital>> getHospitals() async {
    try {
      final response = await _apiService.getGetResponse(
        ApiConstants.hospitalsList,
      );

      if (response['status'] == 'success' && response['data'] != null) {
        return (response['data'] as List)
            .map((e) => DoctorHospital.fromMap(e))
            .toList();
      }
      return [];
    } catch (e) {
      print("❌ Repo Error (Hospitals): $e");
      return [];
    }
  }
}

// ================= SPECIALTIES =================





// transectionrepo


class TransactionRepo {
  final ApiService _apiService = ApiService();

  /// GET Transactions List with parameters
  Future<TransactionsResponseModel> getTransactionsList(
      Map<String, dynamic> parameters) async {
    try {
      final apiResponse = TransactionsResponseModel.fromJson(
        await _apiService.getGetResponseWithParameters(
            ApiConstants.transactionsList, parameters),
      );
      return apiResponse;
    } catch (err) {
      return TransactionsResponseModel(
        status: 'error',
        message: 'An error occurred',
      );
    }
  }

  /// GET Wallet Statistics
  Future<WalletStatisticsResponseModel> getWalletStatistics() async {
    try {
      final response =
          await _apiService.getGetResponse(ApiConstants.walletStatistics);
      return WalletStatisticsResponseModel.fromJson(
          response as Map<String, dynamic>);
    } catch (err) {
      return WalletStatisticsResponseModel(
        status: 'error',
        message: 'An error occurred',
      );
    }
  }
  // ----------------------------------------------------
  /// UPDATE BASIC PROFILE → PHOTO, NAME, CONTACT, GENDER

  // Appointmentlistrepo
}

//  AppointmentRepo 
class AppointmentRepo {
  final ApiService _apiService = ApiService();

  Future<GetAppointmentListApiResponse> getAppointmentList() async {
    try {
      final apiResponse = GetAppointmentListApiResponse.fromMap(
        await _apiService.getGetResponse(
          '${ApiConstants.baseUrl}/api/doctor/appointment/list',
        ) as Map<String, dynamic>,
      );
      return apiResponse;
    } catch (err) {
      return GetAppointmentListApiResponse(
        status: 'error',
        message: 'An error occurred',
        data: null,
      );
    }
  }
  // Future<AppointmentDetailsResponseModel> getAppointmentDetails(String appointmentId) async {
  //   try {
  //     final apiResponse = AppointmentDetailsResponseModel.fromJson(
  //       await _apiService.getGetResponse(
  //         '${ApiConstants.baseUrl}/api/doctor/appointment/$appointmentId',
  //       ),
  //     );
      
  //     // 🔹 Print full response to terminal for debugging
  //     print("✅ Appointment Details Response: ${apiResponse.toJson()}");
      
  //     return apiResponse;
  //   } catch (err) {
  //     print("❌ Error fetching appointment details: $err");
  //     return AppointmentDetailsResponseModel(
  //       status: 'error',
  //       message: 'An error occurred',
  //       appointmentDetailsData: null,
  //     );
  //   }
  // }
  
//  
Future<AppointmentDetailsResponseModel> getDoctorAppointmentDetails(
    String appointmentID) async 
{
  final url = "${ApiConstants.doctorAppointmentDetails}/$appointmentID";

  print("🌐 GET URL: $url");

  final response = await _apiService.getGetResponse(url);

  print("🔍 Raw Response: $response");

  final apiResponse = AppointmentDetailsResponseModel.fromJson(
      response as Map<String, dynamic>);

  print("📥 Status: ${apiResponse.status}");
  print("📩 Message: ${apiResponse.message}");

  if (apiResponse.appointmentDetailsData == null) {
    print("❌ appointmentDetailsData == NULL");
  }

  return apiResponse;
}
}
class PrescriptionRepo {
  final ApiService _apiService = ApiService();

  Future<PrescriptionListResponseModel> getPrescriptionList(String patientId) async {
    try {
      final response = await _apiService.getGetResponse(
        '${ApiConstants.patientPrescription}/$patientId',
      ) as Map<String, dynamic>;

      return PrescriptionListResponseModel.fromJson(response);
    } catch (e) {
      print("❌ Prescription Fetch Error: $e");
      return PrescriptionListResponseModel(
        status: "error",
        message: "Something went wrong",
        prescriptionListData: PrescriptionListData(prescriptionList: []),
      );
    }
  }
}

  
// }
// class PrescriptionRepo {
//   final ApiService _apiService;

//   PrescriptionRepo(this._apiService);

//   Future<PrescriptionListResponseModel> getPatientPrescriptions(String patientId) async {
//     try {
//       final res = await _apiService.getGetResponse(
//         "${ApiConstants.patientPrescription}/$patientId",
//       );

//       return PrescriptionListResponseModel.fromJson(res);
//     } catch (e) {
//       throw Exception("Error fetching prescriptions: $e");
//     }
//   }
// }

//   // 🔹 Fetch logged-in profile data
// class ProfileRepo {
//   final ApiService _apiService;

//   ProfileRepo(this._apiService);

//   Future<ProfileResponseModel> getProfileData() async {
//     try {
//       final res = await _apiService.getGetResponse(ApiConstants.patientProfileMe);

//       return ProfileResponseModel.fromJson(res as Map<String, dynamic>);
//     } catch (err) {
//       return ProfileResponseModel(
//         status: 'error',
//         message: 'An error occurred',
//       );
//     }
//   }
// }

  /// ----------------------------------------------------
  /// UPDATE EXPERIENCE SECTION
  /// ----------------------------------------------------
  // Future<GetDoctorApiResponse> updateExperience(
  //     Map<String, dynamic> parameters) async {
  //   try {
  //     final apiResponse = GetDoctorApiResponse.fromMap(
  //       await _apiService.getPostResponse(
  //         '${ApiConstants.baseUrl}/api/doctor/profile/updateExperience',
  //         parameters,
  //       ) as Map<String, dynamic>,
  //     );

  //     return apiResponse;
  //   } catch (err) {
  //     return GetDoctorApiResponse(
  //       status: 'error',
  //       message: 'Failed to update experience',
  //     );
  //   }
  // }

  // /// ----------------------------------------------------
  // /// UPDATE CONSULTATION INFO
  // /// ----------------------------------------------------
  // Future<GetDoctorApiResponse> updateConsultationInfo(
  //     Map<String, dynamic> parameters) async {
  //   try {
  //     final apiResponse = GetDoctorApiResponse.fromMap(
  //       await _apiService.getPostResponse(
  //         '${ApiConstants.baseUrl}/api/doctor/profile/updateConsultationInfo',
  //         parameters,
  //       ) as Map<String, dynamic>,
  //     );

  //     return apiResponse;
  //   } catch (err) {
  //     return GetDoctorApiResponse(
  //       status: 'error',
  //       message: 'Failed to update consultation info',
  //     );
  //   }
  // }

  // /// POST Withdraw Request
  // Future<CommonResponseModel> getDoctorWalletSubmitWithdraw(
  //     Map<String, dynamic> parameters) async {
  //   try {
  //     final response = await _apiService.getPostResponse(
  //         ApiConstants.submitWithdraw, parameters);
  //     return CommonResponseModel.fromJson(response as Map<String, dynamic>);
  //   } catch (err) {
  //     return CommonResponseModel(
  //       status: 'error',
  //       message: 'An error occurred',
  //     );
  //   }
  // }



class ApiRepo {
  final ApiService _apiService = ApiService();

  /// Makes a call request for an appointment
  /// Returns a Map containing status, token, and any other data
  Future<Map<String, dynamic>> makeAppointmentCall({
    required String appointmentId,
  }) async {
    try {
      log("📤 Sending CallNow request for appointmentId: $appointmentId");

      final apiResponse = await _apiService.getGetResponse(
        '${ApiConstants.baseUrl}/api/doctor/appointment/callNow/$appointmentId',
      );

      log("📥 API Response: $apiResponse");

      // Example: backend response
      // {
      //   "status": "success",
      //   "token": "AGORA_TOKEN_HERE",
      //   "channel": "CHANNEL_ID_HERE"
      // }

      return apiResponse;
    } catch (err) {
      log("❌ Error in makeAppointmentCall: $err");
      return {
        "status": "error",
        "message": err.toString(),
      };
    }
  }
  
  // Future<UpdateMedicationApiResponse> addMedication({
  //   required Medication medication,
  // }) async {
  //   try {
  //     final apiRespnse = UpdateMedicationApiResponse.fromMap(
  //       await _apiService.getPostResponse(
  //         '${ApiConstants.baseUrl}/api/patient/medicineTracker',
  //         medication.toMap(),
  //       ) as Map<String, dynamic>,
  //     );
  //     return apiRespnse;
  //   } catch (err) {
  //     return UpdateMedicationApiResponse(
  //       status: 'error',
  //       message: 'An error occurred',
  //     );
  //   }
  // }
 
  Future<PrescriptionSubmittedResponse> submitPrescription(
    Map<String, dynamic> payload,
  ) async {
    try {
      return PrescriptionSubmittedResponse.fromJson(
        await _apiService.getPostResponse(
          ApiConstants.submitPrescription,
          payload,
        ),
      );
    } catch (err) {
      return PrescriptionSubmittedResponse(
        status: "error",
        message: "An error occurred!",
      );
    }
  }
    Future<void> markAppointmentCallAsCompleted(
    String id,
    int callDuration,
  ) async {
    try {
      await _apiService.getPatchResponse(
        ApiConstants.markAppointmentCompleted +
            "/${id}" +
            "?callDurationInSec=${callDuration}",
        {},
      );
      return;
    } catch (err) {
      return;
    }
  }
  Future<void> markAppointmentCallAsDropped(String id) async {
  try {
    await _apiService.getPatchResponse(
      ApiConstants.markAppointmentCallAsDropped + "/$id",
      {},
    );
  } catch (_) {}
}

}
class WithdrawAccountRepo {
  final ApiService _apiService = ApiService();

  Future<WithdrawAccountResponseModel> getWithdrawAccountList() async {
    try {
      final response = await _apiService.getGetResponse(
      ApiConstants.doctorPaymentAccount

      );

      print("📥 RAW API RESPONSE: $response"); // Terminal print

      return WithdrawAccountResponseModel.fromJson(
        response as Map<String, dynamic>,
      );
    } catch (e) {
      print("❌ WithdrawAccountRepo Error: $e");
      return WithdrawAccountResponseModel(
        status: "error",
        message: "Error occurred",
      );
    }
  }
  
  Future<CommonResponseModel> getDoctorWalletSubmitWithdraw(
      Map<String, dynamic> parameters) async {
    try {
      final apiResponse = CommonResponseModel.fromJson(
        await _apiService.getPostResponse(
            ApiConstants.submitWithdraw, parameters) as Map<String, dynamic>,
      );
      return apiResponse;
    } catch (err) {
      return CommonResponseModel(
        status: 'error',
        message: 'An error occurred',
      );
    }
  }
  
  Future<CommonResponseModel> addNewBankAccount(
      Map<String, dynamic> parameters) async {
    try {
      final apiResponse = CommonResponseModel.fromJson(
        await _apiService.getPostResponse(
            ApiConstants.doctorPaymentAccount, parameters) as Map<String, dynamic>,
      );
      return apiResponse;
    } catch (err) {
      return CommonResponseModel(
        status: 'error',
        message: 'An error occurred',
      );
    }
  }


  Future<DistrictResponseModel> districtListResponse() async {
    try {
      final apiResponse = DistrictResponseModel.fromJson(
        await _apiService.getGetResponse('${ApiConstants.districtList}')
            as Map<String, dynamic>,
      );
      return apiResponse;
    } catch (err) {
      return DistrictResponseModel(
        status: 'error',
        message: 'An error occurred',
      );
    }
  }

  Future<BankListResponseModel> getBankAndMfsListResponse(
      Map<String, dynamic> parameters) async {
    try {
      final apiResponse = BankListResponseModel.fromJson(
        await _apiService.getGetResponseWithParameters(
                '${ApiConstants.bankAndMfsList}', parameters)
            as Map<String, dynamic>,
      );
      return apiResponse;
    } catch (err) {
      return BankListResponseModel(
        status: 'error',
        message: 'An error occurred',
      );
    }
  }
}
class MedicationRepo {
  final ApiService _apiService = ApiService();

  /// 🔹 Get medicine list for dropdown
  Future<List<Medication>> getMedicineList() async {
    try {
      final response = await _apiService.getGetResponse(
        ApiConstants.medicineName,
      );

      final apiResponse =
          MedicationTrackerApiResponse.fromMap(response);

      if (apiResponse.status == "success") {
        return apiResponse.data?.docs ?? [];
      } else {
        return [];
      }
    } catch (e) {
      print("❌ Medicine API Error: $e");
      return [];
    }
  }
 

}
class InvestigationRepo {
  final _apiService = ApiService();

  Future<List<Investigation>> getInvestigationList() async {
    try {
      final response = await _apiService.getGetResponse(
        ApiConstants.investigationList,
      ) as Map<String, dynamic>;

      final apiResponse =
          InvestigationApiResponse.fromMap(response);

      return apiResponse.docs;
    } catch (e) {
      print("❌ getInvestigationList error: $e");
      return [];
    }
  }
}
class ExperienceRepo {
  final ApiService _apiService = ApiService();

  Future<GetDoctorApiResponse> uploadDoctorExperienceData(
    Map<String, dynamic> parameters,
  ) async {
    try {
      final response = await _apiService.getPostResponse(
        '${ApiConstants.baseUrl}/api/doctor/profile/updateExperience',
        parameters,
      );

      return GetDoctorApiResponse.fromMap(
        response as Map<String, dynamic>,
      );
    } catch (e) {
      return GetDoctorApiResponse(
        status: 'error',
        message: 'Something went wrong',
      );
    }
  }
}

