// ignore_for_file: unnecessary_null_comparison

import 'package:beh_doctor/views/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../shareprefs.dart';
import 'BottomNavScreen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // final SplashController controller = Get.find();

  @override
  void initState() {
    super.initState();
    getToken();
  }

  Future<void> getToken() async {
    String? token = await SharedPrefs.getToken();
    await Future.delayed(Duration(seconds: 3), () {
      if (token != null && token.isNotEmpty) {
        print("token fron splash screen => $token");

        // Get.offAllNamed(Routes.BOTTOM_NAV);
        Get.offAll(() => BottomNavScreen());
      } else {
        Get.offAll(() => LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
