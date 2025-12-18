import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallEndScreen extends StatelessWidget {
  const CallEndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.call_end, size: 100, color: Colors.red),
                const SizedBox(height: 30),
                Text(
                  "call_ended".tr,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "thank_you_service".tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  icon: const Icon(Icons.home),
                  label: Text("back_to_home".tr),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    // Go back to your main/home screen
                    Get.offAllNamed(
                      '/home',
                    ); // change this route as per your app
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
