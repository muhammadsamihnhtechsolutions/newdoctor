// waleetmodel

class WalletStatisticsResponseModel {
  String? status;
  String? message;
  WalletStatistics? walletStatistics;

  WalletStatisticsResponseModel({this.status, this.message, this.walletStatistics});

  factory WalletStatisticsResponseModel.fromJson(Map<String, dynamic> json) => WalletStatisticsResponseModel(
        status: json["status"],
        message: json["message"],
        walletStatistics: json["data"] != null ? WalletStatistics.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": walletStatistics?.toJson(),
      };
}

class WalletStatistics {
  double balance;
  double totalEarning;

  WalletStatistics({required this.balance, required this.totalEarning});

  factory WalletStatistics.fromJson(Map<String, dynamic> json) => WalletStatistics(
        balance: json["balance"] != null ? double.parse("${json["balance"]}") : 0.0,
        totalEarning: json["totalEarning"] != null ? double.parse("${json["totalEarning"]}") : 0.0,
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "totalEarning": totalEarning,
      };
}