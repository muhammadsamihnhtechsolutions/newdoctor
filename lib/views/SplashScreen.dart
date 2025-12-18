import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:beh_doctor/modules/auth/controller/SplashController.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final SplashController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
