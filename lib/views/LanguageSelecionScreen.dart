import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beh_doctor/modules/auth/controller/LanguageController.dart';

class LanguageSelectionScreen extends StatelessWidget {
  LanguageSelectionScreen({super.key});

  final LanguageController controller = Get.find<LanguageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ✅ APP BAR WITH BACK ARROW
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),

      body: SafeArea(
        child: Center(
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _languageTile(
                  title: 'English',
                  code: 'en',
                  isSelected: controller.selectedLang.value == 'en',
                ),

                // FULL WIDTH GREEN LINE
                Container(
                  width: double.infinity,
                  height: 1.2,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  color: const Color(0xFF008541),
                ),

                _languageTile(
                  title: 'বাংলা',
                  code: 'bn',
                  isSelected: controller.selectedLang.value == 'bn',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _languageTile({
    required String title,
    required String code,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        controller.changeLanguage(code);
        // ❌ no Get.back here
      },
      child: AnimatedScale(
        scale: isSelected ? 1.08 : 1.0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        child: AnimatedOpacity(
          opacity: isSelected ? 1.0 : 0.6,
          duration: const Duration(milliseconds: 250),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? const Color(0xFF008541)
                    : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
