

import 'dart:convert';

class AppointmentDetailsResponseModel {
  String status;
  String message;
  AppointmentDetailsData? appointmentDetailsData;

  AppointmentDetailsResponseModel({
    required this.status,
    required this.message,
    this.appointmentDetailsData,
  });

  factory AppointmentDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    return AppointmentDetailsResponseModel(
      status: json["status"] ?? '',
      message: json["message"] ?? '',
      appointmentDetailsData: json["data"] != null
          ? AppointmentDetailsData.fromJson(json["data"])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": appointmentDetailsData?.toJson(),
      };

  @override
  String toString() => jsonEncode(toJson());
}

class AppointmentDetailsData {
  EyeTest eyeTest;
  List<Prescription> prescriptions;

  AppointmentDetailsData({
    required this.eyeTest,
    required this.prescriptions,
  });

  factory AppointmentDetailsData.fromJson(Map<String, dynamic> json) {
    return AppointmentDetailsData(
      eyeTest: EyeTest.fromJson(json["eyeTest"]),
      prescriptions: json["prescriptions"] != null
          ? List<Prescription>.from(
              json["prescriptions"].map((x) => Prescription.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "eyeTest": eyeTest.toJson(),
        "prescriptions": prescriptions.map((x) => x.toJson()).toList(),
      };
}

class EyeTest {
  List<TestResult> clinicalList;
  AppTestData? appTest;

  EyeTest({required this.clinicalList, this.appTest});

  factory EyeTest.fromJson(Map<String, dynamic> json) {
    return EyeTest(
      clinicalList: json["clinical"] != null
          ? List<TestResult>.from(
              json["clinical"].map((x) => TestResult.fromJson(x)))
          : [],
      appTest: json["app"] != null ? AppTestData.fromJson(json["app"]) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "clinical": clinicalList.map((x) => x.toJson()).toList(),
        "app": appTest?.toJson(),
      };
}

class AppTestData {
  String? id;
  String? patient;
  String? createdAt;
  AppTestDataModel? data;
  String? status;
  String? type;
  String? updatedAt;

  AppTestData({
    this.id,
    this.patient,
    this.createdAt,
    this.data,
    this.status,
    this.type,
    this.updatedAt,
  });

  factory AppTestData.fromJson(Map<String, dynamic> json) => AppTestData(
        id: json["_id"],
        patient: json["patient"],
        createdAt: json["createdAt"],
        data: json["data"] != null ? AppTestDataModel.fromJson(json["data"]) : null,
        status: json["status"],
        type: json["type"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "patient": patient,
        "createdAt": createdAt,
        "data": data?.toJson(),
        "status": status,
        "type": type,
        "updatedAt": updatedAt,
      };
}

class AppTestDataModel {
  NearVision? visualAcuity;
  NearVision? nearVision;
  Vision? colorVision;
  Vision? amdVision;

  AppTestDataModel({this.visualAcuity, this.nearVision, this.colorVision, this.amdVision});

  factory AppTestDataModel.fromJson(Map<String, dynamic> json) => AppTestDataModel(
        visualAcuity: json["visualAcuity"] != null ? NearVision.fromJson(json["visualAcuity"]) : null,
        nearVision: json["nearVision"] != null ? NearVision.fromJson(json["nearVision"]) : null,
        colorVision: json["colorVision"] != null ? Vision.fromJson(json["colorVision"]) : null,
        amdVision: json["amdVision"] != null ? Vision.fromJson(json["amdVision"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "visualAcuity": visualAcuity?.toJson(),
        "nearVision": nearVision?.toJson(),
        "colorVision": colorVision?.toJson(),
        "amdVision": amdVision?.toJson(),
      };
}

class Vision {
  String? left;
  String? right;

  Vision({this.left, this.right});

  factory Vision.fromJson(Map<String, dynamic> json) => Vision(
        left: json["left"],
        right: json["right"],
      );

  Map<String, dynamic> toJson() => {
        "left": left,
        "right": right,
      };
}

class NearVision {
  Left? left;
  Left? right;

  NearVision({this.left, this.right});

  factory NearVision.fromJson(Map<String, dynamic> json) => NearVision(
        left: json["left"] != null ? Left.fromJson(json["left"]) : null,
        right: json["right"] != null ? Left.fromJson(json["right"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "left": left?.toJson(),
        "right": right?.toJson(),
      };
}

class Left {
  String? os;
  String? od;

  Left({this.os, this.od});

  factory Left.fromJson(Map<String, dynamic> json) => Left(
        os: json["os"],
        od: json["od"],
      );

  Map<String, dynamic> toJson() => {
        "os": os,
        "od": od,
      };
}

class TestResult {
  String? sId;
  String? title;
  String? attachment;
  String? status;
  String? createdAt;
  

  TestResult({this.sId, this.title, this.attachment, this.status, this.createdAt});

  factory TestResult.fromJson(Map<String, dynamic> json) => TestResult(
        sId: json['_id'],
        title: json['title'] ?? '',
        attachment: json['attachment'],
        status: json['status'],
        createdAt: json['createdAt'],
      );

  Map<String, dynamic> toJson() => {
        "_id": sId,
        "title": title,
        "attachment": attachment,
        "status": status,
        "createdAt": createdAt,
      };
}

class Prescription {
  String? id;
  String? file;
  String? title;
  String? createdAt;

  Prescription({this.id, this.file, this.title, this.createdAt});

  factory Prescription.fromJson(Map<String, dynamic> json) => Prescription(
        id: json['_id'],
        file: json['file'],
        title: json['title'] != null ? "${json['title']}" : "",
        createdAt: json['createdAt'],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "file": file,
        "title": title,
        "createdAt": createdAt,
      };
}

class PrescriptionListData {
  List<Prescription>? prescriptionList;
  int? totalDocs;
  int? limit;
  int? page;
  int? totalPages;
  int? pagingCounter;
  bool? hasPrevPage;
  bool? hasNextPage;
  String? prevPage;
  String? nextPage;

  PrescriptionListData(
      {this.prescriptionList,
      this.totalDocs,
      this.limit,
      this.page,
      this.totalPages,
      this.pagingCounter,
      this.hasPrevPage,
      this.hasNextPage,
      this.prevPage,
      this.nextPage});

  factory PrescriptionListData.fromJson(Map<String, dynamic> json) {
    return PrescriptionListData(
      prescriptionList: json['docs'] != null
          ? List<Prescription>.from(
              json['docs'].map((x) => Prescription.fromJson(x)))
          : [],
      totalDocs: json['totalDocs'],
      limit: json['limit'],
      page: json['page'],
      totalPages: json['totalPages'],
      pagingCounter: json['pagingCounter'],
      hasPrevPage: json['hasPrevPage'],
      hasNextPage: json['hasNextPage'],
      prevPage: json['prevPage'] != null ? "${json['prevPage']}" : "",
      nextPage: json['nextPage'] != null ? "${json['nextPage']}" : "",
    );
  }

  Map<String, dynamic> toJson() => {
        'docs': prescriptionList?.map((x) => x.toJson()).toList(),
        'totalDocs': totalDocs,
        'limit': limit,
        'page': page,
        'totalPages': totalPages,
        'pagingCounter': pagingCounter,
        'hasPrevPage': hasPrevPage,
        'hasNextPage': hasNextPage,
        'prevPage': prevPage,
        'nextPage': nextPage,
      };
}

class PrescriptionListResponseModel {
  String? status;
  String? message;
  PrescriptionListData? prescriptionListData;

  PrescriptionListResponseModel({
    this.status,
    this.message,
    this.prescriptionListData, // required na ho
  });

  factory PrescriptionListResponseModel.fromJson(Map<String, dynamic> json) {
    return PrescriptionListResponseModel(
      status: json["status"] ?? "",
      message: json["message"] ?? "",
      prescriptionListData: json["data"] != null
          ? PrescriptionListData.fromJson(json["data"])
          : null,
    );
  }
}
