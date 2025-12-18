import 'dart:convert';

/// 🔹 OTP request/verify payload
class VerifyOtpModel {
  final String traceId;
  final String code;
  final String? deviceToken; // optional, sent only on verification

  VerifyOtpModel({
    required this.traceId,
    required this.code,
    this.deviceToken,
  });

  Map<String, dynamic> toMap() {
    final map = {
      'traceId': traceId,
      'code': code,
    };
    if (deviceToken != null && deviceToken!.isNotEmpty) {
      map['deviceToken'] = deviceToken!;
    }
    return map;
  }

  String toJson() => json.encode(toMap());
}

/// 🔹 OTP verify API response data
class VerifyOtpApiResponseData {
  final String? traceId;
  final String? token;   // backend-generated JWT token
  final bool isNewUser;

  VerifyOtpApiResponseData({
    this.traceId,
    this.token,
    required this.isNewUser,
  });

  factory VerifyOtpApiResponseData.fromMap(Map<String, dynamic> map) {
    bool newUser = true;

    // Check if doctor exists and has a name
    if (map.containsKey('doctor') && map['doctor'] != null) {
      newUser = map['doctor']['name'] == null;
    }

    return VerifyOtpApiResponseData(
      traceId: map['traceId'] as String?,
      token: map['token'] as String?,
      isNewUser: newUser,
    );
  }

  Map<String, dynamic> toMap() => {
        'traceId': traceId,
        'token': token,
        'isNewUser': isNewUser,
      };

  String toJson() => json.encode(toMap());
}

/// 🔹 OTP verify API response wrapper
class VerifyOtpApiResponse {
  final String? status;
  final String? message;
  final VerifyOtpApiResponseData? data;

  VerifyOtpApiResponse({
    this.status,
    this.message,
    this.data,
  });

  factory VerifyOtpApiResponse.fromMap(Map<String, dynamic> map) {
    return VerifyOtpApiResponse(
      status: map['status'] as String?,
      message: map['message'] as String?,
      data: map['data'] != null
          ? VerifyOtpApiResponseData.fromMap(map['data'])
          : null,
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'message': message,
        'data': data?.toMap(),
      };

  String toJson() => json.encode(toMap());
}
