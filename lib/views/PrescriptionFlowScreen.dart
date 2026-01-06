

// // addinvestigation
// import 'package:beh_doctor/modules/auth/controller/PrescriptionFlowController.dart';
// import 'package:beh_doctor/theme/Appcolars.dart';
// import 'package:beh_doctor/views/PrescriptionOverviewScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class PrescriptionFlowScreen extends StatefulWidget {
//   final String appointmentId;
//   final int callDuration;

//   const PrescriptionFlowScreen({
//     super.key,
//     required this.appointmentId,
//     required this.callDuration,
//   });

//   @override
//   State<PrescriptionFlowScreen> createState() =>
//       _PrescriptionFlowScreenState();
// }

// class _PrescriptionFlowScreenState extends State<PrescriptionFlowScreen> {
//   late final PrescriptionFlowController controller;
//   final PageController _pageController = PageController();

//   final TextEditingController _chiefComplaints = TextEditingController();
//   final TextEditingController _diagnosis = TextEditingController();
//   final TextEditingController _surgery = TextEditingController();
//   final TextEditingController _referredTo = TextEditingController();
//   final TextEditingController _followUpDate = TextEditingController();

//   final List<TextEditingController> _medicineNoteCtrls = [];

//   final Color _green = const Color(0xFF2E7D32);

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   controller = Get.put(PrescriptionFlowController(), permanent: true);
//   //   controller.fetchMedicineNames();
//   //   _followUpDate.text =
//   //       DateFormat('yyyy-MM-dd').format(DateTime.now());
//   // }
// @override
// void initState() {
//   super.initState();

//   controller = Get.put(PrescriptionFlowController(), permanent: true);

//   /// reset old data
//   controller.resetFlow();

//   /// ✅ wait until PageView is attached
//   WidgetsBinding.instance.addPostFrameCallback((_) {
//     if (_pageController.hasClients) {
//       _pageController.jumpToPage(0);
//     }
//   });

//   controller.fetchMedicineNames();

//   _followUpDate.text =
//       DateFormat('yyyy-MM-dd').format(DateTime.now());
// }



//   @override
//   void dispose() {
//     _pageController.dispose();
//     _chiefComplaints.dispose();
//     _diagnosis.dispose();
//     _surgery.dispose();
//     _referredTo.dispose();
//     _followUpDate.dispose();

//     for (final c in _medicineNoteCtrls) {
//       c.dispose();
//     }
//     super.dispose();
//   }

//   void _syncMedicineNotes() {
//     while (_medicineNoteCtrls.length <
//         controller.medicines.length) {
//       _medicineNoteCtrls.add(TextEditingController());
//     }

//     while (_medicineNoteCtrls.length >
//         controller.medicines.length) {
//       _medicineNoteCtrls.removeLast().dispose();
//     }
//   }

//   void _next() {
//     final idx = controller.step.value;

//     if (idx == 1) {
//       if (_chiefComplaints.text.trim().isEmpty ||
//           _diagnosis.text.trim().isEmpty ||
//           controller.investigationList.isEmpty ||
//           _surgery.text.trim().isEmpty) {
//         Get.snackbar('Error', 'Please fill all fields');
//         return;
//       }

//       controller.chiefComplaints
//         ..clear()
//         ..add(_chiefComplaints.text.trim());
//       controller.diagnosisList
//         ..clear()
//         ..add(_diagnosis.text.trim());
//       controller.surgeryList
//         ..clear()
//         ..add(_surgery.text.trim());

//       controller.step.value = 2;
//       _pageController.nextPage(
//         duration: const Duration(milliseconds: 200),
//         curve: Curves.easeInOut,
//       );
//       return;
//     }

//     if (idx == 2) {
//       controller.step.value = 3;
//       _pageController.nextPage(
//         duration: const Duration(milliseconds: 200),
//         curve: Curves.easeInOut,
//       );
//       return;
//     }

//     if (idx == 3) {
//       if (_referredTo.text.trim().isEmpty) {
//         Get.snackbar('Error', 'Referred to required');
//         return;
//       }

//       controller.referredTo.value = _referredTo.text.trim();
//       controller.followUpDate.value = _followUpDate.text.trim();

//       Get.to(
//         () => PrescriptionOverviewScreen(
//           appointmentId: widget.appointmentId,
//           callDuration: widget.callDuration,
//           payload: controller.buildPayload(widget.appointmentId),
//         ),
//       );
//     }
//   }

