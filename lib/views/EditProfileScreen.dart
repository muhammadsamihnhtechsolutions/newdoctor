import 'dart:convert';
import 'dart:io';
import 'package:beh_doctor/apiconstant/apiconstant.dart';
import 'package:beh_doctor/modules/auth/controller/DoctorProfileController.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final DoctorProfileController controller = Get.find();

  final nameCtrl = TextEditingController();
  final expCtrl = TextEditingController();
  final bmdcCtrl = TextEditingController();
  final aboutCtrl = TextEditingController();

  String? selectedGender;

  File? selectedImage;

  @override
  void initState() {
    super.initState();
    final d = controller.doctor.value;

    if (d != null) {
      nameCtrl.text = d.name ?? "";
      expCtrl.text = d.experienceInYear ?? "";
      bmdcCtrl.text = d.bmdcCode ?? "";
      aboutCtrl.text = d.about ?? "";
      selectedGender = d.gender ?? "male";
    }
  }

  // Pick Image
  Future<void> pickImage() async {
    final XFile? picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (picked != null) {
      selectedImage = File(picked.path);

      final bytes = selectedImage!.readAsBytesSync();
      final base64 = base64Encode(bytes);

      await controller.uploadProfileImage(base64);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("edit_profile".tr)),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// ----------------------
              /// Profile Image
              /// ----------------------
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundImage: selectedImage != null
                          ? FileImage(selectedImage!)
                          : (controller.doctor.value?.photo != null
                                    ? NetworkImage(
                                        ApiConstants.imageBaseUrl +
                                            controller.doctor.value!.photo!,
                                      )
                                    : const AssetImage(
                                        "assets/images/user.png",
                                      ))
                                as ImageProvider,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: pickImage,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              /// Full name
              Align(
                alignment: AlignmentGeometry.topLeft,
                child: fieldLabel("full_name".tr),
              ),
              inputField(nameCtrl),

              const SizedBox(height: 15),

              /// About
              Align(
                alignment: AlignmentGeometry.topLeft,
                child: fieldLabel("about".tr),
              ),
              inputField(aboutCtrl, maxLines: 3),

              const SizedBox(height: 15),

              /// Experience + BMDC
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        fieldLabel("experience_years".tr),
                        inputField(expCtrl),
                      ],
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        fieldLabel("bmdc_code".tr),
                        inputField(bmdcCtrl),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              /// Gender
              Align(
                alignment: AlignmentGeometry.topLeft,
                child: fieldLabel("gender".tr),
              ),
              DropdownButtonFormField<String>(
                value: selectedGender,
                decoration: dropDecoration(),
                items: ["male", "female"]
                    .map((e) => DropdownMenuItem(child: Text(e.tr), value: e))
                    .toList(),
                onChanged: (v) => setState(() => selectedGender = v),
              ),

              const SizedBox(height: 30),

              Obx(
                () => ElevatedButton(
                  onPressed: controller.isLoading.value ? null : updateProfile,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.green,
                  ),
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          "update".tr,
                          style: const TextStyle(
                            fontSize: 16,
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

  /// -------------------------------
  /// SAVE / UPDATE PROFILE CALL
  /// -------------------------------
  Future<void> updateProfile() async {
    final params = {
      "name": nameCtrl.text.trim(),
      "about": aboutCtrl.text.trim(),
      "experienceInYear": expCtrl.text.trim(),
      "bmdcCode": bmdcCtrl.text.trim(),
      "gender": selectedGender,
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

  /// -------------------------------
  /// UI Helpers
  /// -------------------------------
  Widget fieldLabel(String t) =>
      Padding(padding: const EdgeInsets.only(bottom: 6), child: Text(t));

  Widget inputField(TextEditingController c, {int maxLines = 1}) {
    return TextField(
      controller: c,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  InputDecoration dropDecoration() => InputDecoration(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  );
}
