// To parse this JSON data, do
//
//     final districtResponseModel = districtResponseModelFromJson(jsonString);

import 'dart:convert';

class DistrictResponseModel {
  String? status;
  String? message;
  List<District>? districtList;

  DistrictResponseModel({
    this.status,
    this.message,
    this.districtList,
  });

  factory DistrictResponseModel.fromRawJson(String str) => DistrictResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DistrictResponseModel.fromJson(Map<String, dynamic> json) => DistrictResponseModel(
        status: json["status"],
        message: json["message"],
        districtList: List<District>.from(json["data"].map((x) => District.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(districtList!.map((x) => x.toJson())),
      };
}

class District {
  String? id;
  String? name;
  String? nameBn;
  String? lat;
  String? long;
  String? status;
  int? v;
  String? createdAt;
  String? updatedAt;

  District({
    this.id,
    this.name,
    this.nameBn,
    this.lat,
    this.long,
    this.status,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  factory District.fromRawJson(String str) => District.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory District.fromJson(Map<String, dynamic> json) => District(
        id: json["_id"],
        name: json["name"],
        nameBn: json["nameBn"],
        lat: json["lat"],
        long: json["long"],
        status: json["status"],
        v: json["__v"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "nameBn": nameBn,
        "lat": lat,
        "long": long,
        "status": status,
        "__v": v,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