//   void _back() {
//     if (controller.step.value <= 1) return;
//     controller.step.value--;
//     _pageController.previousPage(
//       duration: const Duration(milliseconds: 200),
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       _syncMedicineNotes();

//       return Scaffold(
//         appBar: AppBar(
//           backgroundColor: AppColors.white,
//           title: const Text('Prescription'),
//         ),
//         body: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(14),
//               child: Text(
//                 'Step ${controller.step.value} of 3',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: _green,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: PageView(
//                 controller: _pageController,
//                 physics: const NeverScrollableScrollPhysics(),
//                 children: [
//                   _stepOneUI(),
//                   _stepTwoUI(),
//                   _stepThreeUI(),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(14),
//               child: Row(
//                 children: [
//                   if (controller.step.value > 1)
//                     Expanded(
//                       child: OutlinedButton(
//                         onPressed: _back,
//                         child: const Text('Back'),
//                       ),
//                     ),
//                   if (controller.step.value > 1)
//                     const SizedBox(width: 12),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: _next,
//                       child: Text(
//                         controller.step.value == 3
//                             ? 'Review'
//                             : 'Next',
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }

//   // ---------------- STEP 1 ----------------
//   Widget _stepOneUI() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           _field('Chief Complaints', _chiefComplaints),
//           _field('Diagnosis', _diagnosis),

//           /// 🔽 INVESTIGATION DROPDOWN (API)
//           Obx(() {
//             if (controller.isInvestigationLoading.value) {
//               return const Padding(
//                 padding: EdgeInsets.only(bottom: 14),
//                 child: CircularProgressIndicator(),
//               );
//             }

//             return Padding(
//               padding: const EdgeInsets.only(bottom: 14),
//               child: DropdownButtonFormField<String>(
//                 decoration: _inputDecoration('Investigations'),
//                 value: controller.investigationList.isEmpty
//                     ? null
//                     : controller.investigationList.first,
//                 items: controller.investigationOptions
//                     .map(
//                       (inv) => DropdownMenuItem<String>(
//                         value: inv.name,
//                         child: Text(inv.name),
//                       ),
//                     )
//                     .toList(),
//                 onChanged: (v) {
//                   if (v == null) return;

//                   final selected =
//                       controller.investigationOptions.firstWhere(
//                     (e) => e.name == v,
//                   );

//                   controller.investigationList.clear();
//                   controller.addInvestigationFromDropdown(selected);
//                 },
//               ),
//             );
//           }),

//           _field('Surgery', _surgery),
//         ],
//       ),
//     );
//   }

//   // ---------------- STEP 2 ----------------
//  Widget _stepTwoUI() {
//   return SingleChildScrollView(
//     padding: const EdgeInsets.all(16),
//     child: Obx(
//       () => Column(
//         children: [
//           if (controller.isMedicineLoading.value)
//             const CircularProgressIndicator()
//           else
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: controller.medicines.length,
//               itemBuilder: (_, i) {
//                 return Card(
//                   margin: const EdgeInsets.only(bottom: 14),
//                   child: Padding(
//                     padding: const EdgeInsets.all(14),
//                     child: Column(
//                       children: [
//                         /// 🔽 MEDICINE DROPDOWN
//                         DropdownButtonFormField<String>(
//                           value: controller.medicines[i]['name']!.isEmpty
//                               ? null
//                               : controller.medicines[i]['name'],
//                           decoration: _inputDecoration('Medicine'),

//                           items: controller.medicineOptions
//                               .map(
//                                 (m) => DropdownMenuItem<String>(
//                                   value: m.name,
//                                   child: Text(m.name), // ✅ FIXED
//                                 ),
//                               )
//                               .toList(),
// onChanged: (v) {
//   controller.medicines[i] = {
//     "name": v ?? "__none__",
//     "note": controller.medicines[i]["note"] ?? "",
//   };
// },

//                         ),

//                         const SizedBox(height: 12),

//                         /// 📝 INSTRUCTION
//                         _field(
//                           'Instruction',
//                           _medicineNoteCtrls[i],
//                         ),

//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: IconButton(
//                             icon: const Icon(
//                               Icons.delete,
//                               color: Colors.red,
//                             ),
//                             onPressed: () =>
//                                 controller.removeMedicine(i),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),

