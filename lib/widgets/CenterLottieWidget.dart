import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:beh_doctor/theme/AppAssets.dart';

// <-- Yeh import zaroor add karna

class CenterLottieWidget extends StatelessWidget {
  final String title;

  const CenterLottieWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            AppAssets.searchEmpty,
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),

          const SizedBox(height: 20),

          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
