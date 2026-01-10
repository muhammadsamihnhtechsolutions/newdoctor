
import 'package:beh_doctor/views/EditProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beh_doctor/modules/auth/controller/DoctorProfileController.dart';
import 'package:beh_doctor/models/DoctorProfileModel.dart';
import 'package:beh_doctor/apiconstant/apiconstant.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

  static const Color _green = Color(0xFF008541);

  @override
  Widget build(BuildContext context) {
    final DoctorProfileController controller =
        Get.find<DoctorProfileController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("doctor_profile".tr),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final DoctorProfileData? d = controller.doctor.value;

        if (d == null) {
          return Center(child: Text("no_data".tr));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ================= HEADER CARD =================
              Container(
                padding: const EdgeInsets.all(16),
                decoration: _cardDecoration(),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: _green, width: 2),
                      ),
                      child: CircleAvatar(
                        radius: 46,
                        backgroundColor: Colors.grey.shade200,
                        child: ClipOval(
                          child: (d.photo != null &&
                                  d.photo!.isNotEmpty &&
                                  !d.photo!.contains('undefined'))
                              ? Image.network(
                                  d.photo!.startsWith("http")
                                      ? d.photo!
                                      : ApiConstants.imageBaseUrl + d.photo!,
                                  width: 92,
                                  height: 92,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      _profileFallback(),
                                )
                              : _profileFallback(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            d.name ?? "unknown".tr,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.phone, size: 16, color: _green),
                              const SizedBox(width: 6),
                              Text(
                                "${d.dialCode ?? ''}${d.phone ?? ''}",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// ================= BASIC INFO =================
              _sectionTitle("basic_info".tr),
              _infoCard(
                children: [
                  InfoRow(
                    icon: Icons.person,
                    title: "gender".tr,
                    value: d.gender,
                  ),
                  InfoRow(
                    icon: Icons.access_time,
                    title: "experience".tr,
                    value:
                        "${d.experienceInYear ?? "na".tr} ${"years".tr}",
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// ================= SPECIALTIES =================
              _sectionTitle("specialties".tr),
              Container(
                decoration: _cardDecoration(),
                padding: const EdgeInsets.all(12),
                child: d.specialty.isEmpty
                    ? Text("no_specialty".tr)
                    : Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: d.specialty
                            .map(
                              (s) => Chip(
                                backgroundColor:
                                    _green.withOpacity(0.1),
                                label: Text(
                                  s.title ?? "N/A",
                                  style: const TextStyle(
                                    color: _green,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
              ),

              const SizedBox(height: 24),

              /// ================= HOSPITALS =================
              _sectionTitle("hospitals".tr),
              Container(
                decoration: _cardDecoration(),
                padding: const EdgeInsets.all(12),
                child: d.hospital.isEmpty
                    ? Text("no_hospital".tr)
                    : Column(
                        children: d.hospital
                            .map(
                              (h) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.local_hospital,
                                        color: _green, size: 18),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        "${h.name} (${h.address})",
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
              ),

              const SizedBox(height: 30),

              /// ================= EDIT BUTTON =================
              ElevatedButton.icon(
                onPressed: () {
                  Get.to(() => EditProfileScreen());
                },
                icon: const Icon(Icons.edit),
                label: Text(
                  "edit_profile".tr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _green,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }

  /// ================= HELPERS =================

  Widget _profileFallback() {
    return Icon(
      Icons.person,
      size: 50,
      color: Colors.grey.shade600,
    );
  }

  Widget _sectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:
              const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        Container(
          width: 40,
          height: 3,
          decoration: BoxDecoration(
            color: _green,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  Widget _infoCard({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: _cardDecoration(),
      child: Column(
        children: children,
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? value;

  const InfoRow({
    super.key,
    required this.icon,
    required this.title,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: DoctorProfileScreen._green),
          const SizedBox(width: 8),
          Text(
            "$title: ",
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(
              value ?? "na".tr,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