//           /// ➕ ADD MEDICINE
//           OutlinedButton.icon(
//             onPressed: controller.addEmptyMedicine,
//             icon: const Icon(Icons.add),
//             label: const Text('Add Medicine'),
//           ),
//         ],
//       ),
//     ),
//   );
// }
//   // ---------------- STEP 3 ----------------
//   Widget _stepThreeUI() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           _field('Referred To', _referredTo),
//           _field('Follow-up Date', _followUpDate),
//         ],
//       ),
//     );
//   }

//   Widget _field(String label, TextEditingController c) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 14),
//       child: TextField(
//         controller: c,
//         decoration: _inputDecoration(label),
//       ),
//     );
//   }

//   InputDecoration _inputDecoration(String label) {
//     return InputDecoration(
//       labelText: label,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//     );
//   }
// }


import 'package:beh_doctor/modules/auth/controller/PrescriptionFlowController.dart';

import 'package:beh_doctor/views/PrescriptionOverviewScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PrescriptionFlowScreen extends StatefulWidget {
  final String appointmentId;
  final int callDuration;

  const PrescriptionFlowScreen({
    super.key,
    required this.appointmentId,
    required this.callDuration,
  });

  @override
  State<PrescriptionFlowScreen> createState() =>
      _PrescriptionFlowScreenState();
}

class _PrescriptionFlowScreenState extends State<PrescriptionFlowScreen> {
  late final PrescriptionFlowController controller;
  final PageController _pageController = PageController();

  final TextEditingController _chiefComplaints = TextEditingController();
  final TextEditingController _diagnosis = TextEditingController();
  final TextEditingController _surgery = TextEditingController();
  final TextEditingController _referredTo = TextEditingController();
  final TextEditingController _followUpDate = TextEditingController();

  final List<TextEditingController> _medicineNoteCtrls = [];

  /// 🌿 Green Theme
final Color _green = const Color(0xFF008541);


  @override
  void initState() {
    super.initState();

    controller = Get.put(PrescriptionFlowController(), permanent: true);
    controller.resetFlow();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_pageController.hasClients) {
        _pageController.jumpToPage(0);
      }
    });

    controller.fetchMedicineNames();
    _followUpDate.text =
        DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  @override
  void dispose() {
    _pageController.dispose();
    _chiefComplaints.dispose();
    _diagnosis.dispose();
    _surgery.dispose();
    _referredTo.dispose();
    _followUpDate.dispose();

    for (final c in _medicineNoteCtrls) {
      c.dispose();
    }
    super.dispose();
  }

  void _syncMedicineNotes() {
    while (_medicineNoteCtrls.length < controller.medicines.length) {
      _medicineNoteCtrls.add(TextEditingController());
    }
    while (_medicineNoteCtrls.length > controller.medicines.length) {
      _medicineNoteCtrls.removeLast().dispose();
    }
  }

  void _next() {
    final idx = controller.step.value;

    if (idx == 1) {
      if (_chiefComplaints.text.trim().isEmpty ||
          _diagnosis.text.trim().isEmpty ||
          controller.investigationList.isEmpty ||
          _surgery.text.trim().isEmpty) {
        Get.snackbar('Error', 'Please fill all fields');
        return;
      }

      controller.chiefComplaints
        ..clear()
        ..add(_chiefComplaints.text.trim());
      controller.diagnosisList
        ..clear()
        ..add(_diagnosis.text.trim());
      controller.surgeryList
        ..clear()
        ..add(_surgery.text.trim());

      controller.step.value = 2;
      _pageController.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
      return;
    }

    if (idx == 2) {
      controller.step.value = 3;
      _pageController.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
      return;
    }

    if (idx == 3) {
      if (_referredTo.text.trim().isEmpty) {
        Get.snackbar('Error', 'Referred to required');
        return;
      }

      controller.referredTo.value = _referredTo.text.trim();
      controller.followUpDate.value = _followUpDate.text.trim();

      Get.to(
        () => PrescriptionOverviewScreen(
          appointmentId: widget.appointmentId,
          callDuration: widget.callDuration,
          payload: controller.buildPayload(widget.appointmentId),
        ),
      );
    }
  }

  void _back() {
    if (controller.step.value <= 1) return;
    controller.step.value--;
    _pageController.previousPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      _syncMedicineNotes();

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Prescription',
            style: TextStyle(color: _green),
          ),
          iconTheme: IconThemeData(color: _green),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: Text(
                'Step ${controller.step.value} of 3',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _green,
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _stepOneUI(),
                  _stepTwoUI(),
                  _stepThreeUI(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  if (controller.step.value > 1)
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: _green),
                          foregroundColor: _green,
                          padding:
                              const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: _back,
                        child: const Text('Back'),
                      ),
                    ),
                  if (controller.step.value > 1)
                    const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _green,
                        foregroundColor: Colors.white,
                        padding:
                            const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _next,
                      child: Text(
                        controller.step.value == 3
                            ? 'Review'
                            : 'Next',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  // ---------------- STEP 1 ----------------
 Widget _stepOneUI() {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        _formBox(
          child: Column(
            children: [
              _field('Chief Complaints', _chiefComplaints),
              _field('Diagnosis', _diagnosis),

              /// 🔽 INVESTIGATION DROPDOWN (API)
              Obx(() {
                if (controller.isInvestigationLoading.value) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 14),
                    child: CircularProgressIndicator(),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: DropdownButtonFormField<String>(
                    dropdownColor: Colors.white,
                    decoration: _inputDecoration('Investigations'),
                    value: controller.investigationList.isEmpty
                        ? null
                        : controller.investigationList.first,
                    items: controller.investigationOptions
                        .map(
                          (inv) => DropdownMenuItem<String>(
                            value: inv.name,
                            child: Text(
                              inv.name,
                              style: TextStyle(
                                color: _green,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (v) {
                      if (v == null) return;

                      final selected =
                          controller.investigationOptions.firstWhere(
                        (e) => e.name == v,
                      );

                      controller.investigationList.clear();
                      controller.addInvestigationFromDropdown(selected);
                    },
                  ),
                );
              }),

              _field('Surgery', _surgery),
            ],
          ),
        ),
      ],
    ),
  );
}

  // ---------------- STEP 2 ----------------
