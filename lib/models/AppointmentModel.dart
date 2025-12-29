

import 'dart:convert';
class GetAppointmentListApiResponse {
  String status;
  String message;
  AppointmentApiData? data;

  GetAppointmentListApiResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory GetAppointmentListApiResponse.fromMap(Map<String, dynamic> map) {
    return GetAppointmentListApiResponse(
      status: map['status'] ?? '',
      message: map['message'] ?? '',
      data: map['data'] != null ? AppointmentApiData.fromMap(map['data']) : null,
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'message': message,
        'data': data?.toMap(),
      };

  factory GetAppointmentListApiResponse.fromJson(String source) =>
      GetAppointmentListApiResponse.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}

class AppointmentApiData {
  List<Appointment>? docs;
  int? totalDocs;
  int? limit;
  int? page;
  int? totalPages;

  AppointmentApiData({
    this.docs,
    this.totalDocs,
    this.limit,
    this.page,
    this.totalPages,
  });

  factory AppointmentApiData.fromMap(Map<String, dynamic> map) {
    return AppointmentApiData(
      docs: map['docs'] != null
          ? List<Appointment>.from(
              (map['docs'] as List).map((x) => Appointment.fromMap(x)))
          : [],
      totalDocs: map['totalDocs'],
      limit: map['limit'],
      page: map['page'],
      totalPages: map['totalPages'],
    );
  }

  Map<String, dynamic> toMap() => {
        'docs': docs?.map((x) => x.toMap()).toList(),
        'totalDocs': totalDocs,
        'limit': limit,
        'page': page,
        'totalPages': totalPages,
      };

  factory AppointmentApiData.fromJson(String source) =>
      AppointmentApiData.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());
}

class Appointment {
  String? id;
  String? appointmentType;
  AppointmentPatient? patient;
  AppointmentDoctor? doctor;

  // Basic Info
  double? weight;
  int? age;
  String? reason;
  String? description;
  


  // Payment
  String? paymentId;
  String? paymentMethod;
  String? totalAmount;
  String? fee;
  String? vat;
  String? discount;
  String? grandTotal;
  String? promoCode;

  // Files
  List<String>? eyePhotos;
  List<String>? additionalFiles;

  // Status & other
  String? date;
  String? status;
  bool? isPrescribed;
  bool? hasRating;
  String? doctorAgoraToken;
  String? patientAgoraToken;
  String? createdAt;

  // 🔥 Converted DateTime in local time
  DateTime? appointmentDate;


  Appointment({
    this.id,
    this.appointmentType,
    this.patient,
    this.doctor,
    this.weight,
    this.age,
    this.reason,
    this.description,
    this.paymentId,
    this.paymentMethod,
    this.totalAmount,
    this.fee,
    this.vat,
    this.discount,
    this.grandTotal,
    this.promoCode,
    this.eyePhotos,
    this.additionalFiles,
    this.date,
    this.status,
    this.isPrescribed,
    this.hasRating,
    this.doctorAgoraToken,
    this.patientAgoraToken,
    this.createdAt,
    this.appointmentDate,
 
  
  });

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['_id']?.toString(),
      appointmentType: map['appointmentType']?.toString(),
      patient: map['patient'] != null
          ? AppointmentPatient.fromMap(map['patient'])
          : null,
      doctor: map['doctor'] != null
          ? AppointmentDoctor.fromMap(map['doctor'])
          : null,
      weight: map['weight'] != null ? double.tryParse(map['weight'].toString()) : null,
      age: map['age'] as int?,
      reason: map['reason']?.toString(),
      description: map['description']?.toString(),
      paymentId: map['paymentId']?.toString(),
      paymentMethod: map['paymentMethod']?.toString(),
      totalAmount: map['totalAmount']?.toString(),
      fee: map['fee']?.toString(),
      vat: map['vat']?.toString(),
      discount: map['discount']?.toString(),
      grandTotal: map['grandTotal']?.toString(),
      promoCode: map['promoCode']?.toString(),
      eyePhotos: map['eyePhotos'] != null ? List<String>.from(map['eyePhotos']) : [],
      additionalFiles: map['additionalFiles'] != null ? List<String>.from(map['additionalFiles']) : [],
      date: map['date']?.toString(),
      status: map['status']?.toString(),
       
      isPrescribed: map['isPrescribed'] ?? false,
      hasRating: map['hasRating'] ?? false,
      doctorAgoraToken: map['doctorAgoraToken']?.toString(),
      patientAgoraToken: map['patientAgoraToken']?.toString(),
      createdAt: map['createdAt']?.toString(),
  

  
      appointmentDate: map['date'] != null
          ? DateTime.tryParse(map['date'])?.toLocal()
          : null,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'appointmentType': appointmentType,
        'patient': patient?.toMap(),
        'doctor': doctor?.toMap(),
        'weight': weight,
        'age': age,
      
        'reason': reason,
        'description': description,
        'paymentId': paymentId,
        'paymentMethod': paymentMethod,
        'totalAmount': totalAmount,
        'fee': fee,
        'vat': vat,
        'discount': discount,
        'grandTotal': grandTotal,
        'promoCode': promoCode,
        'eyePhotos': eyePhotos,
        'additionalFiles': additionalFiles,
        'date': date,
        'status': status,
        'isPrescribed': isPrescribed,
        'hasRating': hasRating,
        'doctorAgoraToken': doctorAgoraToken,
        'patientAgoraToken': patientAgoraToken,
        'createdAt': createdAt,
 
        // 'appointmentDate': appointmentDate?.toIso8601String(),
    
      };
}

class AppointmentDoctor {
  String? id;
  String? name;
  String? phone;

  AppointmentDoctor({this.id, this.name, this.phone});

  factory AppointmentDoctor.fromMap(Map<String, dynamic> map) {
    return AppointmentDoctor(
      id: map['_id']?.toString(),
      name: map['name']?.toString(),
      phone: map['phone']?.toString(),
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'phone': phone,
      };
}

class AppointmentPatient {
  String? id;
  String? name;
  String? phone;
  String? photo;
  String? gender;

  AppointmentPatient({this.id, this.name, this.phone, this.photo,this.gender,});

  factory AppointmentPatient.fromMap(Map<String, dynamic> map) {
    return AppointmentPatient(
      id: map['_id']?.toString(),
      name: map['name']?.toString(),
      phone: map['phone']?.toString(),
      photo: map['photo']?.toString(),
      gender: map['gender']?.toString()
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'phone': phone,
        'photo': photo,
        'gender': gender
      };
}
