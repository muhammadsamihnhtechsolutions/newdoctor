
// import 'package:beh_doctor/modules/auth/controller/ExperinceSetupController.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';


// class ExperienceSetupScreen extends StatelessWidget {
//   ExperienceSetupScreen({super.key});

//   final controller = Get.put(ExperienceSetupController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Experience Setup"),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: controller.addExperience,
//         child: const Icon(Icons.add),
//       ),
//       body: Obx(
//         () => controller.experienceList.isEmpty
//             ? const Center(
//                 child: Text("No experience added"),
//               )
//             : ListView.builder(
//                 padding: const EdgeInsets.all(16),
//                 itemCount: controller.experienceList.length,
//                 itemBuilder: (_, index) {
//                   final exp = controller.experienceList[index];

//                   return Card(
//                     margin: const EdgeInsets.only(bottom: 16),
//                     elevation: 2,
//                     child: Padding(
//                       padding: const EdgeInsets.all(12),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           /// Hospital
//                           TextField(
//                             controller: exp.hospitalName,
//                             decoration: const InputDecoration(
//                               labelText: "Hospital Name",
//                             ),
//                           ),

//                           const SizedBox(height: 10),

//                           /// Designation
//                           TextField(
//                             controller: exp.designationController,
//                             decoration: const InputDecoration(
//                               labelText: "Designation",
//                             ),
//                           ),

//                           const SizedBox(height: 10),

//                           /// Department
//                           TextField(
//                             controller: exp.departmentController,
//                             decoration: const InputDecoration(
//                               labelText: "Department",
//                             ),
//                           ),

//                           const SizedBox(height: 10),

//                           /// Start Date
//                           TextField(
//                             controller: exp.startDateController,
//                             readOnly: true,
//                             onTap: () => _pickDate(
//                               context,
//                               exp.startDateController,
//                             ),
//                             decoration: const InputDecoration(
//                               labelText: "Start Date",
//                               suffixIcon: Icon(Icons.date_range),
//                             ),
//                           ),

//                           const SizedBox(height: 10),

//                           /// Still Working Toggle
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               const Text("I still work here"),
//                               Switch(
//                                 value: exp.iStillWorkHere,
//                                 onChanged: (v) =>
//                                     controller.toggleStillWorking(index, v),
//                               ),
//                             ],
//                           ),

//                           /// End Date (only if not working)
//                           if (!exp.iStillWorkHere) ...[
//                             const SizedBox(height: 10),
//                             TextField(
//                               controller: exp.endDateController,
//                               readOnly: true,
//                               onTap: () => _pickDate(
//                                 context,
//                                 exp.endDateController,
//                               ),
//                               decoration: const InputDecoration(
//                                 labelText: "End Date",
//                                 suffixIcon: Icon(Icons.date_range),
//                               ),
//                             ),
//                           ],

//                           const SizedBox(height: 12),

//                           /// Remove Button
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: TextButton.icon(
//                               onPressed: () =>
//                                   controller.removeExperience(index),
//                               icon: const Icon(
//                                 Icons.delete,
//                                 color: Colors.red,
//                               ),
//                               label: const Text(
//                                 "Remove",
//                                 style: TextStyle(color: Colors.red),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(16),
//         child: ElevatedButton(
//           onPressed: controller.submitExperience,
//           child: const Text("Submit Experience"),
//         ),
//       ),
//     );
//   }

//   /// ================= DATE PICKER =================
//   Future<void> _pickDate(
//     BuildContext context,
//     TextEditingController controller,
//   ) async {
//     final date = await showDatePicker(
//       context: context,
//       firstDate: DateTime(1980),
//       lastDate: DateTime.now(),
//       initialDate: DateTime.now(),
//     );

//     if (date != null) {
//       controller.text =
//           "${date.year}-${date.month}-${date.day}";
//     }
//   }
// }

import 'package:beh_doctor/modules/auth/controller/ExperinceSetupController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExperienceSetupScreen extends StatelessWidget {
  ExperienceSetupScreen({super.key});

  final controller = Get.put(ExperienceSetupController());

  static const Color _green = Color(0xFF008541);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      floatingActionButton: FloatingActionButton(
        backgroundColor: _green,
        onPressed: controller.addExperience,
        child: const Icon(Icons.add, color: Colors.white),
      ),

      /// ✅ KEYBOARD DISMISS FIX (CORRECT PLACE)
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Obx(
          () => controller.experienceList.isEmpty
              ? const Center(child: Text("No experience added"))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.experienceList.length,
                  itemBuilder: (_, index) {
                    final exp = controller.experienceList[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 16),
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _field("Hospital Name", exp.hospitalName),
                            _field("Designation", exp.designationController),
                            _field("Department", exp.departmentController),

                            _dateField(
                              context,
                              label: "Start Date",
                              controller: exp.startDateController,
                            ),

                            const SizedBox(height: 8),

                            /// Still Working
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: _green),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "I still work here",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  Switch(
                                    activeColor: _green,
                                    value: exp.iStillWorkHere,
                                    onChanged: (v) => controller
                                        .toggleStillWorking(index, v),
                                  ),
                                ],
                              ),
                            ),

                            if (!exp.iStillWorkHere) ...[
                              const SizedBox(height: 12),
                              _dateField(
                                context,
                                label: "End Date",
                                controller: exp.endDateController,
                              ),
                            ],

                            const SizedBox(height: 12),

                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton.icon(
                                onPressed: () =>
                                    controller.removeExperience(index),
                                icon: const Icon(Icons.delete,
                                    color: Colors.red),
                                label: const Text(
                                  "Remove",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: controller.submitExperience,
            style: ElevatedButton.styleFrom(
              backgroundColor: _green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              "Submit Experience",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ================= UI HELPERS =================

  Widget _field(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        cursorColor: _green,
        controller: controller,
        decoration: _inputDecoration(label),
      ),
    );
  }

  Widget _dateField(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        readOnly: true,
        onTap: () => _pickDate(context, controller),
        decoration: _inputDecoration(label).copyWith(
          suffixIcon: const Icon(Icons.date_range),
        ),
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

  /// ================= DATE PICKER =================
  Future<void> _pickDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime(1980),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: _green,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      controller.text = "${date.year}-${date.month}-${date.day}";
    }
  }
}
