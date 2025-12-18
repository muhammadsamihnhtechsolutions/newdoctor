import 'package:beh_doctor/widgets/CenterLottieWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentTermsPage extends StatelessWidget {
  const PaymentTermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("payment_terms".tr)),

      body: CenterLottieWidget(title: "payment_terms".tr),
    );
  }
}
