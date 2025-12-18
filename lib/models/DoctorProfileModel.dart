

// import 'dart:convert';

// class GetDoctorApiResponse {
//   String? status;
//   String? message;
//   DoctorProfileData? data;

//   GetDoctorApiResponse({this.status, this.message, this.data});

//   factory GetDoctorApiResponse.fromMap(Map<String, dynamic> map) {
//     return GetDoctorApiResponse(
//       status: map['status']?.toString(),
//       message: map['message']?.toString(),
//       data: map['data'] != null
//           ? DoctorProfileData.fromMap(map['data'] as Map<String, dynamic>)
//           : null,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'status': status,
//       'message': message,
//       'data': data?.toMap(),
//     };
//   }

//   factory GetDoctorApiResponse.fromJson(String source) =>
//       GetDoctorApiResponse.fromMap(json.decode(source));

//   String toJson() => json.encode(toMap());
// }

// class DoctorProfileData {
//   String? id;
//   String? name;
//   String? phone;
//   String? dialCode;
//   String? photo;
//   String? about;
//   String? bmdcCode;
//   String? gender;
//   String? availabilityStatus;
//   String? averageRating;
//   String? averageConsultancyTime;
//   String? averageResponseTime;
//   String? consultationFee;
//   String? followupFee;
//   String? experienceInYear;
//   String? ratingCount;
//   String? totalPatientCount;
//   String? createdAt;
//   String? updatedAt;

//   List<DoctorSpecialty> specialty;
//   List<DoctorHospital> hospital;
//   List<DoctorExperience>? experiences;

//   DoctorProfileData({
//     this.id,
//     this.name,
//     this.phone,
//     this.dialCode,
//     this.photo,
//     this.about,
//     this.bmdcCode,
//     this.gender,
//     this.availabilityStatus,
//     this.averageRating,
//     this.averageConsultancyTime,
//     this.averageResponseTime,
//     this.consultationFee,
//     this.followupFee,
//     this.experienceInYear,
//     this.ratingCount,
//     this.totalPatientCount,
//     this.createdAt,
//     this.updatedAt,
//     this.specialty = const [],
//     this.hospital = const [],
//     this.experiences,
//   });

//   factory DoctorProfileData.fromMap(Map<String, dynamic> map) {
//     return DoctorProfileData(
//       id: map['_id']?.toString() ?? map['id']?.toString(),
//       name: map['name']?.toString(),
//       phone: map['phone']?.toString(),
//       dialCode: map['dialCode']?.toString(),
//       photo: map['photo']?.toString(),
//       about: map['about']?.toString(),
//       bmdcCode: map['bmdcCode']?.toString(),
//       gender: map['gender']?.toString(),
//       availabilityStatus: map['availabilityStatus']?.toString(),
//       averageRating: map['averageRating']?.toString(),
//       averageConsultancyTime: map['averageConsultancyTime']?.toString(),
//       averageResponseTime: map['averageResponseTime']?.toString(),
//       consultationFee: map['consultationFee']?.toString(),
//       followupFee: map['followupFee']?.toString(),
//       experienceInYear: map['experienceInYear']?.toString(),
//       ratingCount: map['ratingCount']?.toString(),
//       totalPatientCount: map['totalPatientCount']?.toString(),
//       createdAt: map['createdAt']?.toString(),
//       updatedAt: map['updatedAt']?.toString(),
//       specialty: map['specialty'] != null
//           ? List<DoctorSpecialty>.from(
//               (map['specialty'] as List)
//                   .map((x) => DoctorSpecialty.fromMap(x)))
//           : [],
//       hospital: map['hospital'] != null
//           ? List<DoctorHospital>.from(
//               (map['hospital'] as List).map((x) => DoctorHospital.fromMap(x)))
//           : [],
//       experiences: map['experiences'] != null
//           ? List<DoctorExperience>.from(
//               (map['experiences'] as List)
//                   .map((x) => DoctorExperience.fromMap(x)))
//           : null,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'name': name,
//       'phone': phone,
//       'dialCode': dialCode,
//       'photo': photo,
//       'about': about,
//       'bmdcCode': bmdcCode,
//       'gender': gender,
//       'availabilityStatus': availabilityStatus,
//       'averageRating': averageRating,
//       'averageConsultancyTime': averageConsultancyTime,
//       'averageResponseTime': averageResponseTime,
//       'consultationFee': consultationFee,
//       'followupFee': followupFee,
//       'experienceInYear': experienceInYear,
//       'ratingCount': ratingCount,
//       'totalPatientCount': totalPatientCount,
//       'createdAt': createdAt,
//       'updatedAt': updatedAt,
//       'specialty': specialty.map((x) => x.toMap()).toList(),
//       'hospital': hospital.map((x) => x.toMap()).toList(),
//       'experiences': experiences?.map((x) => x.toMap()).toList(),
//     };
//   }

