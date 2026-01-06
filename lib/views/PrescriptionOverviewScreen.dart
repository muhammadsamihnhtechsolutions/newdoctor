
// import 'package:beh_doctor/modules/auth/controller/AgoraCallController.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class PrescriptionOverviewScreen extends StatelessWidget {
//   final Map<String, dynamic> payload;
//   final int callDuration;
//   final String appointmentId;

//   PrescriptionOverviewScreen({
//     super.key,
//     required this.payload,
//     required this.callDuration,
//     required this.appointmentId,
//   });

//   final AgoraCallController controller = Get.find<AgoraCallController>();

//   // ---------------- THEME COLORS ----------------
//   static const Color _primaryColor = Color(0xFF008541);
//   static const Color _lightGreen = Color(0xFFE9F6EF);
//   static const Color _borderGreen = Color(0xFF3CB371);
//   static const Color _textDark = Color(0xFF001B0D);
//   static const Color _buttonText = Color(0xFFFFFFFF);

//   String _txt(dynamic v) => v == null ? "" : v.toString();

//   String _first(dynamic v) {
//     if (v == null) return "";
//     if (v is List && v.isNotEmpty) return _txt(v.first);
//     return _txt(v);
//   }

//   // ---------------- UI HELPERS ----------------

//   Widget _title(String t) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 4),
//       child: Text(
//         t,
//         style: const TextStyle(
//           fontWeight: FontWeight.w600,
//           fontSize: 14,
//           color: _primaryColor,
//         ),
//       ),
//     );
//   }

//   Widget _value(String t) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: _lightGreen,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: _borderGreen, width: 1),
//       ),
//       child: Text(
//         t,
//         style: const TextStyle(
//           fontSize: 14,
//           color: _textDark,
//         ),
//       ),
//     );
//   }

//   // ---------------- SAFE MEDICINES ----------------
//   List<Map<String, dynamic>> _medicines() {
//     final v = payload["medicines"];
//     if (v is List) {
//       return v.whereType<Map>().map((e) {
//         return {
//           "name": e["medicine"] ?? "",
//           "note": e["instruction"] ?? "",
//         };
//       }).toList();
//     }
//     return const [];
//   }

//   Widget _actionButton({
//     required String title,
//     required VoidCallback onTap,
//     required Color color,
//   }) {
//     return SizedBox(
//       height: 54,
//       child: ElevatedButton(
//         onPressed: onTap,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: color,
//           elevation: 0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         child: Text(
//           title,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w600,
//             color: _buttonText,
//           ),
//         ),
//       ),
//     );
//   }

//   // ---------------- BUILD ----------------
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text("overview".tr),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         foregroundColor: _primaryColor,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Get.back(),
//         ),
//       ),
//       body: Obx(() {
//         if (controller.isPrescriptionLoading.value) {
//           return const Center(
//             child: CircularProgressIndicator(
//               strokeWidth: 2,
//               valueColor: AlwaysStoppedAnimation(_primaryColor),
//             ),
//           );
//         }

//         final meds = _medicines();

//         return Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(14),
//                       border: Border.all(color: _borderGreen, width: 1),
//                       color: Colors.white,
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         _title("chief_complaints".tr),
//                         _value(_txt(payload["note"])),
//                         const SizedBox(height: 14),

//                         _title("diagnosis".tr),
//                         _value(_first(payload["diagnosis"])),
//                         const SizedBox(height: 14),

//                         _title("investigations".tr),
//                         _value(_first(payload["investigations"])),
//                         const SizedBox(height: 14),

//                         _title("surgery".tr),
//                         _value(_first(payload["surgery"])),
//                         const SizedBox(height: 14),

//                         _title("medicine".tr),
//                         const SizedBox(height: 6),
//                         ...meds.asMap().entries.map((e) {
//                           final i = e.key;
//                           final m = e.value;
//                           return Container(
//                             margin: const EdgeInsets.only(bottom: 10),
//                             padding: const EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               color: _lightGreen,
//                               borderRadius: BorderRadius.circular(10),
//                               border: Border.all(
//                                 color: _borderGreen,
//                                 width: 1,
//                               ),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   '${i + 1}. ${_txt(m["name"])}',
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                     color: _textDark,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   '${"notes".tr}: ${_txt(m["note"])}',
//                                   style: const TextStyle(
//                                     color: _textDark,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           );
//                         }),

