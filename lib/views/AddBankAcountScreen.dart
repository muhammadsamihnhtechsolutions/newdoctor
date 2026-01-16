

import 'package:beh_doctor/models/BankListResponse.dart';
import 'package:beh_doctor/models/DistrictResponseModel.dart';
import 'package:beh_doctor/modules/auth/controller/AddBankAccountController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBankScreen extends StatelessWidget {
  AddBankScreen({Key? key}) : super(key: key);

  final controller = Get.put(AddBankController());

  // Custom Green Color
  final Color appGreen = const Color(0xFF008541);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text(
          "Add New Bank Account",
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
        () => controller.bankList.isEmpty || controller.districtList.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ---------------- BANK ----------------
                    buildLabel("Bank Name", appGreen),
                    buildDropdown<BankModel>(
                      hint: "Select Bank",
                      value: controller.selectedBank.value,
                      items: controller.bankList.map(
                        (b) => DropdownMenuItem(
                          value: b,
                          child: Text(b.title ?? ""),
                        ),
                      ).toList(),
                      onChanged: (val) => controller.selectedBank.value = val,
                      appGreen: appGreen,

                      // ✅ FIX: selected item me ID ki jagah NAME
                      selectedItemBuilder: (context) {
                        return controller.bankList.map(
                          (b) => Text(
                            b.title ?? "",
                            style: const TextStyle(color: Colors.black),
                          ),
                        ).toList();
                      },
                    ),
                    const SizedBox(height: 18),

                    // ---------------- BRANCH ----------------
                    buildLabel("Branch Name", appGreen),
                    buildInputField(
                      controller.branchController,
                      "Enter Branch Name",
                      appGreen,
                    ),
                    const SizedBox(height: 18),

                    // ---------------- DISTRICT ----------------
                    buildLabel("District", appGreen),
                    buildDropdown<District>(
                      hint: "Select District",
                      value: controller.selectedDistrict.value,
                      items: controller.districtList.map(
                        (d) => DropdownMenuItem(
                          value: d,
                          child: Text(d.name ?? ""),
                        ),
                      ).toList(),
                      onChanged: (val) => controller.selectedDistrict.value = val,
                      appGreen: appGreen,

                      // ✅ FIX: selected item me ID ki jagah NAME
                      selectedItemBuilder: (context) {
                        return controller.districtList.map(
                          (d) => Text(
                            d.name ?? "",
                            style: const TextStyle(color: Colors.black),
                          ),
                        ).toList();
                      },
                    ),
                    const SizedBox(height: 18),

                    // ---------------- ACCOUNT NAME ----------------
                    buildLabel("Account Name", appGreen),
                    buildInputField(
                      controller.accountNameController,
                      "Enter Account Name",
                      appGreen,
                    ),
                    const SizedBox(height: 18),

                    // ---------------- ACCOUNT NUMBER ----------------
                    buildLabel("Account Number", appGreen),
                    buildInputField(
                      controller.accountNumberController,
                      "Enter Account Number",
                      appGreen,
                      keyboard: TextInputType.number,
                    ),
                    const SizedBox(height: 28),

                    // ---------------- SUBMIT ----------------
                 Obx(() => GestureDetector(
      onTap: controller.isLoading.value
          ? null
          : () {
              controller.submit();
            },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: controller.isLoading.value
              ? appGreen.withOpacity(0.7)
              : appGreen,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: controller.isLoading.value
              ? const SizedBox(
                  height: 22,
                  width: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : const Text(
                  "SUBMIT",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    )),


                    const SizedBox(height: 30),
                  ],
                ),
              ),
      ),
    );
  }

  // ================= UI HELPERS =================

  Widget buildLabel(String text, Color appGreen) {
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
    String hint,
    Color appGreen, {
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

  Widget buildDropdown<T>({
    required String hint,
    required T? value,
    required List<DropdownMenuItem<T>> items,
    required Function(T?) onChanged,
    required Color appGreen,
    List<Widget> Function(BuildContext)? selectedItemBuilder,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        border: Border.all(color: appGreen),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButton<T>(
        isExpanded: true,
        underline: const SizedBox(),
        value: value,
        hint: Text(hint),
        items: items,
        onChanged: onChanged,
        dropdownColor: Colors.white,
        selectedItemBuilder: selectedItemBuilder,
      ),
    );
  }
}
