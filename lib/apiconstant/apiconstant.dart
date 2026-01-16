class ApiConstants {
  ApiConstants._(); // Prevent instantiation

  /// BASE URL
  static const String baseUrl = 'https://behapi.eyebuddy.app';

  /// 
  ///  AUTH / OTP
  /// 
  static const String doctorRequestOtp = '$baseUrl/api/doctor/auth/request';
  static const String doctorVerifyOtp = '$baseUrl/api/doctor/auth/verifyAuth';
  static const String resendOtp = '$baseUrl/api/common/resendOtp';
  static const String changePhoneRequest = '$baseUrl/api/doctor/changePhone/request';
  static const String changePhoneVerify = '$baseUrl/api/doctor/changePhone/verify';
  static const String deletePaymentAccount =
      '$baseUrl/api/doctor/paymentAccount';
  /// 
  ///  DOCTOR APIs
  /// 
  /// 
  static const String doctorProfile = '$baseUrl/api/doctor/profile';
  static const String doctorProfileUpdateBasic = '$baseUrl/api/doctor/profile/updateBasicProfile';
  static const String doctorProfileUpdateExperience = '$baseUrl/api/doctor/profile/updateExperience';
  static const String doctorProfileUpdateFee = '$baseUrl/api/doctor/profile/updateConsultationFee';
  static const String doctorUploadProfilePhoto = '$baseUrl/api/doctor/profile/uploadProfilePhoto';
  static const String doctorUpdateAvailability = '$baseUrl/api/doctor/profile/updateAvailabilityStatus';
  static const String doctorAppointments = '$baseUrl/api/doctor/appointment/list';
  static const String doctorAppointmentDetails =
      '$baseUrl/api/doctor/appointment/details';
  static const String doctorCallNow = '$baseUrl/api/doctor/appointment/callNow';
  // static const String markAppointmentDropped = '$baseUrl/api/doctor/appointment/markAsDropped';
    static const String markAppointmentCallAsDropped =
      '$baseUrl/api/doctor/appointment/markAsDropped';
  static const String markAppointmentCompleted = '$baseUrl/api/doctor/appointment/markAsCompleted';
  static const String submitPrescription = '$baseUrl/api/doctor/appointment/submitPrescription';
static const String transactionsList = '$baseUrl/api/doctor/wallet/transactions';
static const String walletStatistics = '$baseUrl/api/doctor/wallet/statistics';

  static const String doctorPaymentAccount = '$baseUrl/api/doctor/paymentAccount';
  // static const String doctorSubmitWithdraw = '$baseUrl/api/doctor/wallet/submitWithdraw';
  static const String doctorNotifications = '$baseUrl/api/doctor/notification';
    static const String submitWithdraw =
      '$baseUrl/api/doctor/wallet/submitWithdraw';

  ///
  ///  PATIENT APIs
  /// 
  static const String patientProfileMe = '$baseUrl/api/patient/profile/me';
  static const String patientProfileUpdate = '$baseUrl/api/patient/profile/update';
  static const String patientDoctorList = '$baseUrl/api/patient/doctor';
  static const String patientDoctorFavorites = '$baseUrl/api/patient/doctor/favorites';
  static const String patientDoctorAddToFavorite = '$baseUrl/api/patient/doctor/addToFavorite/';
  static const String patientDoctorRemoveFromFavorite = '$baseUrl/api/patient/doctor/removeFromFavorite/';
  static const String patientPrescriptionUpload = '$baseUrl/api/patient/prescription/upload';
  static const String deletePatientPrescription = '$baseUrl/api/patient/prescription/delete/';

  // static const String patientClinicalTestResult = '$baseUrl/api/patient/testResult/clinical';
  // static const String patientAppTestResult = '$baseUrl/api/patient/testResult/app';
    static const String patientPrescription =
      '$baseUrl/api/doctor/appointment/patientPrescriptionList';
        static const String testResult = '$baseUrl/api/patient/testResult';
     

  /// 
  ///  COMMON APIs
  /// 
  static const String imageBaseUrl = 'https://beh-app.s3.eu-north-1.amazonaws.com/';
  static const String homeBanners = '$baseUrl/api/common/banners';
  static const String specialtiesList = '$baseUrl/api/common/specialties';
  
  static const String hospitalsList =
      '$baseUrl/api/common/hospitalList';
  static const String districtList = '$baseUrl/api/common/districtList';
  static const String banksList = '$baseUrl/api/common/banks';
  static const String paymentTerms = '$baseUrl/beh_payment_terms.html';
  static const String privacyPolicy = '$baseUrl/beh_privacy_policy.html';
  static const String termsConditions = '$baseUrl/beh_terms_and_conditions.html';
    static const String bankAndMfsList = '$baseUrl/api/common/banks';
   static const String medicineName = '$baseUrl/api/doctor/medication';
   static const String investigationList =
    '$baseUrl/api/doctor/investigation';
  static const String notificationList = '$baseUrl/api/doctor/notification';
    static const String chiefComplaintList =
      '$baseUrl/api/doctor/chief-complaints';
      static const String diagnosisList =
    '$baseUrl/api/doctor/diagnosis';
static const String surgeryList =
    '$baseUrl/api/doctor/surgery';



}

