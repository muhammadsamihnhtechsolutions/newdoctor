// // ignore_for_file: public_member_api_docs, sort_constructors_first

// import 'dart:convert';

// class PrescriptionListResponseModel {
//   String status;
//   String message;
//   PrescriptionListData? data;

//   PrescriptionListResponseModel({
//     required this.status,
//     required this.message,
//     this.data,
//   });

//   factory PrescriptionListResponseModel.fromJson(Map<String, dynamic> json) {
//     return PrescriptionListResponseModel(
//       status: json["status"] ?? "",
//       message: json["message"] ?? "",
//       data: json["data"] != null
//           ? PrescriptionListData.fromJson(json["data"])
//           : null,
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data?.toJson(),
//       };

//   @override
//   String toString() => jsonEncode(toJson());
// }

// // -----------------------------------------------------------------------------
// // DATA + PAGINATION
// // -----------------------------------------------------------------------------
// class PrescriptionListData {
//   List<Prescription> docs;
//   int? totalDocs;
//   int? limit;
//   int? page;
//   int? totalPages;
//   int? pagingCounter;
//   bool? hasPrevPage;
//   bool? hasNextPage;
//   String? prevPage;
//   String? nextPage;

//   PrescriptionListData({
//     required this.docs,
//     this.totalDocs,
//     this.limit,
//     this.page,
//     this.totalPages,
//     this.pagingCounter,
//     this.hasPrevPage,
//     this.hasNextPage,
//     this.prevPage,
//     this.nextPage,
//   });

//   factory PrescriptionListData.fromJson(Map<String, dynamic> json) {
//     return PrescriptionListData(
//       docs: json["docs"] != null
//           ? List<Prescription>.from(
//               json["docs"].map((x) => Prescription.fromJson(x)))
//           : [],
//       totalDocs: json["totalDocs"],
//       limit: json["limit"],
//       page: json["page"],
//       totalPages: json["totalPages"],
//       pagingCounter: json["pagingCounter"],
//       hasPrevPage: json["hasPrevPage"],
//       hasNextPage: json["hasNextPage"],
//       prevPage: json["prevPage"]?.toString(),
//       nextPage: json["nextPage"]?.toString(),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "docs": docs.map((x) => x.toJson()).toList(),
//         "totalDocs": totalDocs,
//         "limit": limit,
//         "page": page,
//         "totalPages": totalPages,
//         "pagingCounter": pagingCounter,
//         "hasPrevPage": hasPrevPage,
//         "hasNextPage": hasNextPage,
//         "prevPage": prevPage,
//         "nextPage": nextPage,
//       };
// }

// // -----------------------------------------------------------------------------
// // PRESCRIPTION ITEM
// // -----------------------------------------------------------------------------
// class Prescription {
//   String? id;
//   String? title;
//   String? file;
//   String? createdAt;
//   // PatientData? patient;

//   Prescription({
//     this.id,
//     this.title,
//     this.file,
//     this.createdAt,
//     // this.patient,
//   });

//   factory Prescription.fromJson(Map<String, dynamic> json) {
//     return Prescription(
//       id: json["_id"],
//       title: json["title"] ?? "",
//       file: json["file"],
//       createdAt: json["createdAt"],
//       // patient: json["patient"] != null
//       //     ? PatientData.fromJson(json["patient"])
//       //     : null,
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "title": title,
//         "file": file,
//         "createdAt": createdAt,
//         // "patient": patient?.toJson(),
//       };
// }

// // -----------------------------------------------------------------------------
// // PATIENT MODEL
// // -----------------------------------------------------------------------------
// class ProfileResponseModel {
//   String status;
//   String message;
//   ProfileData? data;

//   ProfileResponseModel({
//     required this.status,
//     required this.message,
//     this.data,
//   });

//   factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
//     return ProfileResponseModel(
//       status: json["status"] ?? "",
//       message: json["message"] ?? "",
//       data: json["data"] != null ? ProfileData.fromJson(json["data"]) : null,
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data?.toJson(),
//       };

//   @override
//   String toString() => jsonEncode(toJson());
// }

// class ProfileData {
//   String? id;
//   String? name;
//   String? phone;
//   String? photo;

//   ProfileData({this.id, this.name, this.phone, this.photo});

//   factory ProfileData.fromJson(Map<String, dynamic> json) {
//     return ProfileData(
//       id: json["_id"],
//       name: json["name"],
//       phone: json["phone"]?.toString(),
//       photo: json["photo"],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "name": name,
//         "phone": phone,
//         "photo": photo,
//       };
// }