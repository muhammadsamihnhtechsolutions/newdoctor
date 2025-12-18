// To parse this JSON data, do
//
//     final withdrawAccountResponseModel = withdrawAccountResponseModelFromJson(jsonString);

import 'dart:convert';

WithdrawAccountResponseModel withdrawAccountResponseModelFromJson(String str) =>
    WithdrawAccountResponseModel.fromJson(json.decode(str));

String withdrawAccountResponseModelToJson(WithdrawAccountResponseModel data) => json.encode(data.toJson());

class WithdrawAccountResponseModel {
  String? status;
  String? message;
  WithdrawAccountData? withdrawAccountdata;

  WithdrawAccountResponseModel({
    this.status,
    this.message,
    this.withdrawAccountdata,
  });

  factory WithdrawAccountResponseModel.fromJson(Map<String, dynamic> json) => WithdrawAccountResponseModel(
        status: json["status"],
        message: json["message"],
        withdrawAccountdata: WithdrawAccountData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": withdrawAccountdata!.toJson(),
      };
}

class WithdrawAccountData {
  List<WithdrawAccount> withdrawAccountList;
  int totalDocs;
  int limit;
  int page;
  int totalPages;
  int pagingCounter;
  bool hasPrevPage;
  bool hasNextPage;
  dynamic prevPage;
  dynamic nextPage;

  WithdrawAccountData({
    required this.withdrawAccountList,
    required this.totalDocs,
    required this.limit,
    required this.page,
    required this.totalPages,
    required this.pagingCounter,
    required this.hasPrevPage,
    required this.hasNextPage,
    this.prevPage,
    this.nextPage,
  });

  factory WithdrawAccountData.fromJson(Map<String, dynamic> json) => WithdrawAccountData(
        withdrawAccountList: List<WithdrawAccount>.from(json["docs"].map((x) => WithdrawAccount.fromJson(x))),
        totalDocs: json["totalDocs"],
        limit: json["limit"],
        page: json["page"],
        totalPages: json["totalPages"],
        pagingCounter: json["pagingCounter"],
        hasPrevPage: json["hasPrevPage"],
        hasNextPage: json["hasNextPage"],
        prevPage: json["prevPage"],
        nextPage: json["nextPage"],
      );

  Map<String, dynamic> toJson() => {
        "docs": List<dynamic>.from(withdrawAccountList.map((x) => x.toJson())),
        "totalDocs": totalDocs,
        "limit": limit,
        "page": page,
        "totalPages": totalPages,
        "pagingCounter": pagingCounter,
        "hasPrevPage": hasPrevPage,
        "hasNextPage": hasNextPage,
        "prevPage": prevPage,
        "nextPage": nextPage,
      };
}

class WithdrawAccount {
  String id;
  String ownerType;
  String accountType;
  String owner;
  String bankName;
  String branch;
  String district;
  String accountName;
  String accountNumber;
  String createdAt;
  String updatedAt;
  int v;

  WithdrawAccount({
    required this.id,
    required this.ownerType,
    required this.accountType,
    required this.owner,
    required this.bankName,
    required this.branch,
    required this.district,
    required this.accountName,
    required this.accountNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.v, required String mfsName,
  });

  factory WithdrawAccount.fromJson(Map<String, dynamic> json) => WithdrawAccount(
        id: json["_id"],
        ownerType: json["ownerType"],
        accountType: json["accountType"],
        owner: json["owner"],
        bankName: json["bankName"],
        branch: json["branch"] != null ? "${json["branch"]}" : "",
        district: json["district"] != null ? "${json["district"]}" : "",
        accountName: json["accountName"],
        accountNumber: json["accountNumber"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"], mfsName: '',
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "ownerType": ownerType,
        "accountType": accountType,
        "owner": owner,
        "bankName": bankName,
        "branch": branch,
        "district": district,
        "accountName": accountName,
        "accountNumber": accountNumber,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
      };
}
