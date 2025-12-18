import 'package:beh_doctor/widgets/CenterLottieWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("terms_and_conditions".tr)),

      body: CenterLottieWidget(title: "terms_and_conditions".tr),
    );
  }
}
