import 'dart:convert';

class TransactionsResponseModel {
  String? status;
  String? message;
  TransactionsData? transactionsData;

  TransactionsResponseModel({this.status, this.message, this.transactionsData});

  factory TransactionsResponseModel.fromJson(Map<String, dynamic> json) => TransactionsResponseModel(
        status: json["status"],
        message: json["message"],
        transactionsData: json["data"] != null ? TransactionsData.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": transactionsData?.toJson(),
      };
}

class TransactionsData {
  List<Transaction>? transactionList;
  int? totalDocs;
  int? limit;
  int? page;
  int? totalPages;
  int? pagingCounter;
  bool? hasPrevPage;
  bool? hasNextPage;
  dynamic prevPage;
  dynamic nextPage;

  TransactionsData({
    this.transactionList,
    this.totalDocs,
    this.limit,
    this.page,
    this.totalPages,
    this.pagingCounter,
    this.hasPrevPage,
    this.hasNextPage,
    this.prevPage,
    this.nextPage,
  });

  factory TransactionsData.fromJson(Map<String, dynamic> json) => TransactionsData(
        transactionList: json["docs"] != null
            ? List<Transaction>.from(json["docs"].map((x) => Transaction.fromJson(x)))
            : [],
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
        "docs": transactionList != null ? List<dynamic>.from(transactionList!.map((x) => x.toJson())) : [],
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

class Transaction {
  String? id;
  String? ownerType;
  String? owner;
  String? transactionType;
  String? criteria;
  dynamic account;
  double? amount;
  String? note;
  String? status;
  String? transferredBy;
  String? createdAt;
  String? updatedAt;
  int? v;

  Transaction({
    this.id,
    this.ownerType,
    this.owner,
    this.transactionType,
    this.criteria,
    this.account,
    this.amount,
    this.note,
    this.status,
    this.transferredBy,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["_id"],
        ownerType: json["ownerType"],
        owner: json["owner"],
        transactionType: json["transactionType"],
        criteria: json["criteria"],
        account: json["account"],
        amount: json["amount"] != null ? double.parse("${json["amount"]}") : 0.0,
        note: json["note"],
        status: json["status"],
        transferredBy: json["transferredBy"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "ownerType": ownerType,
        "owner": owner,
        "transactionType": transactionType,
        "criteria": criteria,
        "account": account,
        "amount": amount,
        "note": note,
        "status": status,
        "transferredBy": transferredBy,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "__v": v,
      };
}