//                         _title("follow_up_date".tr),
//                         _value(_txt(payload["followUpDate"])),
//                         const SizedBox(height: 14),

//                         _title("referred_to".tr),
//                         _value(_txt(payload["referredTo"])),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   Expanded(
//                     child: _actionButton(
//                       title: 'back_to_edit'.tr,
//                       color: const Color(0xFF9EA3AE),
//                       onTap: Get.back,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: _actionButton(
//                       title: 'confirm'.tr,
//                       color: _primaryColor,
//                       onTap: () {
//                         controller.submitPrescriptionAndCompleteCall(
//                           payload: payload,
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }

import 'package:beh_doctor/modules/auth/controller/AgoraCallController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrescriptionOverviewScreen extends StatelessWidget {
  final Map<String, dynamic> payload;
  final int callDuration;
  final String appointmentId;

  PrescriptionOverviewScreen({
    super.key,
    required this.payload,
    required this.callDuration,
    required this.appointmentId,
  });

  final AgoraCallController controller = Get.find<AgoraCallController>();

  // ---------------- THEME COLORS ----------------
  static const Color _primaryColor = Color(0xFF008541);
  static const Color _lightGreen = Color(0xFFE9F6EF);
  static const Color _borderGreen = Color(0xFF3CB371);
  static const Color _textDark = Color(0xFF001B0D);
  static const Color _buttonText = Colors.white;

  String _txt(dynamic v) => v == null ? "" : v.toString();
  String _first(dynamic v) =>
      (v is List && v.isNotEmpty) ? _txt(v.first) : _txt(v);

  // ---------------- UI HELPERS ----------------

  Widget _section(String title, Widget child) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _borderGreen.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _primaryColor,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  Widget _value(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _lightGreen,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: _textDark,
          height: 1.4,
        ),
      ),
    );
  }

  // ---------------- MEDICINES ----------------
  List<Map<String, dynamic>> _medicines() {
    final v = payload["medicines"];
    if (v is List) {
      return v.whereType<Map>().map((e) {
        return {
          "name": e["medicine"] ?? "",
          "note": e["instruction"] ?? "",
        };
      }).toList();
    }
    return const [];
  }

  Widget _actionButton({
    required String title,
    required VoidCallback onTap,
    required Color color,
  }) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: _buttonText,
          ),
        ),
      ),
    );
  }

  // ---------------- BUILD ----------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F9F7),
      appBar: AppBar(
        title: Text("overview".tr),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: _primaryColor,
      ),
      body: Obx(() {
        if (controller.isPrescriptionLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(_primaryColor),
            ),
          );
        }

        final meds = _medicines();

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _section(
                        "chief_complaints".tr,
                        _value(_txt(payload["note"])),
                      ),
                      _section(
                        "diagnosis".tr,
                        _value(_first(payload["diagnosis"])),
                      ),
                      _section(
                        "investigations".tr,
                        _value(_first(payload["investigations"])),
                      ),
                      _section(
                        "surgery".tr,
                        _value(_first(payload["surgery"])),
                      ),

                      /// MEDICINES
                      _section(
                        "medicine".tr,
                        Column(
                          children: meds.asMap().entries.map((e) {
                            final i = e.key;
                            final m = e.value;
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: _lightGreen,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${i + 1}. ${_txt(m["name"])}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: _textDark,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${"notes".tr}: ${_txt(m["note"])}',
                                    style: const TextStyle(
                                      color: _textDark,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      _section(
                        "follow_up_date".tr,
                        _value(_txt(payload["followUpDate"])),
                      ),
                      _section(
                        "referred_to".tr,
                        _value(_txt(payload["referredTo"])),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _actionButton(
                      title: 'back_to_edit'.tr,
                      color: const Color(0xFF9EA3AE),
                      onTap: Get.back,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _actionButton(
                      title: 'confirm'.tr,
                      color: _primaryColor,
                      onTap: () {
                        controller.submitPrescriptionAndCompleteCall(
                          payload: payload,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