//   factory DoctorProfileData.fromJson(String source) =>
//       DoctorProfileData.fromMap(json.decode(source));
// }

// // --------------------------
// // Specialty Model
// class DoctorSpecialty {
//   String? title;
//   String? symptoms;

//   DoctorSpecialty({this.title, this.symptoms});

//   factory DoctorSpecialty.fromMap(Map<String, dynamic> map) {
//     return DoctorSpecialty(
//       title: map['title']?.toString(),
//       symptoms: map['symptoms']?.toString(),
//     );
//   }

//   Map<String, dynamic> toMap() => {
//         'title': title,
//         'symptoms': symptoms,
//       };
// }

// // --------------------------
// // Hospital Model
// class DoctorHospital {
//   String? id;
//   String? name;
//   String? address;

//   DoctorHospital({this.id, this.name, this.address});

//   factory DoctorHospital.fromMap(Map<String, dynamic> map) {
//     return DoctorHospital(
//       id: map['_id']?.toString(),
//       name: map['name']?.toString(),
//       address: map['address']?.toString(),
//     );
//   }

//   Map<String, dynamic> toMap() => {
//         'id': id,
//         'name': name,
//         'address': address,
//       };
// }

// // --------------------------
// // Experience Model
// class DoctorExperience {
//   String? hospitalName;
//   String? startDate;
//   String? endDate;
//   String? position;

//   DoctorExperience({this.hospitalName, this.startDate, this.endDate, this.position});

//   factory DoctorExperience.fromMap(Map<String, dynamic> map) {
//     return DoctorExperience(
//       hospitalName: map['hospitalName']?.toString(),
//       startDate: map['startDate']?.toString(),
//       endDate: map['endDate']?.toString(),
//       position: map['position']?.toString(),
//     );
//   }

//   Map<String, dynamic> toMap() => {
//         'hospitalName': hospitalName,
//         'startDate': startDate,
//         'endDate': endDate,
//         'position': position,
//       };
// }
import 'dart:convert';

class GetDoctorApiResponse {
  String? status;
  String? message;
  DoctorProfileData? data;

  GetDoctorApiResponse({this.status, this.message, this.data});

