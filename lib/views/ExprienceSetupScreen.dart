// import 'package:beh_doctor/modules/auth/controller/ExperinceSetupController.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';


// class ExperienceSetupScreen extends StatelessWidget {
//   ExperienceSetupScreen({Key? key}) : super(key: key);

//   final ExperienceSetupController controller =
//       Get.put(ExperienceSetupController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Experience Setup"),
//       ),
//       body: Obx(
//         () => Column(
//           children: [
//             Expanded(
//               child: controller.experienceList.isEmpty
//                   ? const Center(
//                       child: Text("No experience added"),
//                     )
//                   : ListView.builder(
//                       padding: const EdgeInsets.all(16),
//                       itemCount: controller.experienceList.length,
//                       itemBuilder: (context, index) {
//                         final exp = controller.experienceList[index];

//                         return Card(
//                           margin: const EdgeInsets.only(bottom: 16),
//                           elevation: 3,
//                           child: Padding(
//                             padding: const EdgeInsets.all(16),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 /// Hospital Name
//                                 TextField(
//                                   controller: exp.hospitalName,
//                                   decoration: const InputDecoration(
//                                     labelText: "Hospital Name",
//                                   ),
//                                 ),
//                                 const SizedBox(height: 12),

//                                 /// Designation
//                                 TextField(
//                                   controller: exp.designationController,
//                                   decoration: const InputDecoration(
//                                     labelText: "Designation",
//                                   ),
//                                 ),
//                                 const SizedBox(height: 12),

//                                 /// Department
//                                 TextField(
//                                   controller: exp.departmentController,
//                                   decoration: const InputDecoration(
//                                     labelText: "Department",
//                                   ),
//                                 ),
//                                 const SizedBox(height: 12),

//                                 /// Start Date
//                                 TextField(
//                                   controller: exp.startDateController,
//                                   readOnly: true,
//                                   decoration: const InputDecoration(
//                                     labelText: "Start Date",
//                                     suffixIcon: Icon(Icons.calendar_today),
//                                   ),
//                                   onTap: () async {
//                                     final date = await showDatePicker(
//                                       context: context,
//                                       firstDate: DateTime(1990),
//                                       lastDate: DateTime.now(),
//                                       initialDate: DateTime.now(),
//                                     );

//                                     if (date != null) {
//                                       exp.startDateController.text =
//                                           "${date.year}-${date.month}-${date.day}";
//                                     }
//                                   },
//                                 ),
//                                 const SizedBox(height: 12),

//                                 /// Still Working Switch
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: Text(
//                                         "I still work here",
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .bodyMedium,
//                                       ),
//                                     ),
//                                     Switch(
//                                       value: exp.iStillWorkHere,
//                                       onChanged: (v) => controller
//                                           .toggleStillWorking(index, v),
//                                     ),
//                                   ],
//                                 ),

//                                 /// End Date (only if NOT working)
//                                 if (!exp.iStillWorkHere) ...[
//                                   const SizedBox(height: 12),
//                                   TextField(
//                                     controller: exp.endDateController,
//                                     readOnly: true,
//                                     decoration: const InputDecoration(
//                                       labelText: "End Date",
//                                       suffixIcon:
//                                           Icon(Icons.calendar_today),
//                                     ),
//                                     onTap: () async {
//                                       final date = await showDatePicker(
//                                         context: context,
//                                         firstDate: DateTime(1990),
//                                         lastDate: DateTime.now(),
//                                         initialDate: DateTime.now(),
//                                       );

//                                       if (date != null) {
//                                         exp.endDateController.text =
//                                             "${date.year}-${date.month}-${date.day}";
//                                       }
//                                     },
//                                   ),
//                                 ],

//                                 const SizedBox(height: 16),

//                                 /// Remove Button
//                                 Align(
//                                   alignment: Alignment.centerRight,
//                                   child: TextButton.icon(
//                                     onPressed: () =>
//                                         controller.removeExperience(index),
//                                     icon: const Icon(
//                                       Icons.delete,
//                                       color: Colors.red,
//                                     ),
//                                     label: const Text(
//                                       "Remove",
//                                       style:
//                                           TextStyle(color: Colors.red),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//             ),

//             /// Bottom Buttons
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton.icon(
//                       onPressed: controller.addExperience,
//                       icon: const Icon(Icons.add),
//                       label: const Text("Add Experience"),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: controller.submitExperience,
//                       child: const Text("Submit"),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// 
import 'package:beh_doctor/modules/auth/controller/ExperinceSetupController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ExperienceSetupScreen extends StatelessWidget {
  ExperienceSetupScreen({super.key});

  final controller = Get.put(ExperienceSetupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Experience Setup"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.addExperience,
        child: const Icon(Icons.add),
      ),
      body: Obx(
        () => controller.experienceList.isEmpty
            ? const Center(
                child: Text("No experience added"),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.experienceList.length,
                itemBuilder: (_, index) {
                  final exp = controller.experienceList[index];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Hospital
                          TextField(
                            controller: exp.hospitalName,
                            decoration: const InputDecoration(
                              labelText: "Hospital Name",
                            ),
                          ),

                          const SizedBox(height: 10),

                          /// Designation
                          TextField(
                            controller: exp.designationController,
                            decoration: const InputDecoration(
                              labelText: "Designation",
                            ),
                          ),

                          const SizedBox(height: 10),

                          /// Department
                          TextField(
                            controller: exp.departmentController,
                            decoration: const InputDecoration(
                              labelText: "Department",
                            ),
                          ),

                          const SizedBox(height: 10),

                          /// Start Date
                          TextField(
                            controller: exp.startDateController,
                            readOnly: true,
                            onTap: () => _pickDate(
                              context,
                              exp.startDateController,
                            ),
                            decoration: const InputDecoration(
                              labelText: "Start Date",
                              suffixIcon: Icon(Icons.date_range),
                            ),
                          ),

                          const SizedBox(height: 10),

                          /// Still Working Toggle
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("I still work here"),
                              Switch(
                                value: exp.iStillWorkHere,
                                onChanged: (v) =>
                                    controller.toggleStillWorking(index, v),
                              ),
                            ],
                          ),

                          /// End Date (only if not working)
                          if (!exp.iStillWorkHere) ...[
                            const SizedBox(height: 10),
                            TextField(
                              controller: exp.endDateController,
                              readOnly: true,
                              onTap: () => _pickDate(
                                context,
                                exp.endDateController,
                              ),
                              decoration: const InputDecoration(
                                labelText: "End Date",
                                suffixIcon: Icon(Icons.date_range),
                              ),
                            ),
                          ],

                          const SizedBox(height: 12),

                          /// Remove Button
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              onPressed: () =>
                                  controller.removeExperience(index),
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: controller.submitExperience,
          child: const Text("Submit Experience"),
        ),
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
    );

    if (date != null) {
      controller.text =
          "${date.year}-${date.month}-${date.day}";
    }
  }
}
