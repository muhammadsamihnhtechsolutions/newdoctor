// import 'package:beh_doctor/models/AppointmentModel.dart';
// import 'package:flutter/material.dart';

// class PrescriptionFlowScreen extends StatefulWidget {
//   const PrescriptionFlowScreen({super.key, required Appointment appointment, required int callDuration});

//   @override
//   State<PrescriptionFlowScreen> createState() => _PrescriptionFlowScreenState();
// }

// class _PrescriptionFlowScreenState extends State<PrescriptionFlowScreen> {
//   int step = 1;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Prescription Flow (Test)'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Step Indicator
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _stepChip(1, 'Medicine'),
//                 _stepChip(2, 'Details'),
//                 _stepChip(3, 'Overview'),
//               ],
//             ),

//             const SizedBox(height: 24),

//             // Content
//             Expanded(child: _buildStepContent()),

//             const SizedBox(height: 16),

//             // Actions
//             Row(
//               children: [
//                 if (step > 1)
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () => setState(() => step--),
//                       child: const Text('Back'),
//                     ),
//                   ),
//                 if (step > 1) const SizedBox(width: 12),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (step < 3) {
//                         setState(() => step++);
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text('Prescription Submitted (Test)')),
//                         );
//                       }
//                     },
//                     child: Text(step < 3 ? 'Next' : 'Submit'),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildStepContent() {
//     switch (step) {
//       case 1:
//         return _card(
//           title: 'Add Medicine',
//           child: Column(
//             children: const [
//               TextField(decoration: InputDecoration(labelText: 'Medicine Name')),
//               SizedBox(height: 12),
//               TextField(decoration: InputDecoration(labelText: 'Dosage')),
//             ],
//           ),
//         );
//       case 2:
//         return _card(
//           title: 'Prescription Details',
//           child: Column(
//             children: const [
//               TextField(decoration: InputDecoration(labelText: 'Days')),
//               SizedBox(height: 12),
//               TextField(decoration: InputDecoration(labelText: 'Instructions')),
//             ],
//           ),
//         );
//       default:
//         return _card(
//           title: 'Overview',
//           child: const Text(
//             'Medicine: Paracetamol\nDosage: 2x a day\nDays: 5\n\nDoctor can edit before submit.',
//           ),
//         );
//     }
//   }

//   Widget _stepChip(int s, String label) {
//     final isActive = step == s;
//     return Chip(
//       label: Text(label),
//       backgroundColor: isActive ? Colors.green : Colors.grey.shade300,
//       labelStyle: TextStyle(color: isActive ? Colors.white : Colors.black),
//     );
//   }

