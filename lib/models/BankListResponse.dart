import 'dart:convert';

BankListResponseModel bankListResponseModelFromJson(String str) => BankListResponseModel.fromJson(json.decode(str));

String bankListResponseModelToJson(BankListResponseModel data) => json.encode(data.toJson());

class BankListResponseModel {
  String? status;
  String? message;
  List<BankModel>? bankList;

  BankListResponseModel({
    this.status,
    this.message,
    this.bankList,
  });

  factory BankListResponseModel.fromJson(Map<String, dynamic> json) => BankListResponseModel(
    status: json["status"],
    message: json["message"],
    bankList: List<BankModel>.from(json["data"].map((x) => BankModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(bankList!.map((x) => x.toJson())),
  };
}

class BankModel {
  String? id;
  String? title;
  String? type;
  String? status;

  BankModel({
    this.id,
    this.title,
    this.type,
    this.status,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
    id: json["_id"],
    title: json["title"],
    type: json["type"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "type": type,
    "status": status,
  };
}
