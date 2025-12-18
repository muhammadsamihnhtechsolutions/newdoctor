

import 'package:beh_doctor/modules/auth/controller/AddMfsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddMfsScreen extends StatelessWidget {
  AddMfsScreen({Key? key}) : super(key: key);

  final controller = Get.put(AddMfsController());

  // Custom Green
  final Color appGreen = const Color(0xFF008541);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text(
          "Add New MFS Account",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),

      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ---------------- MFS Name ----------------
                    buildLabel("MFS Name"),
                    buildDropdown(
                      hint: "Select MFS",
                      value: controller.selectedMfs.value,
                      items: controller.mfsList
                          .map((m) => DropdownMenuItem(
                                value: m,
                                child: Text(m.title ?? ""),
                              ))
                          .toList(),
                      onChanged: (val) => controller.selectedMfs.value = val,
                    ),
                    const SizedBox(height: 18),

                    // ---------------- Account Name ----------------
                    buildLabel("Account Holder Name"),
                    buildInputField(
                      controller.accountNameController,
                      "Enter Account Holder Name",
                    ),
                    const SizedBox(height: 18),

                    // ---------------- Account Number ----------------
                    buildLabel("Account Number"),
                    buildInputField(
                      controller.accountNumberController,
                      "Enter Number",
                      keyboard: TextInputType.number,
                    ),
                    const SizedBox(height: 28),

                    // ---------------- Submit Button ----------------
                    GestureDetector(
                      onTap: controller.submit,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: appGreen,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "SUBMIT",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
      ),
    );
  }

  // -------------------- UI Helpers --------------------

  Widget buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        color: appGreen,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget buildInputField(
    TextEditingController controller,
    String hint, {
    TextInputType keyboard = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboard,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        hintText: hint,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: appGreen),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appGreen, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget buildDropdown({
    required String hint,
    required dynamic value,
    required List<DropdownMenuItem> items,
    required Function(dynamic) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        border: Border.all(color: appGreen),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton(
        isExpanded: true,
        underline: const SizedBox(),
        value: value,
        hint: Text(hint),
        items: items,
        onChanged: onChanged,
        dropdownColor: Colors.white,
      ),
    );
  }
}