//   Widget _card({required String title, required Widget child}) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
//         ],
//       ),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         const SizedBox(height: 12),
//         child,
//       ]),
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

  final TextEditingController _newMedicineName = TextEditingController();

  final List<TextEditingController> _medicineNameCtrls = [];
  final List<TextEditingController> _medicineNoteCtrls = [];

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
    _newMedicineName.dispose();
    for (final c in _medicineNameCtrls) {
      c.dispose();
    }
    for (final c in _medicineNoteCtrls) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _exitFlow() async {
    Get.delete<PrescriptionFlowController>(force: true);
    Get.offAllNamed('/appointments');
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
    if (idx == 0) return;

    if (idx == 1) {
      if (_chiefComplaints.text.trim().isEmpty) {
        Get.snackbar('error'.tr, 'please_enter_chief_complaints'.tr);
        return;
      }
      if (_diagnosis.text.trim().isEmpty) {
        Get.snackbar('error'.tr, 'please_enter_diagnosis'.tr);
        return;
      }
      if (_investigations.text.trim().isEmpty) {
        Get.snackbar('error'.tr, 'please_enter_investigations'.tr);
        return;
      }
      if (_surgery.text.trim().isEmpty) {
        Get.snackbar('error'.tr, 'please_enter_surgery_details'.tr);
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
        Get.snackbar('medicine_required'.tr, 'please_add_one_medicine'.tr);
        return;
      }

      for (var i = 0; i < controller.medicines.length; i++) {
        final name = _medicineNameCtrls[i].text.trim();
        final note = _medicineNoteCtrls[i].text.trim();
        if (name.isEmpty) {
          Get.snackbar(
            'error'.tr,
            '${"please_enter_medicine_name".tr} ${i + 1}',
          );
          return;
        }
        if (note.isEmpty) {
          Get.snackbar(
            'error'.tr,
            '${"please_enter_medicine_notes".tr} ${i + 1}',
          );
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
        Get.snackbar('error'.tr, 'please_enter_referred_to'.tr);
        return;
      }

      controller.referredTo.value = _referredTo.text.trim();
      controller.followUpDate.value = _followUpDate.text.trim();

      Get.to(
        () => PrescriptionOverviewScreen(
          payload: controller.buildPayload(widget.appointmentId),
          callDuration: widget.callDuration,
        ),
      );
    }
  }

  void _back() {
    if (controller.step.value <= 1) return;
    controller.step.value = controller.step.value - 1;
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

  Widget _stepDot({required bool done}) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1, color: const Color(0xFF008541)),
        color: done ? const Color(0xFF008541) : Colors.transparent,
      ),
      child: done
          ? const Icon(Icons.check, size: 12, color: Colors.white)
          : const SizedBox(),
    );
  }

  Widget _arrowButton({
    required int quarterTurns,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: const Color(0xFF008541),
        ),
        child: RotatedBox(
          quarterTurns: quarterTurns,
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
    );
  }

  Widget _label(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }

  static const Color _primaryColor = Color(0xFF008541);
  static const Color _appBackground = Color(0xFFF4F4F4);
  static const Color _borderColor = Color(0xFFBBBBBB);

  Widget _multilineField(TextEditingController ctrl) {
    return TextField(
      controller: ctrl,
      maxLines: 6,
      style: const TextStyle(
        fontFamily: 'Inter',
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: _appBackground,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _primaryColor, width: 2),
        ),
      ),
    );
  }

  Widget _textField(
    TextEditingController ctrl, {
    int maxLines = 1,
    bool enabled = true,
    Widget? suffixIcon,
    String? hint,
  }) {
    return TextField(
      controller: ctrl,
      maxLines: maxLines,
      enabled: enabled,
      style: const TextStyle(
        fontFamily: 'Inter',
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: _appBackground,
        suffixIcon: suffixIcon,
        hintText: hint ?? '',
        hintStyle: const TextStyle(
          fontFamily: 'Inter',
          color: Color(0xFF888E9D),
          fontWeight: FontWeight.w500,
          fontSize: 11,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _borderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _primaryColor, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: _borderColor, width: 1),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await _exitFlow();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('prescription'.tr),
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          surfaceTintColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: _exitFlow,
          ),
        ),
        body: Obx(() {
          _syncMedicinesControllers();

          return Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12),
                            _label('chief_complaints'.tr),
                            _multilineField(_chiefComplaints),
                            const SizedBox(height: 16),
                            _label('diagnosis'.tr),
                            _multilineField(_diagnosis),
                            const SizedBox(height: 16),
                            _label('investigations'.tr),
                            _multilineField(_investigations),
                            const SizedBox(height: 16),
                            _label('surgery'.tr),
                            _multilineField(_surgery),
                            const SizedBox(height: kToolbarHeight * 2),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(height: 12),
                            ListView.builder(
                              itemCount: controller.medicines.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: const Color(0xFFEFEFEF),
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 12,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Medicine ${index + 1}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'medicine_name'.tr,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(height: 6),
                                        _textField(_medicineNameCtrls[index]),
                                        const SizedBox(height: 12),
                                        Text(
                                          'notes'.tr,
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                        const SizedBox(height: 6),
                                        _textField(
                                          _medicineNoteCtrls[index],
                                          maxLines: 4,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            TextButton(
                              onPressed: () {
                                controller.addEmptyMedicine();
                              },
                              child: Text(
                                'add_more'.tr,
                                style: const TextStyle(
                                  color: Color(0xFF008541),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12),
                            _label('referred_to'.tr),
                            _textField(_referredTo),
                            const SizedBox(height: 12),
                            _label('follow_up_date'.tr),
                            GestureDetector(
                              onTap: _pickDate,
                              child: AbsorbPointer(
                                child: _textField(
                                  _followUpDate,
                                  enabled: false,
                                  suffixIcon: const Icon(
                                    Icons.calendar_month,
                                    size: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: kToolbarHeight * 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    controller.step.value == 1
                        ? const SizedBox(width: 60)
                        : _arrowButton(quarterTurns: 0, onTap: _back),
                    Row(
                      children: [
                        _stepDot(done: controller.step.value > 1),
                        Container(
                          height: 1,
                          width: 8,
                          color: const Color(0xFF008541),
                        ),
                        _stepDot(done: controller.step.value > 2),
                        Container(
                          height: 1,
                          width: 8,
                          color: const Color(0xFF008541),
                        ),
                        _stepDot(done: controller.step.value > 3),
                      ],
                    ),
                    _arrowButton(quarterTurns: 2, onTap: _next),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
