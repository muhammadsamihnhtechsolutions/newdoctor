import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      'doctor_profile': 'Doctor Profile',
      'no_data': 'No Data',
      'unknown': 'Unknown',

      // Basic Info
      'basic_info': 'Basic Information',
      'gender': 'Gender',
      'experience': 'Experience',
      'years': 'years',

      // Specialty
      'specialties': 'Specialties',
      'no_specialty': 'No specialties available',

      // Hospitals
      'hospitals': 'Hospitals',
      'no_hospital': 'No hospital data available',

      // Button
      'edit_profile': 'Edit Profile',

      'calling': 'Calling...',
      'prescription': 'Prescription',
      'overview': 'Overview',
      'confirm': 'Confirm',
      'back_to_edit': 'Back to Edit',
      'chief_complaints': 'Chief Complaints',
      'diagnosis': 'Diagnosis',
      'investigations': 'Investigations',
      'surgery': 'Surgery',
      'medicine': 'Medicine',
      'medicine_name': 'Medicine name',
      'notes': 'Notes',
      'follow_up_date': 'Follow Up Date',
      'referred_to': 'Referred to',
      'add_more': '+ Add More',
      'loading': 'Loading...',

      'withdraw': 'Withdraw',
      'bank_accounts': 'Bank Accounts',
      'mfs': 'MFS',
      'no_accounts_found': 'No Accounts Found',
      'bank_name': 'Bank Name',
      'branch': 'Branch',
      'district': 'District',
      'account': 'A/C',
      'add_new_account': 'ADD NEW ACCOUNT',

      // Auth
      'welcome': 'Welcome',
      'enter_phone_number': 'Enter phone number',
      'continue': 'Continue',
      'by_continuing': 'By continuing, you agree to our ',
      'terms_conditions': 'Terms & Conditions',
      'privacy_policy_applies': 'Privacy Policy applies',
      'verify_its_you': "Verify it's you",
      'otp_sent_to': 'An SMS with OTP has been sent to',
      'resend_otp_q': 'Resend OTP? ',
      'resend': 'Resend',
      'verify': 'Verify',

      // More
      'payment': 'PAYMENT',
      'payout_accounts': 'Payout Accounts',
      'earning_history': 'Earning History',
      'settings': 'SETTINGS',
      'change_mobile_number': 'Change Mobile Number',
      'language': 'Language',
      'profile': 'Profile',
      'legal': 'LEGAL',
      'terms_and_conditions': 'Terms and Conditions',
      'privacy_policy': 'Privacy Policy',
      'payment_terms': 'Payment Terms',
      'help': 'HELP',
      'emergency_call': 'Emergency Call',
      'logout': 'Logout',

      // Notifications
      'notifications': 'Notifications',
      'new_appointment': 'New Appointment',
      'new_appointment_message':
          'You have a new appointment request from a patient.',
      'two_hours_ago': '2 hours ago',

      // Withdraw amount
      'withdraw_amount': 'Withdraw Amount',
      'enter_amount': 'Enter amount',
      'submit': 'Submit',
      'error': 'Error',
      'success': 'Success',
      'valid_amount': 'Please enter a valid amount',
      'insufficient_balance': 'Insufficient balance',
      'withdraw_request_sent': 'Withdraw request sent',
      'withdraw_failed': 'Withdraw failed',

      // Transactions / Earnings
      'earning': 'Earning',
      'balance': 'Balance',
      'total_earning': 'Total Earning',
      'amount': 'Amount',
      'transaction': 'Transaction',
      'no_transactions_found': 'No transactions found',

      // Prescriptions list
      'prescriptions': 'Prescriptions',
      'no_prescriptions_found': 'No prescriptions found',

      // Edit profile
      'full_name': 'Full name',
      'about': 'About',
      'experience_years': 'Experience (Years)',
      'bmdc_code': 'BMDC Code',
      'male': 'Male',
      'female': 'Female',
      'update': 'Update',
      'profile_updated': 'Profile updated',

      // Appointments
      'past_appointments': 'Past Appointments',
      'no_past_appointments': 'No Past Appointments',
      'upcoming_appointments': 'Upcoming Appointments',
      'no_upcoming_appointments': 'No Upcoming Appointments',
      'no_appointments_found': 'No appointments found',
      'unknown_patient': 'Unknown Patient',
      'just_now': 'Just now',
      'minutes_ago': 'minutes ago',
      'hours_ago': 'hours ago',
      'days_ago': 'days ago',

      // Accounts widgets
      'no_bank_accounts_found': 'No Bank Accounts Found',
      'no_mfs_accounts_found': 'No MFS Accounts Found',
      'account_name': 'Account Name',
      'account_number': 'Account Number',
      'mfs_type': 'MFS Type',

      // Call end
      'call_ended': 'Call Ended',
      'thank_you_service': 'Thank you for using our service',
      'back_to_home': 'Back to Home',

      // Common
      'otp': 'OTP',
      'unknown_error': 'Unknown error',
      'something_went_wrong': 'Something went wrong',
      'network_error': 'Network error',

      // OTP flow / auth
      'enter_otp': 'Enter OTP',
      'otp_verified_token_saved': 'OTP verified and token saved!',
      'otp_verification_failed': 'OTP verification failed',
      'otp_resent_successfully': 'OTP resent successfully',
      'failed_to_resend_otp': 'Failed to resend OTP',
      'successfully_logged_out': 'Successfully logged out',

      // Withdraw add accounts
      'please_fill_all_fields': 'Please fill all fields',
      'failed_to_load_mfs_list': 'Failed to load MFS list',
      'failed_to_fetch_mfs_list': 'Failed to fetch MFS list',
      'please_select_mfs_name': 'Please select MFS name',
      'please_enter_account_name': 'Please enter account name',
      'please_enter_account_number': 'Please enter account number',
      'mfs_account_added_successfully': 'MFS account added successfully',

      // Call
      'failed_to_notify_patient': 'Failed to notify patient',
      'submit_failed': 'Submit failed',
      'patient_did_not_pick_up': 'Patient did not pick up the call',

      // App test
      'no_app_test_result': "Patient doesn't have any app test result",
      'visual_acuity': 'Visual Acuity',
      'near_vision': 'Near Vision',
      'color_vision': 'Color Vision',
      'amd': 'AMD',
      'left_eye': 'Left Eye',
      'right_eye': 'Right Eye',

      // Clinical tests
      'no_clinical_tests_found': 'No Clinical Tests Found',
      'untitled': 'Untitled',

      // Prescription tile
      'no_title': 'No Title',
      'open_download': 'Open/Download',

      // System
      'firebase_init_failed': 'Failed to initialize Firebase.',

      // Status
      'my_Status': 'My Status',
      'online': 'Online',
      'offline': 'Offline',

      // Misc
      'na': 'N/A',

      // Call messages
      'patient_rejected_call': 'Patient rejected the call',
      'patient_ended_call': 'Patient ended the call',
      'patient_disconnected_call': 'Patient disconnected the call',

      // Call options bottom sheet
      'patient_options': 'Patient Options',
      'previous_prescriptions': 'Previous\nPrescriptions',
      'test_result': 'Test\nresult',
      'patient_id_missing': 'Patient ID missing',
      'appointment_data_missing': 'Appointment data missing',
      'appointment_reason': 'Appointment Reason',
      'no_reason_provided': 'No reason provided',

      // Prescription flow validations
      'please_enter_chief_complaints': 'Please enter chief complaints',
      'please_enter_diagnosis': 'Please enter diagnosis',
      'please_enter_investigations': 'Please enter investigations',
      'please_enter_surgery_details': 'Please enter surgery details',
      'medicine_required': 'Medicine Required',
      'please_add_one_medicine': 'Please add at least one medicine',
      'please_enter_medicine_name': 'Please enter medicine name',
      'please_enter_medicine_notes': 'Please enter medicine notes',
      'please_enter_referred_to': 'Please enter referred to',


      // Delete account dialog
