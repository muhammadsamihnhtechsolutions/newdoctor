import 'package:beh_doctor/widgets/CenterLottieWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("privacy_policy".tr)),

      body: CenterLottieWidget(title: "privacy_policy".tr),
    );
  }
}
