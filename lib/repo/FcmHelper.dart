import 'package:beh_doctor/shareprefs.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FcmHelper {
  static Future<String?> ensureToken() async {
    String token = SharedPrefs.getFcmToken();

    if (token.isNotEmpty) return token;

    final fcm = FirebaseMessaging.instance;

    token = await fcm.getToken() ?? "";

    if (token.isNotEmpty) {
      await SharedPrefs.saveFcmToken(token);
      print("🔥 NEW FCM TOKEN GENERATED => $token");
      return token;
    }

    return null;
  }
}
