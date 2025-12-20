

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
// Future<void> _exitFlow() async {
//   try {
//     if (Get.isRegistered<PrescriptionFlowController>()) {
//       Get.delete<PrescriptionFlowController>(force: true);
//     }
//   } catch (e) {
//     debugPrint("Controller delete error: $e");
//   }

//   try {
//     if (mounted) {
//       Get.offAllNamed('/appointments');
//     }
//   } catch (e) {
//     debugPrint("Navigation error: $e");
//   }
// }


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
//         appBar: AppBar(
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
//                 padding: const EdgeInsets.all(12),
//                 child: Text(
//                   'Step ${controller.step.value} of 3',
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
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
//                 padding: const EdgeInsets.all(12),
//                 child: Row(
//                   children: [
//                     if (controller.step.value > 1)
//                       Expanded(
//                         child: OutlinedButton(
//                           onPressed: _back,
//                           child: const Text('Back'),
//                         ),
//                       ),
//                     if (controller.step.value > 1)
//                       const SizedBox(width: 12),
//                     Expanded(
//                       child: ElevatedButton(
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
//                 margin: const EdgeInsets.only(bottom: 12),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: Column(
//                     children: [
//                       TextField(
//                         controller: _medicineNameCtrls[i],
//                         decoration: const InputDecoration(
//                           labelText: 'Medicine Name',
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       TextField(
//                         controller: _medicineNoteCtrls[i],
//                         decoration: const InputDecoration(
//                           labelText: 'Instruction',
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: IconButton(
//                           icon: const Icon(Icons.delete),
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
//             onPressed: controller.addEmptyMedicine,
//             icon: const Icon(Icons.add),
//             label: const Text('Add Medicine'),
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
//             decoration: const InputDecoration(
//               labelText: 'Follow-up Date',
//               suffixIcon: Icon(Icons.calendar_today),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _field(String label, TextEditingController c) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 12),
//       child: TextField(
//         controller: c,
//         decoration: InputDecoration(
//           labelText: label,
//           border: const OutlineInputBorder(),
//         ),
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
  State<PrescriptionFlowScreen> createState() => _PrescriptionFlowScreenState();
}

class _PrescriptionFlowScreenState extends State<PrescriptionFlowScreen> {
  late final PrescriptionFlowController controller;
  final PageController _pageController = PageController();

  final TextEditingController _chiefComplaints = TextEditingController();
  final TextEditingController _diagnosis = TextEditingController();
  final TextEditingController _investigations = TextEditingController();
  final TextEditingController _surgery = TextEditingController();
  final TextEditingController _referredTo = TextEditingController();
  final TextEditingController _followUpDate = TextEditingController();

  final List<TextEditingController> _medicineNameCtrls = [];
  final List<TextEditingController> _medicineNoteCtrls = [];

  final Color _green = const Color(0xFF2E7D32);

  @override
  void initState() {
    super.initState();
    controller = Get.put(PrescriptionFlowController(), permanent: true);
    _followUpDate.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  @override
  void dispose() {
    _pageController.dispose();
    _chiefComplaints.dispose();
    _diagnosis.dispose();
    _investigations.dispose();
    _surgery.dispose();
    _referredTo.dispose();
    _followUpDate.dispose();

    for (final c in _medicineNameCtrls) {
      c.dispose();
    }
    for (final c in _medicineNoteCtrls) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _exitFlow() async {
    try {
      if (Get.isRegistered<PrescriptionFlowController>()) {
        Get.delete<PrescriptionFlowController>(force: true);
      }
    } catch (_) {}

    if (mounted) {
      Get.offAllNamed('/appointments');
    }
  }

  void _syncMedicinesControllers() {
    while (_medicineNameCtrls.length < controller.medicines.length) {
      final idx = _medicineNameCtrls.length;
      _medicineNameCtrls.add(
        TextEditingController(text: controller.medicines[idx]['name'] ?? ''),
      );
      _medicineNoteCtrls.add(
        TextEditingController(text: controller.medicines[idx]['note'] ?? ''),
      );
    }

    while (_medicineNameCtrls.length > controller.medicines.length) {
      _medicineNameCtrls.removeLast().dispose();
      _medicineNoteCtrls.removeLast().dispose();
    }
  }

  void _next() {
    final idx = controller.step.value;

    if (idx == 1) {
      if (_chiefComplaints.text.trim().isEmpty ||
          _diagnosis.text.trim().isEmpty ||
          _investigations.text.trim().isEmpty ||
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
      controller.investigationList
        ..clear()
        ..add(_investigations.text.trim());
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
      _syncMedicinesControllers();

      if (controller.medicines.isEmpty) {
        Get.snackbar('Error', 'Add at least one medicine');
        return;
      }

      for (var i = 0; i < controller.medicines.length; i++) {
        final name = _medicineNameCtrls[i].text.trim();
        final note = _medicineNoteCtrls[i].text.trim();

        if (name.isEmpty || note.isEmpty) {
          Get.snackbar('Error', 'Medicine fields missing');
          return;
        }

        controller.medicines[i] = {'name': name, 'note': note};
      }

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

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(3000),
    );
    if (picked == null) return;
    _followUpDate.text = DateFormat('yyyy-MM-dd').format(picked);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _exitFlow();
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: _green,
          title: const Text('Prescription'),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: _exitFlow,
          ),
        ),
        body: Obx(() {
          _syncMedicinesControllers();

          return Column(
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
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: _back,
                          child: Text(
                            'Back',
                            style: TextStyle(color: _green),
                          ),
                        ),
                      ),
                    if (controller.step.value > 1)
                      const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _green,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: _next,
                        child: Text(
                          controller.step.value == 3 ? 'Review' : 'Next',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  // ---------------- UI HELPERS ----------------

  Widget _stepOneUI() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _field('Chief Complaints', _chiefComplaints),
          _field('Diagnosis', _diagnosis),
          _field('Investigations', _investigations),
          _field('Surgery', _surgery),
        ],
      ),
    );
  }

  Widget _stepTwoUI() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.medicines.length,
            itemBuilder: (_, i) {
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: _green.withOpacity(0.3)),
                ),
                margin: const EdgeInsets.only(bottom: 14),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    children: [
                      _field('Medicine Name', _medicineNameCtrls[i]),
                      _field('Instruction', _medicineNoteCtrls[i]),
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red.shade400),
                          onPressed: () {
                            controller.removeMedicine(i);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: _green),
            ),
            onPressed: controller.addEmptyMedicine,
            icon: Icon(Icons.add, color: _green),
            label: Text(
              'Add Medicine',
              style: TextStyle(color: _green),
            ),
          ),
        ],
      ),
    );
  }

  Widget _stepThreeUI() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _field('Referred To', _referredTo),
          const SizedBox(height: 12),
          TextField(
            controller: _followUpDate,
            readOnly: true,
            onTap: _pickDate,
            decoration: _inputDecoration('Follow-up Date')
                .copyWith(suffixIcon: const Icon(Icons.calendar_today)),
          ),
        ],
      ),
    );
  }

  Widget _field(String label, TextEditingController c) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: c,
        minLines: 1,
        maxLines: 3,
        decoration: _inputDecoration(label),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
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
