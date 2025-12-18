import 'package:beh_doctor/models/AppoinmentDetailModel.dart';

class TestResultResponseModel {
  String? status;
  String? message;
  TestResultData? testResultResponseData;

  TestResultResponseModel({this.status, this.message, this.testResultResponseData});

  factory TestResultResponseModel.fromJson(Map<String, dynamic> json) {
    return TestResultResponseModel(
      status: json["status"],
      message: json["message"],
      testResultResponseData: json["data"] != null
          ? TestResultData.fromJson(json["data"])
          : null,
    );
  }
}

class TestResultData {
  List<TestResult>? docs;

  TestResultData({this.docs});

  factory TestResultData.fromJson(Map<String, dynamic> json) {
    return TestResultData(
      docs: json["docs"] != null
          ? List<TestResult>.from(
              json["docs"].map((x) => TestResult.fromJson(x)))
          : [],
    );
  }
}
