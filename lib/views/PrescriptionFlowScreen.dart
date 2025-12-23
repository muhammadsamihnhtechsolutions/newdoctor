
// import 'package:beh_doctor/modules/auth/controller/PrescriptionFlowController.dart';
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
//   State<PrescriptionFlowScreen> createState() => _PrescriptionFlowScreenState();
// }

// class _PrescriptionFlowScreenState extends State<PrescriptionFlowScreen> {
//   late final PrescriptionFlowController controller;
//   final PageController _pageController = PageController();

//   final TextEditingController _chiefComplaints = TextEditingController();
//   final TextEditingController _diagnosis = TextEditingController();
//   final TextEditingController _investigations = TextEditingController();
//   final TextEditingController _surgery = TextEditingController();
//   final TextEditingController _referredTo = TextEditingController();
//   final TextEditingController _followUpDate = TextEditingController();

//   final List<TextEditingController> _medicineNameCtrls = [];
//   final List<TextEditingController> _medicineNoteCtrls = [];

//   final Color _green = const Color(0xFF2E7D32);

//   @override
//   void initState() {
//     super.initState();
//     controller = Get.put(PrescriptionFlowController(), permanent: true);
//     _followUpDate.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     _chiefComplaints.dispose();
//     _diagnosis.dispose();
//     _investigations.dispose();
//     _surgery.dispose();
//     _referredTo.dispose();
//     _followUpDate.dispose();

//     for (final c in _medicineNameCtrls) {
//       c.dispose();
//     }
//     for (final c in _medicineNoteCtrls) {
//       c.dispose();
//     }
//     super.dispose();
//   }

//   Future<void> _exitFlow() async {
//     try {
//       if (Get.isRegistered<PrescriptionFlowController>()) {
//         Get.delete<PrescriptionFlowController>(force: true);
//       }
//     } catch (_) {}

//     if (mounted) {
//       Get.offAllNamed('/patientInfoScreen');
//     }
//   }

//   void _syncMedicinesControllers() {
//     while (_medicineNameCtrls.length < controller.medicines.length) {
//       final idx = _medicineNameCtrls.length;
//       _medicineNameCtrls.add(
//         TextEditingController(text: controller.medicines[idx]['name'] ?? ''),
//       );
//       _medicineNoteCtrls.add(
//         TextEditingController(text: controller.medicines[idx]['note'] ?? ''),
//       );
//     }

//     while (_medicineNameCtrls.length > controller.medicines.length) {
//       _medicineNameCtrls.removeLast().dispose();
//       _medicineNoteCtrls.removeLast().dispose();
//     }
//   }

//   void _next() {
//     final idx = controller.step.value;

//     if (idx == 1) {
//       if (_chiefComplaints.text.trim().isEmpty ||
//           _diagnosis.text.trim().isEmpty ||
//           _investigations.text.trim().isEmpty ||
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
//       controller.investigationList
//         ..clear()
//         ..add(_investigations.text.trim());
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
//       _syncMedicinesControllers();

//       if (controller.medicines.isEmpty) {
//         Get.snackbar('Error', 'Add at least one medicine');
//         return;
//       }

//       for (var i = 0; i < controller.medicines.length; i++) {
//         final name = _medicineNameCtrls[i].text.trim();
//         final note = _medicineNoteCtrls[i].text.trim();

//         if (name.isEmpty || note.isEmpty) {
//           Get.snackbar('Error', 'Medicine fields missing');
//           return;
//         }

//         controller.medicines[i] = {'name': name, 'note': note};
//       }

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

//   Future<void> _pickDate() async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime(3000),
//     );
//     if (picked == null) return;
//     _followUpDate.text = DateFormat('yyyy-MM-dd').format(picked);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         await _exitFlow();
//         return false;
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           backgroundColor: _green,
//           title: const Text('Prescription'),
//           leading: IconButton(
//             icon: const Icon(Icons.close),
//             onPressed: _exitFlow,
//           ),
//         ),
//         body: Obx(() {
//           _syncMedicinesControllers();

