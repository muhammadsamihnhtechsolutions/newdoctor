import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:beh_doctor/modules/auth/controller/AppoinmentDetailController.dart';

class AppTestWidget extends StatelessWidget {
  const AppTestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppointmentDetailsController>();

    return Obx(() {
      final app = controller.appTestData.value;

      if (app == null || app.data == null) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Text(
              "no_app_test_result".tr,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        );
      }

      final data = app.data!;

      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Visual Acuity card
            if (data.visualAcuity != null)
              _appTestCard(
                title: "visual_acuity".tr,
                leftItems: [
                  // "OD   ${data.visualAcuity?.left?.od ?? '--'}",
                  "OS   ${data.visualAcuity?.left?.os ?? '--'}",
                ],
                rightItems: [
                  "OD   ${data.visualAcuity?.right?.od ?? '--'}",
                  // "OS   ${data.visualAcuity?.right?.os ?? '--'}",
                ],
              ),

            // spacing
            const SizedBox(height: 14),

            // Near Vision card
            if (data.nearVision != null)
              _appTestCard(
                title: "near_vision".tr,
                leftItems: [
                  // "OD   ${data.nearVision?.left?.od ?? '--'}",
                  "OS   ${data.nearVision?.left?.os ?? '--'}",
                ],
                rightItems: [
                  "OD   ${data.nearVision?.right?.od ?? '--'}",
                  // "OS   ${data.nearVision?.right?.os ?? '--'}",
                ],
              ),

            const SizedBox(height: 14),

            // Color Vision card
            if (data.colorVision != null)
              _appTestCard(
                title: "color_vision".tr,
                leftItems: ["${data.colorVision?.left ?? '--'}"],
                rightItems: ["${data.colorVision?.right ?? '--'}"],
              ),

            const SizedBox(height: 14),

            // AMD card
            if (data.amdVision != null)
              _appTestCard(
                title: "amd".tr,
                leftItems: ["${data.amdVision?.left ?? '--'}"],
                rightItems: ["${data.amdVision?.right ?? '--'}"],
              ),

            const SizedBox(height: 24),
          ],
        ),
      );
    });
  }

  Widget _appTestCard({
    required String title,
    required List<String> leftItems,
    required List<String> rightItems,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // title row
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // optional small chevron like screenshot (keeps same look)
              const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
            ],
          ),

          const SizedBox(height: 12),

          // left / right columns
          Row(
            children: [
              // left column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "left_eye".tr,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 8),
                    for (var item in leftItems)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // divider like screenshot
              Container(width: 1, height: 48, color: Colors.grey.shade200),

              // right column
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "right_eye".tr,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 8),
                      for (var item in rightItems)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
