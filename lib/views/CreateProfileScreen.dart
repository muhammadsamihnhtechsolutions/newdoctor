

import 'dart:convert';
import 'dart:io';
import 'package:beh_doctor/apiconstant/apiconstant.dart';
import 'package:beh_doctor/views/BottomNavScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:beh_doctor/modules/auth/controller/DoctorProfileController.dart';

class CreateProfileScreen extends StatefulWidget {
  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final DoctorProfileController controller = Get.find();

  final nameCtrl = TextEditingController();
  final expCtrl = TextEditingController();
  final bmdcCtrl = TextEditingController();
  final aboutCtrl = TextEditingController();

  String? selectedGender;
  String? selectedSpecialty;
  String? selectedHospital;
  File? selectedImage;

  static const Color _green = Color(0xFF008541);

  @override
  void initState() {
    super.initState();
    controller.fetchSpecialties();
    controller.fetchHospitals();
  }

  /// ================= IMAGE PICKER =================
  void _showImagePickerSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt, color: _green),
              title: const Text("Camera"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo, color: _green),
              title: const Text("Gallery"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  

Future<void> _pickImage(ImageSource source) async {
  final XFile? picked = await ImagePicker().pickImage(source: source);
  if (picked == null) return;

  selectedImage = File(picked.path);

  final bytes = await selectedImage!.readAsBytes();
  final base64 = base64Encode(bytes);

  /// 🔥 EXTENSION AUTO DETECT
  final extension = picked.path.split('.').last.toLowerCase();

  await controller.uploadProfileImage(base64, extension);

  setState(() {});
}

  /// ================= UI =================
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(), // ✅ keyboard dismiss
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: _green),
          title: Text(
            "create_profile".tr,
            style: const TextStyle(
              color: _green,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// PROFILE IMAGE
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: selectedImage != null
                            ? FileImage(selectedImage!)
                            : (controller.doctor.value?.photo != null
                                ? NetworkImage(
                                    ApiConstants.imageBaseUrl +
                                        controller.doctor.value!.photo!,
                                  )
                                : null),
                        child: (selectedImage == null &&
                                controller.doctor.value?.photo == null)
                            ? const Icon(Icons.person,
                                size: 45, color: Colors.grey)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: _showImagePickerSheet,
                          child: const CircleAvatar(
                            radius: 18,
                            backgroundColor: _green,
                            child: Icon(Icons.camera_alt,
                                color: Colors.white, size: 18),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                _field("full_name".tr, nameCtrl),
                _field("about".tr, aboutCtrl, maxLines: 3),

                Row(
                  children: [
                    Expanded(
                        child:
                            _field("experience_years".tr, expCtrl)),
                    const SizedBox(width: 12),
                    Expanded(
                        child: _field("bmdc_code".tr, bmdcCtrl)),
                  ],
                ),

                /// GENDER
                DropdownButtonFormField<String>(
                  value: selectedGender,
                  decoration: _inputDecoration("select_gender".tr),
                  dropdownColor: Colors.white,
                  items: const [
                    DropdownMenuItem(
                        value: "male",
                        child: Text("Male",
                            style: TextStyle(color: _green))),
                    DropdownMenuItem(
                        value: "female",
                        child: Text("Female",
                            style: TextStyle(color: _green))),
                  ],
                  onChanged: (value) =>
                      setState(() => selectedGender = value),
                ),

                const SizedBox(height: 16),

                /// SPECIALTY
                DropdownButtonFormField<String>(
                  value: selectedSpecialty,
                  decoration: _inputDecoration("select_specialty".tr),
                  dropdownColor: Colors.white,
                  items: controller.specialtyList.map((s) {
                    return DropdownMenuItem(
                      value: s.id,
                      child: Text(
                        s.title ?? "",
                        style: const TextStyle(color: _green),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSpecialty = value;
                      controller.selectedSpecialtyIds
                          .assignAll(value != null ? [value] : []);
                    });
                  },
                ),

                const SizedBox(height: 16),

                /// HOSPITAL
                DropdownButtonFormField<String>(
                  value: selectedHospital,
                  decoration: _inputDecoration("select_hospital".tr),
                  dropdownColor: Colors.white,
                  items: controller.hospitalList.map((h) {
                    return DropdownMenuItem(
                      value: h.id,
                      child: Text(
                        h.name ?? "",
                        style: const TextStyle(color: _green),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedHospital = value;
                      controller.selectedHospitalIds
                          .assignAll(value != null ? [value] : []);
                    });
                  },
                ),

                const SizedBox(height: 30),

                /// BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _createProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _green,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      "Create Profile",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  /// ================= CREATE PROFILE =================
Future<void> _createProfile() async {
  if (selectedGender == null) {
    Get.snackbar("Error", "Please select gender");
    return;
  }

  if (controller.selectedSpecialtyIds.isEmpty ||
      controller.selectedHospitalIds.isEmpty) {
    Get.snackbar("Error", "Please select all fields");
    return;
  }

  final params = {
    "name": nameCtrl.text.trim(),
    "about": aboutCtrl.text.trim(),
    "experienceInYear": expCtrl.text.trim(),
    "bmdcCode": bmdcCtrl.text.trim(),
    "gender": selectedGender,
    "specialty": controller.selectedSpecialtyIds.first,
    "hospital": controller.selectedHospitalIds.first,
  };

  try {
    await controller.createDoctorProfile(params);
    await controller.fetchDoctorProfile();

    /// ✅ FORCE NAVIGATION (NO FAIL)
    Get.offAll(() => BottomNavScreen());
  } catch (e) {
    Get.snackbar("Error", "Profile create failed");
  }
}


  /// ================= FIELD =================
  Widget _field(String label, TextEditingController c,
      {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: c,
        minLines: 1,
        maxLines: maxLines,
        cursorColor: _green,
        style: const TextStyle(color: _green),
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
      floatingLabelStyle: const TextStyle(
        color: _green,
        fontWeight: FontWeight.w600,
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