'delete_account': 'Delete Account',
'are_you_sure': 'Are you sure you want to delete this account?',
'cancel': 'Cancel',
'delete': 'Delete',




  'name_required': 'Name is required',
  'about_required': 'About field is required',
  'experience_required': 'Experience is required',
  'gender_required': 'Please select gender',
  'specialty_required': 'Please select specialty',
  'hospital_required': 'Please select hospital',
  'profile_create_failed': 'Profile creation failed',

    },

    'bn': {
      'doctor_profile': 'ডাক্টর প্রোফাইল',
      'no_data': 'কোনো তথ্য নেই',
      'unknown': 'অজানা',


  'name_required': 'নাম দেওয়া আবশ্যক',
  'about_required': 'About ফিল্ড পূরণ করুন',
  'experience_required': 'অভিজ্ঞতা দেওয়া আবশ্যক',
  'gender_required': 'লিঙ্গ নির্বাচন করুন',
  'specialty_required': 'বিশেষজ্ঞতা নির্বাচন করুন',
  'hospital_required': 'হাসপাতাল নির্বাচন করুন',
  'profile_create_failed': 'প্রোফাইল তৈরি ব্যর্থ হয়েছে',
      // Basic Info
      'basic_info': 'মৌলিক তথ্য',
      'gender': 'লিঙ্গ',
      'experience': 'অভিজ্ঞতা',
      'years': 'বছর',

      // Specialty
      'specialties': 'বিশেষত্ব',
      'no_specialty': 'কোনো বিশেষত্ব নেই',

      // Hospitals
      'hospitals': 'হাসপাতাল',
      'no_hospital': 'হাসপাতালের তথ্য নেই',

// Delete account dialog
'delete_account': 'অ্যাকাউন্ট মুছুন',
'are_you_sure': 'আপনি কি নিশ্চিত এই অ্যাকাউন্টটি মুছে ফেলতে চান?',
'cancel': 'বাতিল',
'delete': 'মুছুন',

      // Button
      'edit_profile': 'প্রোফাইল সম্পাদনা করুন',

      'calling': 'কল করা হচ্ছে...',
      'prescription': 'প্রেসক্রিপশন',
      'overview': 'সারসংক্ষেপ',
      'confirm': 'নিশ্চিত করুন',
      'back_to_edit': 'এডিট করতে ফিরে যান',
      'chief_complaints': 'প্রধান অভিযোগ',
      'diagnosis': 'রোগ নির্ণয়',
      'investigations': 'পরীক্ষা-নিরীক্ষা',
      'surgery': 'সার্জারি',
      'medicine': 'ওষুধ',
      'medicine_name': 'ওষুধের নাম',
      'notes': 'নির্দেশনা',
      'follow_up_date': 'ফলো-আপ তারিখ',
      'referred_to': 'রেফার করা হয়েছে',
      'add_more': '+ আরও যোগ করুন',
      'loading': 'লোড হচ্ছে...',

      'withdraw': 'টাকা উত্তোলন',
      'bank_accounts': 'ব্যাংক অ্যাকাউন্ট',
      'mfs': 'এমএফএস',
      'no_accounts_found': 'কোনো অ্যাকাউন্ট পাওয়া যায়নি',
      'bank_name': 'ব্যাংকের নাম',
      'branch': 'শাখা',
      'district': 'জেলা',
      'account': 'অ্যাকাউন্ট',
      'add_new_account': 'নতুন অ্যাকাউন্ট যোগ করুন',

      // Auth
      'welcome': 'স্বাগতম',
      'enter_phone_number': 'ফোন নম্বর লিখুন',
      'continue': 'চালিয়ে যান',
      'by_continuing': 'চালিয়ে গেলে আপনি আমাদের ',
      'terms_conditions': 'শর্তাবলি ও নীতিমালা',
      'privacy_policy_applies': 'গোপনীয়তা নীতি প্রযোজ্য',
      'verify_its_you': 'আপনি কি নিশ্চিত?',
      'otp_sent_to': 'OTP সহ একটি SMS পাঠানো হয়েছে',
      'resend_otp_q': 'OTP আবার পাঠাবেন? ',
      'resend': 'আবার পাঠান',
      'verify': 'যাচাই করুন',

      // More
      'payment': 'পেমেন্ট',
      'payout_accounts': 'পেআউট অ্যাকাউন্ট',
      'earning_history': 'আয়ের ইতিহাস',
      'settings': 'সেটিংস',
      'change_mobile_number': 'মোবাইল নম্বর পরিবর্তন',
      'language': 'ভাষা',
      'profile': 'প্রোফাইল',
      'legal': 'আইনি',
      'terms_and_conditions': 'শর্তাবলি',
      'privacy_policy': 'গোপনীয়তা নীতি',
      'payment_terms': 'পেমেন্ট শর্তাবলি',
      'help': 'সহায়তা',
      'emergency_call': 'জরুরি কল',
      'logout': 'লগ আউট',

      // Notifications
      'notifications': 'নোটিফিকেশন',
      'new_appointment': 'নতুন অ্যাপয়েন্টমেন্ট',
      'new_appointment_message':
          'একজন রোগীর নতুন অ্যাপয়েন্টমেন্ট অনুরোধ এসেছে।',
      'two_hours_ago': '২ ঘণ্টা আগে',

      // Withdraw amount
      'withdraw_amount': 'উত্তোলনের পরিমাণ',
      'enter_amount': 'পরিমাণ লিখুন',
      'submit': 'জমা দিন',
      'error': 'ত্রুটি',
      'success': 'সফল',
      'valid_amount': 'সঠিক পরিমাণ লিখুন',
      'insufficient_balance': 'অপর্যাপ্ত ব্যালেন্স',
      'withdraw_request_sent': 'উত্তোলনের অনুরোধ পাঠানো হয়েছে',
      'withdraw_failed': 'উত্তোলন ব্যর্থ হয়েছে',

      // Transactions / Earnings
      'earning': 'আয়',
      'balance': 'ব্যালেন্স',
      'total_earning': 'মোট আয়',
      'amount': 'পরিমাণ',
      'transaction': 'লেনদেন',
      'no_transactions_found': 'কোনো লেনদেন পাওয়া যায়নি',

      // Prescriptions list
      'prescriptions': 'প্রেসক্রিপশনসমূহ',
      'no_prescriptions_found': 'কোনো প্রেসক্রিপশন পাওয়া যায়নি',

      // Edit profile
      'full_name': 'পূর্ণ নাম',
      'about': 'পরিচিতি',
      'experience_years': 'অভিজ্ঞতা (বছর)',
      'bmdc_code': 'BMDC কোড',
      'male': 'পুরুষ',
      'female': 'নারী',
      'update': 'আপডেট করুন',
      'profile_updated': 'প্রোফাইল আপডেট হয়েছে',

      // Appointments
      'past_appointments': 'পূর্বের অ্যাপয়েন্টমেন্ট',
      'no_past_appointments': 'কোনো পূর্বের অ্যাপয়েন্টমেন্ট নেই',
      'upcoming_appointments': 'আসন্ন অ্যাপয়েন্টমেন্ট',
      'no_upcoming_appointments': 'কোনো আসন্ন অ্যাপয়েন্টমেন্ট নেই',
      'no_appointments_found': 'কোনো অ্যাপয়েন্টমেন্ট পাওয়া যায়নি',
      'unknown_patient': 'অজানা রোগী',
      'just_now': 'এইমাত্র',
      'minutes_ago': 'মিনিট আগে',
      'hours_ago': 'ঘণ্টা আগে',
      'days_ago': 'দিন আগে',

      // Accounts widgets
      'no_bank_accounts_found': 'কোনো ব্যাংক অ্যাকাউন্ট পাওয়া যায়নি',
      'no_mfs_accounts_found': 'কোনো MFS অ্যাকাউন্ট পাওয়া যায়নি',
      'account_name': 'অ্যাকাউন্টের নাম',
      'account_number': 'অ্যাকাউন্ট নম্বর',
      'mfs_type': 'MFS টাইপ',

      // Call end
      'call_ended': 'কল শেষ হয়েছে',
      'thank_you_service': 'আমাদের সেবা ব্যবহারের জন্য ধন্যবাদ',
      'back_to_home': 'হোমে ফিরে যান',

      // Common
      'otp': 'ওটিপি',
      'unknown_error': 'অজানা ত্রুটি',
      'something_went_wrong': 'কিছু একটা সমস্যা হয়েছে',
      'network_error': 'নেটওয়ার্ক সমস্যা',

      // OTP flow / auth
      'enter_otp': 'ওটিপি লিখুন',
      'otp_verified_token_saved':
          'ওটিপি যাচাই হয়েছে এবং টোকেন সংরক্ষণ করা হয়েছে',
      'otp_verification_failed': 'ওটিপি যাচাই ব্যর্থ হয়েছে',
      'otp_resent_successfully': 'ওটিপি আবার পাঠানো হয়েছে',
      'failed_to_resend_otp': 'ওটিপি আবার পাঠানো যায়নি',
      'successfully_logged_out': 'সফলভাবে লগ আউট হয়েছে',

      // Withdraw add accounts
      'please_fill_all_fields': 'সবগুলো ঘর পূরণ করুন',
      'failed_to_load_mfs_list': 'MFS তালিকা লোড করা যায়নি',
      'failed_to_fetch_mfs_list': 'MFS তালিকা আনতে ব্যর্থ',
      'please_select_mfs_name': 'MFS নাম নির্বাচন করুন',
      'please_enter_account_name': 'অ্যাকাউন্টের নাম লিখুন',
      'please_enter_account_number': 'অ্যাকাউন্ট নম্বর লিখুন',
      'mfs_account_added_successfully': 'MFS অ্যাকাউন্ট সফলভাবে যোগ হয়েছে',

      // Call
      'failed_to_notify_patient': 'রোগীকে জানাতে ব্যর্থ হয়েছে',
      'submit_failed': 'জমা দেওয়া ব্যর্থ হয়েছে',
      'patient_did_not_pick_up': 'রোগী কলটি ধরেননি',

      // App test
      'no_app_test_result': 'রোগীর কোনো অ্যাপ টেস্ট ফলাফল নেই',
      'visual_acuity': 'দৃষ্টিক্ষমতা',
      'near_vision': 'নিকট দৃষ্টি',
      'color_vision': 'রঙ দেখার ক্ষমতা',
      'amd': 'এএমডি',
      'left_eye': 'বাম চোখ',
      'right_eye': 'ডান চোখ',

      // Clinical tests
      'no_clinical_tests_found': 'কোনো ক্লিনিক্যাল টেস্ট পাওয়া যায়নি',
      'untitled': 'শিরোনাম নেই',

      // Prescription tile
      'no_title': 'শিরোনাম নেই',
      'open_download': 'খুলুন/ডাউনলোড',

      // System
      'firebase_init_failed': 'Firebase চালু করা যায়নি।',

      // Status
      'my_status': 'আমার স্ট্যাটাস',
      'online': 'অনলাইন',
      'offline': 'অফলাইন',

      // Misc
      'na': 'প্রযোজ্য নয়',

      // Call messages
      'patient_rejected_call': 'রোগী কলটি প্রত্যাখ্যান করেছেন',
      'patient_ended_call': 'রোগী কলটি শেষ করেছেন',
      'patient_disconnected_call': 'রোগীর সংযোগ বিচ্ছিন্ন হয়েছে',

      // Call options bottom sheet
      'patient_options': 'রোগীর অপশন',
      'previous_prescriptions': 'আগের\nপ্রেসক্রিপশন',
      'test_result': 'টেস্ট\nরেজাল্ট',
      'patient_id_missing': 'রোগীর আইডি পাওয়া যায়নি',
      'appointment_data_missing': 'অ্যাপয়েন্টমেন্টের তথ্য পাওয়া যায়নি',
      'appointment_reason': 'অ্যাপয়েন্টমেন্টের কারণ',
      'no_reason_provided': 'কোনো কারণ দেওয়া হয়নি',

      // Prescription flow validations
      'please_enter_chief_complaints': 'প্রধান অভিযোগ লিখুন',
      'please_enter_diagnosis': 'রোগ নির্ণয় লিখুন',
      'please_enter_investigations': 'ইনভেস্টিগেশন লিখুন',
      'please_enter_surgery_details': 'সার্জারির বিবরণ লিখুন',
      'medicine_required': 'ওষুধ প্রয়োজন',
      'please_add_one_medicine': 'কমপক্ষে একটি ওষুধ যোগ করুন',
      'please_enter_medicine_name': 'ওষুধের নাম লিখুন',
      'please_enter_medicine_notes': 'ওষুধের নির্দেশনা লিখুন',
      'please_enter_referred_to': 'রেফার্ড টু লিখুন',
    },
  };
}
