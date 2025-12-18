// To parse this JSON data, do
//
//     final prescriptionSubmittedResponse = prescriptionSubmittedResponseFromJson(jsonString);

import 'dart:convert';

PrescriptionSubmittedResponse prescriptionSubmittedResponseFromJson(String str) => PrescriptionSubmittedResponse.fromJson(json.decode(str));

String prescriptionSubmittedResponseToJson(PrescriptionSubmittedResponse data) => json.encode(data.toJson());

class PrescriptionSubmittedResponse {
  String? status;
  String? message;
  FileClass? file;

  PrescriptionSubmittedResponse({
    this.status,
    this.message,
    this.file,
  });

  factory PrescriptionSubmittedResponse.fromJson(Map<String, dynamic> json) => PrescriptionSubmittedResponse(
        status: json["status"],
        message: json["message"],
        file: json["file"] == null ? null : FileClass.fromJson(json["file"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "file": file?.toJson(),
      };
}

class FileClass {
  String? eTag;
  String? serverSideEncryption;
  String? location;
  String? fileKey;
  String? key;
  String? bucket;

  FileClass({
    this.eTag,
    this.serverSideEncryption,
    this.location,
    this.fileKey,
    this.key,
    this.bucket,
  });

  factory FileClass.fromJson(Map<String, dynamic> json) => FileClass(
        eTag: json["ETag"],
        serverSideEncryption: json["ServerSideEncryption"],
        location: json["Location"],
        fileKey: json["key"],
        key: json["Key"],
        bucket: json["Bucket"],
      );

  Map<String, dynamic> toJson() => {
        "ETag": eTag,
        "ServerSideEncryption": serverSideEncryption,
        "Location": location,
        "key": fileKey,
        "Key": key,
        "Bucket": bucket,
      };
}