//           return Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(14),
//                 child: Text(
//                   'Step ${controller.step.value} of 3',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: _green,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: PageView(
//                   controller: _pageController,
//                   physics: const NeverScrollableScrollPhysics(),
//                   children: [
//                     _stepOneUI(),
//                     _stepTwoUI(),
//                     _stepThreeUI(),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(14),
//                 child: Row(
//                   children: [
//                     if (controller.step.value > 1)
//                       Expanded(
//                         child: OutlinedButton(
//                           style: OutlinedButton.styleFrom(
//                             side: BorderSide(color: _green),
//                             padding: const EdgeInsets.symmetric(vertical: 14),
//                           ),
//                           onPressed: _back,
//                           child: Text(
//                             'Back',
//                             style: TextStyle(color: _green),
//                           ),
//                         ),
//                       ),
//                     if (controller.step.value > 1)
//                       const SizedBox(width: 12),
//                     Expanded(
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: _green,
//                           padding: const EdgeInsets.symmetric(vertical: 14),
//                         ),
//                         onPressed: _next,
//                         child: Text(
//                           controller.step.value == 3 ? 'Review' : 'Next',
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         }),
//       ),
//     );
//   }

//   // ---------------- UI HELPERS ----------------

//   Widget _stepOneUI() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           _field('Chief Complaints', _chiefComplaints),
//           _field('Diagnosis', _diagnosis),
//           _field('Investigations', _investigations),
//           _field('Surgery', _surgery),
//         ],
//       ),
//     );
//   }

//   Widget _stepTwoUI() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           ListView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: controller.medicines.length,
//             itemBuilder: (_, i) {
//               return Card(
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   side: BorderSide(color: _green.withOpacity(0.3)),
//                 ),
//                 margin: const EdgeInsets.only(bottom: 14),
//                 child: Padding(
//                   padding: const EdgeInsets.all(14),
//                   child: Column(
//                     children: [
//                       _field('Medicine Name', _medicineNameCtrls[i]),
//                       _field('Instruction', _medicineNoteCtrls[i]),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: IconButton(
//                           icon: Icon(Icons.delete, color: Colors.red.shade400),
//                           onPressed: () {
//                             controller.removeMedicine(i);
//                           },
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//           OutlinedButton.icon(
//             style: OutlinedButton.styleFrom(
//               side: BorderSide(color: _green),
//             ),
//             onPressed: controller.addEmptyMedicine,
//             icon: Icon(Icons.add, color: _green),
//             label: Text(
//               'Add Medicine',
//               style: TextStyle(color: _green),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _stepThreeUI() {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           _field('Referred To', _referredTo),
//           const SizedBox(height: 12),
//           TextField(
//             controller: _followUpDate,
//             readOnly: true,
//             onTap: _pickDate,
//             decoration: _inputDecoration('Follow-up Date')
//                 .copyWith(suffixIcon: const Icon(Icons.calendar_today)),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _field(String label, TextEditingController c) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 14),
//       child: TextField(
//         controller: c,
//         minLines: 1,
//         maxLines: 3,
//         decoration: _inputDecoration(label),
//       ),
//     );
//   }

//   InputDecoration _inputDecoration(String label) {
//     return InputDecoration(
//       labelText: label,
//       filled: true,
//       fillColor: Colors.white,
//       contentPadding:
//           const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: _green),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: _green, width: 2),
//       ),
//     );
//   }
// }

// //////



// import 'package:beh_doctor/modules/auth/controller/PrescriptionFlowController.dart';
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
//   final TextEditingController _investigations = TextEditingController();
//   final TextEditingController _surgery = TextEditingController();
//   final TextEditingController _referredTo = TextEditingController();
//   final TextEditingController _followUpDate = TextEditingController();

//   final List<TextEditingController> _medicineNoteCtrls = [];

//   final Color _green = const Color(0xFF2E7D32);

//   @override
//   void initState() {
//     super.initState();
//     controller = Get.put(PrescriptionFlowController(), permanent: true);
//     controller.fetchMedicineNames();
//     _followUpDate.text =
//         DateFormat('yyyy-MM-dd').format(DateTime.now());
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     _chiefComplaints.dispose();
//     _diagnosis.dispose();
//     _investigations.dispose();
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
//           _investigations.text.trim().isEmpty ||
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
//       controller.investigationList
//         ..clear()
//         ..add(_investigations.text.trim());
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
//       if (controller.medicines.isEmpty) {
//         Get.snackbar('Error', 'Add at least one medicine');
//         return;
//       }

