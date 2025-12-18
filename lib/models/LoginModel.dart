// import 'dart:convert';

// class LoginModel {
//   String dialCode;
//   String phone;
//   LoginModel({
//     required this.dialCode,
//     required this.phone,
//   });

//   Map<String, dynamic> toMap() => {
//         'dialCode': dialCode,
//         'phone': phone,
//       };

//   factory LoginModel.fromMap(Map<String, dynamic> map) => LoginModel(
//         dialCode: map['dialCode'].toString(),
//         phone: map['phone'].toString(),
//       );

//   String toJson() => json.encode(toMap());
//   factory LoginModel.fromJson(String source) =>
//       LoginModel.fromMap(json.decode(source));
// }

// class LoginApiResponseData {
//   String traceId;
//   LoginApiResponseData({required this.traceId});

//   Map<String, dynamic> toMap() => {'traceId': traceId};

//   factory LoginApiResponseData.fromMap(Map<String, dynamic> map) =>
//       LoginApiResponseData(traceId: map['traceId'].toString());
// }

// class LoginApiResponse {
//   String? status;
//   String? message;
//   LoginApiResponseData? data;

//   LoginApiResponse({this.status, this.message, this.data});

//   factory LoginApiResponse.fromMap(Map<String, dynamic> map) =>
//       LoginApiResponse(
//         status: map['status']?.toString(),
//         message: map['message']?.toString(),
//         data: map['data'] != null
//             ? LoginApiResponseData.fromMap(map['data'])
//             : null,
//       );
// }