Widget _stepTwoUI() {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Obx(
      () => Column(
        children: [
          if (controller.isMedicineLoading.value)
            const CircularProgressIndicator()
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.medicines.length,
              itemBuilder: (_, i) {
                return Card(
                  color: Colors.white, // ✅ box white
                  margin: const EdgeInsets.only(bottom: 14),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      children: [
                        /// 🔽 MEDICINE DROPDOWN
                        DropdownButtonFormField<String>(
                          dropdownColor: Colors.white, // ✅ dropdown bg white
                          value: controller.medicines[i]['name']!.isEmpty
                              ? null
                              : controller.medicines[i]['name'],
                          decoration: _inputDecoration('Medicine').copyWith(
                            labelStyle: TextStyle(color: _green), // ✅ label green
                          ),
                          items: controller.medicineOptions
                              .map(
                                (m) => DropdownMenuItem<String>(
                                  value: m.name,
                                  child: Text(
                                    m.name,
                                    style: TextStyle(
                                      color: _green, // ✅ text green
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (v) {
                            controller.medicines[i] = {
                              "name": v ?? "__none__",
                              "note": controller.medicines[i]["note"] ?? "",
                            };
                          },
                        ),

                        const SizedBox(height: 12),

                        /// 📝 INSTRUCTION
                        _field(
                          'Instruction',
                          _medicineNoteCtrls[i],
                        ),

                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () =>
                                controller.removeMedicine(i),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

          const SizedBox(height: 12),

          /// ➕ ADD MEDICINE
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: _green, // ✅ green bg
                foregroundColor: Colors.white, // ✅ white text
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: controller.addEmptyMedicine,
              icon: const Icon(Icons.add),
              label: const Text(
                'Add Medicine',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  // ---------------- STEP 3 ----------------
  Widget _stepThreeUI() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _field('Referred To', _referredTo),
          _field('Follow-up Date', _followUpDate),
        ],
      ),
    );
  }

 Widget _field(String label, TextEditingController c) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: TextField(
      controller: c,
      minLines: 1,
      maxLines: 3,
      cursorColor: _green, // ✅ cursor green
      style: TextStyle(color: _green),
      decoration: _inputDecoration(label),
    ),
  );
}


  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
 labelText: label,

    /// ✅ label ka default color
    labelStyle: TextStyle(
      color: _green,
      fontWeight: FontWeight.w500,
    ),

    /// ✅ jab field select ho (floating label)
    floatingLabelStyle: TextStyle(
      color: _green,
      fontWeight: FontWeight.w600,
    ),
      
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _green),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _green, width: 2),
      ),
    );
  }
}

Widget _formBox({required Widget child}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      // border: Border.all(color: _green.withOpacity(0.6)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: child,
  );
  
}

