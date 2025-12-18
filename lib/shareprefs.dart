// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPrefs {
//   static SharedPreferences? _prefs;

//   static Future init() async {
//     _prefs = await SharedPreferences.getInstance();
//   }

//   // ====================== TOKEN ======================

//   // SAVE TOKEN
//   static Future saveToken(String token) async {
//     await _prefs?.setString("token", token);
//   }

//   // GET TOKEN
//   static String getToken() {
//     return _prefs?.getString("token") ?? "";
//   }

//   // CLEAR TOKEN
//   static Future clearToken() async {
//     await _prefs?.remove("token");
//   }

//   // ====================== LANGUAGE ======================

//   // SAVE LANGUAGE
//   static Future saveLanguage(String lang) async {
//     await _prefs?.setString("language", lang);
//   }

//   // GET LANGUAGE
//   static String getLanguage() {
//     return _prefs?.getString("language") ?? "en";
//   }

//   static Future saveAgoraChannelId(String channelId) async {
//     await _prefs?.setString("agora_channel_id", channelId);
//   }

//   static String getAgoraChannelId() {
//     return _prefs?.getString("agora_channel_id") ?? "";
//   }

//   static Future saveDoctorAgoraToken(String token) async {
//     await _prefs?.setString("doctor_agora_token", token);
//   }

//   static String getDoctorAgoraToken() {
//     return _prefs?.getString("doctor_agora_token") ?? "";
//   }
// }
// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPrefs {
//   static SharedPreferences? _prefs;

//   static Future init() async {
//     try {
//       _prefs = await SharedPreferences.getInstance();
//     } catch (e) {
//       print("SharedPrefs init error: $e");
//     }
//   }

//   // ====================== TOKEN ======================

//   // SAVE TOKEN
//   static Future saveToken(String token) async {
//     try {
//       await _prefs?.setString("token", token);
//     } catch (e) {
//       print("saveToken error: $e");
//     }
//   }

//   // GET TOKEN
//   static String getToken() {
//     try {
//       return _prefs?.getString("token") ?? "";
//     } catch (e) {
//       print("getToken error: $e");
//       return "";
//     }
//   }

//   // CLEAR TOKEN
//   static Future clearToken() async {
//     try {
//       await _prefs?.remove("token");
//     } catch (e) {
//       print("clearToken error: $e");
//     }
//   }

//   // ====================== LANGUAGE ======================

//   // SAVE LANGUAGE
//   static Future saveLanguage(String lang) async {
//     try {
//       await _prefs?.setString("language", lang);
//     } catch (e) {
//       print("saveLanguage error: $e");
//     }
//   }

//   // GET LANGUAGE
//   static String getLanguage() {
//     try {
//       return _prefs?.getString("language") ?? "en";
//     } catch (e) {
//       print("getLanguage error: $e");
//       return "en";
//     }
//   }

//   static Future saveAgoraChannelId(String channelId) async {
//     try {
//       await _prefs?.setString("agora_channel_id", channelId);
//     } catch (e) {
//       print("saveAgoraChannelId error: $e");
//     }
//   }

//   static String getAgoraChannelId() {
//     try {
//       return _prefs?.getString("agora_channel_id") ?? "";
//     } catch (e) {
//       print("getAgoraChannelId error: $e");
//       return "";
//     }
//   }

//   static Future saveDoctorAgoraToken(String token) async {
//     try {
//       await _prefs?.setString("doctor_agora_token", token);
//     } catch (e) {
//       print("saveDoctorAgoraToken error: $e");
//     }
//   }

//   static String getDoctorAgoraToken() {
//     try {
//       return _prefs?.getString("doctor_agora_token") ?? "";
//     } catch (e) {
//       print("getDoctorAgoraToken error: $e");
//       return "";
//     }
//   }
// }

// ye tokenkaissue solve ky leye
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _prefs;

  static Future init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      print("SharedPrefs init error: $e");
    }
  }

  // ====================== TOKEN ======================

  // SAVE TOKEN
  static Future saveToken(String token) async {
    try {
      await _prefs?.setString("authToken", token);
    } catch (e) {
      print("saveToken error: $e");
    }
  }

  // GET TOKEN
  static String getToken() {
    try {
      final authToken = _prefs?.getString("authToken") ?? "";
      if (authToken.isNotEmpty) return authToken;

      final legacyToken = _prefs?.getString("token") ?? "";
      if (legacyToken.isNotEmpty) {
        _prefs?.setString("authToken", legacyToken);
        _prefs?.remove("token");
        return legacyToken;
      }

      return "";
    } catch (e) {
      print("getToken error: $e");
      return "";
    }
  }

  // CLEAR TOKEN
  static Future clearToken() async {
    try {
      await _prefs?.remove("authToken");
    } catch (e) {
      print("clearToken error: $e");
    }
  }

  // ====================== LANGUAGE ======================

  // SAVE LANGUAGE
  static Future saveLanguage(String lang) async {
    try {
      await _prefs?.setString("language", lang);
    } catch (e) {
      print("saveLanguage error: $e");
    }
  }

  // GET LANGUAGE
  static String getLanguage() {
    try {
      return _prefs?.getString("language") ?? "en";
    } catch (e) {
      print("getLanguage error: $e");
      return "en";
    }
  }

  // ====================== AGORA ======================

  static Future saveAgoraChannelId(String channelId) async {
    try {
      await _prefs?.setString("agora_channel_id", channelId);
    } catch (e) {
      print("saveAgoraChannelId error: $e");
    }
  }

  static String getAgoraChannelId() {
    try {
      return _prefs?.getString("agora_channel_id") ?? "";
    } catch (e) {
      print("getAgoraChannelId error: $e");
      return "";
    }
  }

  static Future saveDoctorAgoraToken(String token) async {
    try {
      await _prefs?.setString("doctor_agora_token", token);
    } catch (e) {
      print("saveDoctorAgoraToken error: $e");
    }
  }

  static String getDoctorAgoraToken() {
    try {
      return _prefs?.getString("doctor_agora_token") ?? "";
    } catch (e) {
      print("getDoctorAgoraToken error: $e");
      return "";
    }
  }
}
