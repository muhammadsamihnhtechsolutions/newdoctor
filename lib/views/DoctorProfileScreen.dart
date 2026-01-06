
// import 'package:beh_doctor/views/EditProfileScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:beh_doctor/modules/auth/controller/DoctorProfileController.dart';
// import 'package:beh_doctor/models/DoctorProfileModel.dart';
// import 'package:beh_doctor/apiconstant/apiconstant.dart';

// class DoctorProfileScreen extends StatelessWidget {
//   const DoctorProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final DoctorProfileController controller =
//         Get.find<DoctorProfileController>();

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text("doctor_profile".tr), // 🔥 LOCALIZED
//         backgroundColor: Colors.white,
//         elevation: 1,
//         centerTitle: true,
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(child: CircularProgressIndicator());
//         }

//         final DoctorProfileData? d = controller.doctor.value;

//         if (d == null) {
//           return Center(child: Text("no_data".tr)); // 🔥 LOCALIZED
//         }

//         return SingleChildScrollView(
//           padding: EdgeInsets.all(18),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   CircleAvatar(
//                     radius: 50,
//                     backgroundColor: Colors.grey.shade200,
//                     backgroundImage: (d.photo != null && d.photo!.isNotEmpty)
//                         ? NetworkImage(
//                             d.photo!.startsWith("http")
//                                 ? d.photo!
//                                 : ApiConstants.imageBaseUrl + d.photo!,
//                           )
//                         : null,
//                     child: (d.photo == null || d.photo!.isEmpty)
//                         ? Icon(
//                             Icons.person,
//                             size: 55,
//                             color: Colors.grey.shade600,
//                           )
//                         : null,
//                   ),

//                   SizedBox(width: 16),

//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           d.name ?? "unknown".tr, // 🔥 LOCALIZED
//                           style: TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 6),
//                         Text(
//                           "${d.dialCode ?? ''}${d.phone ?? ''}",
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.grey.shade600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),

//               SizedBox(height: 25),

//               sectionTitle("basic_info".tr), // 🔥 LOCALIZED
//               infoCard(
//                 children: [
//                   InfoRow(title: "gender".tr, value: d.gender), // 🔥 LOCALIZED
//                   InfoRow(
//                     title: "experience".tr,
//                     value: "${d.experienceInYear ?? "na".tr} ${"years".tr}",
//                   ), // 🔥
//                 ],
//               ),

//               SizedBox(height: 20),

//               sectionTitle("specialties".tr), // 🔥 LOCALIZED
//               infoCard(
//                 children: d.specialty.isEmpty
//                     ? [Text("no_specialty".tr)] // 🔥
//                     : d.specialty
//                           .map(
//                             (s) => Padding(
//                               padding: EdgeInsets.symmetric(vertical: 4),
//                               child: Text(
//                                 "${s.title} • ${s.symptoms}",
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   color: Colors.grey.shade700,
//                                 ),
//                               ),
//                             ),
//                           )
//                           .toList(),
//               ),

//               SizedBox(height: 20),

//               sectionTitle("hospitals".tr), // 🔥
//               infoCard(
//                 children: d.hospital.isEmpty
//                     ? [Text("no_hospital".tr)] // 🔥
//                     : d.hospital
//                           .map(
//                             (h) => Padding(
//                               padding: EdgeInsets.symmetric(vertical: 4),
//                               child: Text(
//                                 "${h.name} (${h.address})",
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                   color: Colors.grey.shade700,
//                                 ),
//                               ),
//                             ),
//                           )
//                           .toList(),
//               ),

//               SizedBox(height: 20),

//               ElevatedButton.icon(
//                 onPressed: () {
//                   Get.to(() => EditProfileScreen());
//                 },
//                 icon: Icon(Icons.edit, size: 20),
//                 label: Text(
//                   "edit_profile".tr, // 🔥 LOCALIZED
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: Size(double.infinity, 48),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),

//               SizedBox(height: 30),
//             ],
//           ),
//         );
//       }),
//     );
//   }

//   Widget sectionTitle(String title) {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Text(
//         title,
//         style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
//       ),
//     );
//   }

//   Widget infoCard({required List<Widget> children}) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: Colors.grey.shade100,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: children,
//       ),
//     );
//   }
// }

// class InfoRow extends StatelessWidget {
//   final String title;
//   final String? value;

//   const InfoRow({super.key, required this.title, this.value});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: 10.0),
//       child: Row(
//         children: [
//           Text(
//             "$title: ",
//             style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//           ),
//           Expanded(
//             child: Text(
//               value ?? "na".tr,
//               style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:beh_doctor/views/EditProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beh_doctor/modules/auth/controller/DoctorProfileController.dart';
import 'package:beh_doctor/models/DoctorProfileModel.dart';
import 'package:beh_doctor/apiconstant/apiconstant.dart';

class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// ✅ FIXED PROFILE IMAGE (NO CRASH)
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade200,
                    child: ClipOval(
                      child: (d.photo != null &&
                              d.photo!.isNotEmpty &&
                              !d.photo!.contains('undefined'))
                          ? Image.network(
                              d.photo!.startsWith("http")
                                  ? d.photo!
                                  : ApiConstants.imageBaseUrl + d.photo!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) {
                                return Icon(
                                  Icons.person,
                                  size: 55,
                                  color: Colors.grey.shade600,
                                );
                              },
                            )
                          : Icon(
                              Icons.person,
                              size: 55,
                              color: Colors.grey.shade600,
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
                        Text(
                          "${d.dialCode ?? ''}${d.phone ?? ''}",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              sectionTitle("basic_info".tr),
              infoCard(
                children: [
                  InfoRow(title: "gender".tr, value: d.gender),
                  InfoRow(
                    title: "experience".tr,
                    value:
                        "${d.experienceInYear ?? "na".tr} ${"years".tr}",
                  ),
                ],
              ),

              const SizedBox(height: 20),

              sectionTitle("specialties".tr),
              infoCard(
                children: d.specialty.isEmpty
                    ? [Text("no_specialty".tr)]
                    : d.specialty
                        .map(
                          (s) => Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              "${s.title} • ${s.symptoms}",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),

              const SizedBox(height: 20),

              sectionTitle("hospitals".tr),
              infoCard(
                children: d.hospital.isEmpty
                    ? [Text("no_hospital".tr)]
                    : d.hospital
                        .map(
                          (h) => Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              "${h.name} (${h.address})",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: () {
                  Get.to(() => EditProfileScreen());
                },
                icon: const Icon(Icons.edit, size: 20),
                label: Text(
                  "edit_profile".tr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        );
      }),
    );
  }

  Widget sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style:
            const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget infoCard({required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String title;
  final String? value;

  const InfoRow({super.key, required this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
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
