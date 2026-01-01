import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beh_doctor/modules/auth/controller/LanguageController.dart';

class LanguageSelectionScreen extends StatelessWidget {
  LanguageSelectionScreen({super.key});

  final LanguageController controller = Get.find<LanguageController>();

  static const Color _green = Color(0xFF008541);
  static const Color _lightGreen = Color(0xFFE9F6EF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ---------------- APP BAR ----------------
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color:Colors.black45),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Language Change",
          style: TextStyle(
            color: _green,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),

      body: SafeArea(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // --------- HEADER TEXT ----------
                const Text(
                  "Choose your language",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: _green,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "You can change this anytime from settings",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 40),

                // --------- LANGUAGE CARD ---------
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                    border: Border.all(
                      color: _green.withOpacity(0.4),
                    ),
                  ),
                  child: Column(
                    children: [
                      _languageTile(
                        title: 'English',
                        subtitle: 'English (Default)',
                        code: 'en',
                        isSelected:
                            controller.selectedLang.value == 'en',
                      ),

                      Divider(
                        height: 1,
                        thickness: 1,
                        color: _green.withOpacity(0.3),
                      ),

                      _languageTile(
                        title: 'বাংলা',
                        subtitle: 'Bengali',
                        code: 'bn',
                        isSelected:
                            controller.selectedLang.value == 'bn',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- LANGUAGE TILE ----------------
  Widget _languageTile({
    required String title,
    required String subtitle,
    required String code,
    required bool isSelected,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        controller.changeLanguage(code);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        decoration: BoxDecoration(
          color: isSelected ? _lightGreen : Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            // --------- CHECK CIRCLE ----------
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 26,
              width: 26,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: _green, width: 2),
                color: isSelected ? _green : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    )
                  : null,
            ),

            const SizedBox(width: 16),

            // --------- TEXT ----------
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: _green,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            // --------- SELECTED LABEL ----------
            if (isSelected)
              const Text(
                "Selected",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _green,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
