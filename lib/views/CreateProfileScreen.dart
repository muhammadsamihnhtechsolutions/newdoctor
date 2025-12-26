import 'dart:convert';
import 'dart:io';
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

  String? selectedGender; // ✅ nullable
  File? selectedImage;

  Future<void> pickImage() async {
    final XFile? picked =
        await ImagePicker().pickImage(source: ImageSource.gallery);

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
      appBar: AppBar(title: Text("create_profile".tr)),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// IMAGE
              Stack(
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundImage: selectedImage != null
                        ? FileImage(selectedImage!)
                        : const AssetImage("assets/images/user.png")
                            as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: pickImage,
                      child: const CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.green,
                        child: Icon(Icons.camera_alt, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 25),

              field("full_name".tr, nameCtrl),
              field("about".tr, aboutCtrl, maxLines: 3),

              Row(
                children: [
                  Expanded(child: field("experience_years".tr, expCtrl)),
                  const SizedBox(width: 12),
                  Expanded(child: field("bmdc_code".tr, bmdcCtrl)),
                ],
              ),

              /// ✅ FIXED DROPDOWN
              DropdownButtonFormField<String>(
                value: selectedGender,
                hint: Text("select_gender".tr),
                decoration: inputDecoration(),
                items: const [
                  DropdownMenuItem(value: "male", child: Text("Male")),
                  DropdownMenuItem(value: "female", child: Text("Female")),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: createProfile,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.green,
                ),
                child: Text("create_profile".tr),
              ),
            ],
          ),
        );
      }),
    );
  }

  /// ✅ CREATE PROFILE + CONTROLLER UPDATE
  Future<void> createProfile() async {
    if (selectedGender == null) {
      Get.snackbar("error".tr, "please_select_gender".tr);
      return;
    }

    final params = {
      "name": nameCtrl.text.trim(),
      "about": aboutCtrl.text.trim(),
      "experienceInYear": expCtrl.text.trim(),
      "bmdcCode": bmdcCtrl.text.trim(),
      "gender": selectedGender,
    };

    final ok = await controller.createDoctorProfile(params);

    if (ok) {
      /// 🔥 refresh profile after create
      await controller.fetchDoctorProfile();

      Get.offAll(() => BottomNavScreen());
    }
  }

  Widget field(String label, TextEditingController c, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 6),
        TextField(
          controller: c,
          maxLines: maxLines,
          decoration: inputDecoration(),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  InputDecoration inputDecoration() =>
      const InputDecoration(border: OutlineInputBorder());
}
