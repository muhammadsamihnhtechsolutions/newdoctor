
import 'dart:convert';
import 'dart:io';

import 'package:beh_doctor/apiconstant/apiconstant.dart';
import 'package:beh_doctor/modules/auth/controller/DoctorProfileController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BasicInfoTab extends StatefulWidget {
  @override
  State<BasicInfoTab> createState() => _BasicInfoTabState();
}

class _BasicInfoTabState extends State<BasicInfoTab> {
  final DoctorProfileController controller = Get.find();

  final nameCtrl = TextEditingController();
  final expCtrl = TextEditingController();
  final bmdcCtrl = TextEditingController();
  final aboutCtrl = TextEditingController();

  String? selectedGender;
  File? selectedImage;
  List<String> selectedSpecialties = [];

  static const Color _green = Color(0xFF008541);

  @override
  void initState() {
    super.initState();
    final d = controller.doctor.value;

    if (d != null) {
      nameCtrl.text = d.name ?? "";
      expCtrl.text = d.experienceInYear ?? "";
      bmdcCtrl.text = d.bmdcCode ?? "";
      aboutCtrl.text = d.about ?? "";
      selectedGender = d.gender;
    }

    selectedSpecialties = controller.selectedSpecialtyIds.toList();
  }

  // ================= IMAGE PICKER =================

  void _showImagePicker() {
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt, color: _green),
            title: const Text("Camera"),
            onTap: () {
              Get.back();
              _pickImage(ImageSource.camera); // ✅ FIX
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library, color: _green),
            title: const Text("Gallery"),
            onTap: () {
              Get.back();
              _pickImage(ImageSource.gallery); // ✅ FIX
            },
          ),
        ],
      ),
    ),
  );
}

Future<void> _pickImage(ImageSource source) async {
  final XFile? picked =
      await ImagePicker().pickImage(source: source, imageQuality: 60);

  if (picked == null) return;

  final file = File(picked.path);
  final bytes = await file.readAsBytes();
  final base64Image = base64Encode(bytes);

  final extension = picked.path.split('.').last.toLowerCase();

  // ✅ controller call (correct place)
  await controller.uploadProfileImage(base64Image, extension);

  setState(() {
    selectedImage = file; // UI update
  });
}


  // ================= UI =================

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        ImageProvider avatarImage;
        if (selectedImage != null) {
          avatarImage = FileImage(selectedImage!);
        } else if (controller.doctor.value?.photo != null &&
            controller.doctor.value!.photo!.isNotEmpty) {
          avatarImage = NetworkImage(
            controller.doctor.value!.photo!.startsWith("http")
                ? controller.doctor.value!.photo!
                : ApiConstants.imageBaseUrl +
                    controller.doctor.value!.photo!,
          );
        } else {
          avatarImage = const AssetImage("assets/images/user.png");
        }

        /// ---------- SAFE VALUES (FIX) ----------
        const genderItems = ["male", "female"];
        final safeGender =
            genderItems.contains(selectedGender) ? selectedGender : null;

        final specialtyIds =
            controller.specialtyList.map((e) => e.id).toSet();

        final safeSpecialty = selectedSpecialties.isNotEmpty &&
                specialtyIds.contains(selectedSpecialties.first)
            ? selectedSpecialties.first
            : null;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// PROFILE IMAGE
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 56,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: avatarImage,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: _showImagePicker,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: _green,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.edit,
                              color: Colors.white, size: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              _field("full_name".tr, nameCtrl),
              _field("about".tr, aboutCtrl, maxLines: 3),

              Row(
                children: [
                  Expanded(child: _field("experience_years".tr, expCtrl)),
                  const SizedBox(width: 14),
                  Expanded(child: _field("bmdc_code".tr, bmdcCtrl)),
                ],
              ),

              const SizedBox(height: 8),

              /// -------- GENDER (FIXED) --------
              DropdownButtonFormField<String>(
                value: safeGender,
                decoration: _inputDecoration("gender".tr),
                dropdownColor: Colors.white,
                items: genderItems
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.tr),
                      ),
                    )
                    .toList(),
                onChanged: (v) => setState(() => selectedGender = v),
              ),

              const SizedBox(height: 16),

              /// -------- SPECIALTY (FIXED) --------
              DropdownButtonFormField<String>(
                value: safeSpecialty,
                decoration: _inputDecoration("specialty".tr),
                dropdownColor: Colors.white,
                items: controller.specialtyList
                    .map(
                      (s) => DropdownMenuItem(
                        value: s.id,
                        child: Text(s.title ?? ""),
                      ),
                    )
                    .toList(),
                onChanged: (v) {
                  if (v != null) {
                    selectedSpecialties = [v];
                  }
                },
              ),

              const SizedBox(height: 32),

              /// UPDATE BUTTON
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed:
                      controller.isLoading.value ? null : updateProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          "update".tr,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

Future<void> updateProfile() async {
  if (selectedSpecialties.isEmpty) {
    Get.snackbar("error".tr, "please_select_specialty".tr);
    return;
  }

  if (controller.selectedHospitalId.value.isEmpty) {
    Get.snackbar("error".tr, "please_select_hospital".tr);
    return;
  }

  // ✅ FIX: image upload (with extension)
  if (selectedImage != null) {
    final file = selectedImage!;
    final bytes = await file.readAsBytes();
    final base64 = base64Encode(bytes);
    final extension = file.path.split('.').last.toLowerCase();

    await controller.uploadProfileImage(base64, extension);
  }

  final params = {
    "name": nameCtrl.text.trim(),
    "about": aboutCtrl.text.trim(),
    "experienceInYear": expCtrl.text.trim(),
    "bmdcCode": bmdcCtrl.text.trim(),
    "gender": selectedGender,

    // ✅ already correct
    "specialty": selectedSpecialties.first,
    "hospital": controller.selectedHospitalId.value,
  };

  final ok = await controller.updateBasicInfo(params);
  if (ok) {
    Get.snackbar(
      "success".tr,
      "profile_updated".tr,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}



  Widget _field(String label, TextEditingController c,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: c,
        minLines: 1,
        maxLines: maxLines,
        decoration: _inputDecoration(label),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
        labelStyle: const TextStyle(
        color: _green,
        fontWeight: FontWeight.w500,
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _green),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _green, width: 2),
      ),
    );
  }
}