//       for (var i = 0; i < controller.medicines.length; i++) {
//         final note = _medicineNoteCtrls[i].text.trim();
//         if (note.isEmpty) {
//           Get.snackbar('Error', 'Medicine instruction required');
//           return;
//         }
//         controller.updateMedicineNote(i, note);
//       }

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
//           backgroundColor: _green,
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
//                 physics:
//                     const NeverScrollableScrollPhysics(),
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
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: _next,
//                       child: Text(controller.step.value == 3
//                           ? 'Review'
//                           : 'Next'),
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
//           // _field('Investigations', _investigations),
          
//           _field('Surgery', _surgery),
//           Widget _stepOneUI() {
//   return SingleChildScrollView(
//     padding: const EdgeInsets.all(16),
//     child: Column(
//       children: [
//         _field('Chief Complaints', _chiefComplaints),
//         _field('Diagnosis', _diagnosis),

//         /// 🔽 INVESTIGATION DROPDOWN (API)
//         Obx(() {
//           if (controller.isInvestigationLoading.value) {
//             return const Padding(
//               padding: EdgeInsets.only(bottom: 14),
//               child: CircularProgressIndicator(),
//             );
//           }

//           return Padding(
//             padding: const EdgeInsets.only(bottom: 14),
//             child: DropdownButtonFormField<String>(
//               decoration: _inputDecoration('Investigations'),

//               value: controller.investigationList.isEmpty
//                   ? null
//                   : controller.investigationList.first,

//               items: controller.investigationOptions
//                   .map(
//                     (inv) => DropdownMenuItem<String>(
//                       value: inv.name,
//                       child: Text(inv.name),
//                     ),
//                   )
//                   .toList(),

//               onChanged: (v) {
//                 if (v == null) return;

//                 final selected = controller.investigationOptions.firstWhere(
//                   (e) => e.name == v,
//                 );

//                 controller.investigationList.clear();
//                 controller.addInvestigationFromDropdown(selected);
//               },
//             ),
//           );
//         }),

//         _field('Surgery', _surgery),
//       ],
//     ),
//   );
// }

//         ],
//       ),
//     );
//   }

//   // ---------------- STEP 2 (UPDATED ONLY) ----------------
// Widget _stepTwoUI() {
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

// addinvestigation
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

  final Color _green = const Color(0xFF2E7D32);

  @override
  void initState() {
    super.initState();
    controller = Get.put(PrescriptionFlowController(), permanent: true);
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
    while (_medicineNoteCtrls.length <
        controller.medicines.length) {
      _medicineNoteCtrls.add(TextEditingController());
    }

    while (_medicineNoteCtrls.length >
        controller.medicines.length) {
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
        appBar: AppBar(
          backgroundColor: _green,
          title: const Text('Prescription'),
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
                        onPressed: _back,
                        child: const Text('Back'),
                      ),
                    ),
                  if (controller.step.value > 1)
                    const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
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
              padding: const EdgeInsets.only(bottom: 14),
              child: DropdownButtonFormField<String>(
                decoration: _inputDecoration('Investigations'),
                value: controller.investigationList.isEmpty
                    ? null
                    : controller.investigationList.first,
                items: controller.investigationOptions
                    .map(
                      (inv) => DropdownMenuItem<String>(
                        value: inv.name,
                        child: Text(inv.name),
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
                  margin: const EdgeInsets.only(bottom: 14),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      children: [
                        /// 🔽 MEDICINE DROPDOWN
                        DropdownButtonFormField<String>(
                          value: controller.medicines[i]['name']!.isEmpty
                              ? null
                              : controller.medicines[i]['name'],
                          decoration: _inputDecoration('Medicine'),

                          items: controller.medicineOptions
                              .map(
                                (m) => DropdownMenuItem<String>(
                                  value: m.name,
                                  child: Text(m.name), // ✅ FIXED
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

          /// ➕ ADD MEDICINE
          OutlinedButton.icon(
            onPressed: controller.addEmptyMedicine,
            icon: const Icon(Icons.add),
            label: const Text('Add Medicine'),
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
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: c,
        decoration: _inputDecoration(label),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
