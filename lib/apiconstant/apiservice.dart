//     _dio.options.connectTimeout = const Duration(seconds: 25);
//     _dio.options.receiveTimeout = const Duration(seconds: 25);
//   }

//   /// Internal method to get token safely
//   Future<String?> _getToken() async {
//     final token = await OtpController.getUserToken();
//     if (token == null || token.isEmpty) {
//       print("⚠️ Token missing or null!");
//       return null;
//     }
//     return token;
//   }

//   /// POST Request
//   Future<Map<String, dynamic>> getPostResponse(
//       String url, Map<String, dynamic> body) async {
//     try {
//       final token = await _getToken();
//       if (token == null) {
//         return {'status': 'error', 'message': 'Token missing, login again'};
//       }

//       print("🌐 POST URL: $url");
//       print("📦 POST BODY: $body");

//       final response = await _dio.post(
//         url,
//         data: body,
//         options: Options(
//           headers: {
//             "Authorization": "Bearer $token",
//             "Content-Type": "application/json",
//           },
//         ),
//       );

//       print("✅ POST RESPONSE DATA: ${response.data}");
//       return response.data as Map<String, dynamic>;
//     } on DioException catch (e) {
//       print("❌ POST DIO ERROR: ${e.message}");
//       if (e.response?.statusCode == 401) {
//         return {'status': 'error', 'message': 'Unauthorized, login again'};
//       }
//       if (e.response != null) return e.response!.data as Map<String, dynamic>;
//       return {'status': 'error', 'message': 'Network error occurred'};
//     } catch (err) {
//       print("❌ POST UNEXPECTED ERROR: $err");
//       return {'status': 'error', 'message': 'Something went wrong'};
//     }
//   }
import 'package:dio/dio.dart';
import 'package:beh_doctor/shareprefs.dart';

// class ApiService {
//   final Dio _dio = Dio();

//   ApiService() {
//     _dio.options.connectTimeout = const Duration(seconds: 60);
//     _dio.options.receiveTimeout = const Duration(seconds: 60);
//   }
class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    _dio.options.connectTimeout = const Duration(seconds: 60);
    _dio.options.receiveTimeout = const Duration(seconds: 60);

    // 🔥 ADD THIS — MOST IMPORTANT
    _dio.options.validateStatus = (status) {
      return status != null && status < 500;
      // ✅ 200, 400, 401, 422 all treated as NORMAL responses
    };
  }


  /// Internal method to get token safely
  Future<String?> _getToken() async {
    final token = SharedPrefs.getToken();
    if (token.isEmpty) return null;
    return token;
  }

  Map<String, dynamic> _buildHeaders({String? token}) {
    final headers = <String, dynamic>{"Content-Type": "application/json"};
    if (token != null && token.isNotEmpty) {
      headers["Authorization"] = "Bearer $token";
    }
    return headers;
  }

  /// POST Request
  Future<Map<String, dynamic>> getPostResponse(
    String url,
    Map<String, dynamic> body,
  ) async {
    try {
      final token = await _getToken();
      if (token != null) {
        print("token: $token");
      }
      print("🌐 POST URL: $url");

      print("📦 POST BODY: $body");

      final response = await _dio.post(
        url,
        data: body,
        options: Options(headers: {..._buildHeaders(token: token)}),
      );

      print("✅ POST RESPONSE DATA: ${response.data}");
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      print("❌ POST DIO ERROR: ${e.message}");
      if (e.response?.statusCode == 401) {
        return {'status': 'error', 'message': 'Unauthorized, login again'};
      }
      if (e.response != null) return e.response!.data as Map<String, dynamic>;
      return {'status': 'error', 'message': 'Network error occurred'};
    } catch (err) {
      print("❌ POST UNEXPECTED ERROR: $err");
      return {'status': 'error', 'message': 'Something went wrong'};
    }
  }

  /// GET Request
  Future<Map<String, dynamic>> getGetResponse(String url) async {
    try {
      final token = await _getToken();
      if (token == null) {
        return {'status': 'error', 'message': 'Token missing, login again'};
      }

      print("🌐 GET URL: $url");

      final response = await _dio.get(
        url,
        options: Options(headers: {..._buildHeaders(token: token)}),
      );

      print("✅ GET RESPONSE DATA: ${response.data}");
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      print("❌ GET DIO ERROR: ${e.message}");
      if (e.response?.statusCode == 401) {
        return {'status': 'error', 'message': 'Unauthorized, login again'};
      }
      if (e.response != null) return e.response!.data as Map<String, dynamic>;
      return {'status': 'error', 'message': 'Network error'};
    } catch (err) {
      print("❌ GET UNEXPECTED ERROR: $err");
      return {'status': 'error', 'message': 'Unexpected error'};
    }
  }

  /// GET Request with parameters
  Future<Map<String, dynamic>> getGetResponseWithParameters(
    String url,
    Map<String, dynamic> parameters,
  ) async {
    try {
      final token = await _getToken();
      if (token == null) {
        return {'status': 'error', 'message': 'Token missing, login again'};
      }

      print("🌐 GET URL WITH PARAMETERS: $url");
      print("📦 PARAMETERS: $parameters");

      final response = await _dio.get(
        url,
        queryParameters: parameters,
        options: Options(headers: {..._buildHeaders(token: token)}),
      );

      print("✅ GET RESPONSE WITH PARAMETERS: ${response.data}");
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      print("❌ GET WITH PARAMETERS DIO ERROR: ${e.message}");
      if (e.response?.statusCode == 401) {
        return {'status': 'error', 'message': 'Unauthorized, login again'};
      }
      if (e.response != null) return e.response!.data as Map<String, dynamic>;
      return {'status': 'error', 'message': 'Network error'};
    } catch (err) {
      print("❌ GET WITH PARAMETERS UNEXPECTED ERROR: $err");
      return {'status': 'error', 'message': 'Unexpected error'};
    }
  }

  // ----------------------------------------------------------
  //               ⭐ ADDED PATCH SERVICE HERE ⭐
  // ----------------------------------------------------------
  Future<Map<String, dynamic>> getPatchResponse(
    String url,
    Map<String, dynamic> body,
  ) async {
    try {
      final token = await _getToken();
      if (token == null) {
        return {'status': 'error', 'message': 'Token missing, login again'};
      }

      print("🌐 PATCH URL: $url");
      print("📦 PATCH BODY: $body");

      final response = await _dio.patch(
        url,
        data: body,
        options: Options(headers: {..._buildHeaders(token: token)}),
      );

      print("✅ PATCH RESPONSE: ${response.data}");
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      print("❌ PATCH DIO ERROR: ${e.message}");

      if (e.response?.statusCode == 401) {
        return {'status': 'error', 'message': 'Unauthorized, login again'};
      }

      if (e.response != null) {
        return e.response!.data as Map<String, dynamic>;
      }

      return {'status': 'error', 'message': 'Network error'};
    } catch (err) {
      print("❌ PATCH UNEXPECTED ERROR: $err");
      return {'status': 'error', 'message': 'Unexpected error'};
    }
  }
}