  factory GetDoctorApiResponse.fromMap(Map<String, dynamic> map) {
    return GetDoctorApiResponse(
      status: map['status']?.toString(),
      message: map['message']?.toString(),
      data: map['data'] != null
          ? DoctorProfileData.fromMap(map['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'data': data?.toMap(),
    };
  }

  factory GetDoctorApiResponse.fromJson(String source) =>
      GetDoctorApiResponse.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}

// =======================================================================
//                         DOCTOR PROFILE DATA
// =======================================================================

class DoctorProfileData {
  String? id;
  String? name;
  String? phone;
  String? dialCode;
  String? photo;
  String? about;
  String? bmdcCode;
  String? gender;
  String? availabilityStatus;
  String? averageRating;
  String? averageConsultancyTime;
  String? averageResponseTime;
  String? consultationFee;
  String? followupFee;
  String? experienceInYear;
  String? ratingCount;
  String? totalPatientCount;
  String? createdAt;
  String? updatedAt;

  List<DoctorSpecialty> specialty;
  List<DoctorHospital> hospital;
  List<DoctorExperience>? experiences;

  DoctorProfileData({
    this.id,
    this.name,
    this.phone,
    this.dialCode,
    this.photo,
    this.about,
    this.bmdcCode,
    this.gender,
    this.availabilityStatus,
    this.averageRating,
    this.averageConsultancyTime,
    this.averageResponseTime,
    this.consultationFee,
    this.followupFee,
    this.experienceInYear,
    this.ratingCount,
    this.totalPatientCount,
    this.createdAt,
    this.updatedAt,
    this.specialty = const [],
    this.hospital = const [],
    this.experiences,
  });

  // -------------------------------------------------------------------
  //                           COPY WITH
  // -------------------------------------------------------------------
  DoctorProfileData copyWith({
    String? id,
    String? name,
    String? phone,
    String? dialCode,
    String? photo,
    String? about,
    String? bmdcCode,
    String? gender,
    String? availabilityStatus,
    String? averageRating,
    String? averageConsultancyTime,
    String? averageResponseTime,
    String? consultationFee,
    String? followupFee,
    String? experienceInYear,
    String? ratingCount,
    String? totalPatientCount,
    String? createdAt,
    String? updatedAt,
    List<DoctorSpecialty>? specialty,
    List<DoctorHospital>? hospital,
    List<DoctorExperience>? experiences,
  }) {
    return DoctorProfileData(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      dialCode: dialCode ?? this.dialCode,
      photo: photo ?? this.photo,
      about: about ?? this.about,
      bmdcCode: bmdcCode ?? this.bmdcCode,
      gender: gender ?? this.gender,
      availabilityStatus: availabilityStatus ?? this.availabilityStatus,
      averageRating: averageRating ?? this.averageRating,
      averageConsultancyTime:
          averageConsultancyTime ?? this.averageConsultancyTime,
      averageResponseTime: averageResponseTime ?? this.averageResponseTime,
      consultationFee: consultationFee ?? this.consultationFee,
      followupFee: followupFee ?? this.followupFee,
      experienceInYear: experienceInYear ?? this.experienceInYear,
      ratingCount: ratingCount ?? this.ratingCount,
      totalPatientCount: totalPatientCount ?? this.totalPatientCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      specialty: specialty ?? this.specialty,
      hospital: hospital ?? this.hospital,
      experiences: experiences ?? this.experiences,
    );
  }

  // -------------------------------------------------------------------
  //                           FROM MAP
  // -------------------------------------------------------------------
  factory DoctorProfileData.fromMap(Map<String, dynamic> map) {
    return DoctorProfileData(
      id: map['_id']?.toString() ?? map['id']?.toString(),
      name: map['name']?.toString(),
      phone: map['phone']?.toString(),
      dialCode: map['dialCode']?.toString(),
      photo: map['photo']?.toString(),
      about: map['about']?.toString(),
      bmdcCode: map['bmdcCode']?.toString(),
      gender: map['gender']?.toString(),
      availabilityStatus: map['availabilityStatus']?.toString(),
      averageRating: map['averageRating']?.toString(),
      averageConsultancyTime: map['averageConsultancyTime']?.toString(),
      averageResponseTime: map['averageResponseTime']?.toString(),
      consultationFee: map['consultationFee']?.toString(),
      followupFee: map['followupFee']?.toString(),
      experienceInYear: map['experienceInYear']?.toString(),
      ratingCount: map['ratingCount']?.toString(),
      totalPatientCount: map['totalPatientCount']?.toString(),
      createdAt: map['createdAt']?.toString(),
      updatedAt: map['updatedAt']?.toString(),
      specialty: map['specialty'] != null
          ? List<DoctorSpecialty>.from(
              (map['specialty'] as List)
                  .map((x) => DoctorSpecialty.fromMap(x)))
          : [],
      hospital: map['hospital'] != null
          ? List<DoctorHospital>.from(
              (map['hospital'] as List)
                  .map((x) => DoctorHospital.fromMap(x)))
          : [],
      experiences: map['experiences'] != null
          ? List<DoctorExperience>.from(
              (map['experiences'] as List)
                  .map((x) => DoctorExperience.fromMap(x)))
          : null,
    );
  }

  // -------------------------------------------------------------------
  //                           TO MAP
  // -------------------------------------------------------------------
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'dialCode': dialCode,
      'photo': photo,
      'about': about,
      'bmdcCode': bmdcCode,
      'gender': gender,
      'availabilityStatus': availabilityStatus,
      'averageRating': averageRating,
      'averageConsultancyTime': averageConsultancyTime,
      'averageResponseTime': averageResponseTime,
      'consultationFee': consultationFee,
      'followupFee': followupFee,
      'experienceInYear': experienceInYear,
      'ratingCount': ratingCount,
      'totalPatientCount': totalPatientCount,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'specialty': specialty.map((x) => x.toMap()).toList(),
      'hospital': hospital.map((x) => x.toMap()).toList(),
      'experiences': experiences?.map((x) => x.toMap()).toList(),
    };
  }

  factory DoctorProfileData.fromJson(String source) =>
      DoctorProfileData.fromMap(json.decode(source));
}

// =======================================================================
//                              SPECIALTY
// =======================================================================

class DoctorSpecialty {
  String? title;
  String? symptoms;

  DoctorSpecialty({this.title, this.symptoms});

  factory DoctorSpecialty.fromMap(Map<String, dynamic> map) {
    return DoctorSpecialty(
      title: map['title']?.toString(),
      symptoms: map['symptoms']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'symptoms': symptoms,
    };
  }
}

// =======================================================================
//                              HOSPITAL
// =======================================================================

class DoctorHospital {
  String? id;
  String? name;
  String? address;

  DoctorHospital({this.id, this.name, this.address});

  factory DoctorHospital.fromMap(Map<String, dynamic> map) {
    return DoctorHospital(
      id: map['_id']?.toString(),
      name: map['name']?.toString(),
      address: map['address']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
    };
  }
}

// =======================================================================
//                              EXPERIENCE
// =======================================================================

class DoctorExperience {
  String? hospitalName;
  String? startDate;
  String? endDate;
  String? position;

  DoctorExperience({
    this.hospitalName,
    this.startDate,
    this.endDate,
    this.position,
  });

  factory DoctorExperience.fromMap(Map<String, dynamic> map) {
    return DoctorExperience(
      hospitalName: map['hospitalName']?.toString(),
      startDate: map['startDate']?.toString(),
      endDate: map['endDate']?.toString(),
      position: map['position']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hospitalName': hospitalName,
      'startDate': startDate,
      'endDate': endDate,
      'position': position,
    };
  }
}
