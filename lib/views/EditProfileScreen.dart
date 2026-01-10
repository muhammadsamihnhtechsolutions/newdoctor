
import 'package:beh_doctor/theme/Appcolars.dart';
import 'package:beh_doctor/views/BasicInfoScreen.dart';
import 'package:beh_doctor/views/ConsultationFeeTab.dart';
import 'package:beh_doctor/views/ExprienceSetupScreen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text("edit_profile".tr),
        centerTitle: true,
      ),

      body: Column(
        children: [
          const SizedBox(height: 12),

          /// ---------------- TABS (Withdraw jesi UI) ----------------
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF008541)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                _innerTab(
                  title: "Basic Info",
                  isSelected: selectedIndex == 0,
                  onTap: () => setState(() => selectedIndex = 0),
                ),
                _innerTab(
                  title: "Consultation",
                  isSelected: selectedIndex == 1,
                  onTap: () => setState(() => selectedIndex = 1),
                ),
                _innerTab(
                  title: "Experience",
                  isSelected: selectedIndex == 2,
                  onTap: () => setState(() => selectedIndex = 2),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          /// ---------------- TAB BODY ----------------
          Expanded(
            child: IndexedStack(
              index: selectedIndex,
              children: [
                /// 0 → SAME OLD EDIT SCREEN
                BasicInfoTab(),

                /// 1 → CONSULTATION FEE
                const ConsultationFeeTab(),

                /// 2 → EXPERIENCE
                 ExperienceSetupScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// ---------------- TAB UI (UNCHANGED) ----------------
  Widget _innerTab({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF008541) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
