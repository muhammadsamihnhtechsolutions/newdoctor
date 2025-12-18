import 'package:beh_doctor/modules/auth/controller/AgoraCallController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrescriptionOverviewScreen extends StatelessWidget {
  final Map<String, dynamic> payload;
  final int callDuration;

  PrescriptionOverviewScreen({
    super.key,
    required this.payload,
    required this.callDuration,
  });

  final AgoraCallController controller = Get.find<AgoraCallController>();

  static const Color _primaryColor = Color(0xFF008541);
  static const Color _textDark = Color(0xFF001B0D);
  static const Color _buttonText = Color(0xFFEDEDED);

  String _txt(dynamic v) => v == null ? "" : v.toString();

  String _first(dynamic v) {
    if (v == null) return "";
    if (v is List && v.isNotEmpty) return _txt(v.first);
    return _txt(v);
  }

  Widget _title(String t) {
    return Text(
      t,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.bold,
        fontSize: 14,
        color: _textDark,
      ),
    );
  }

  Widget _value(String t) {
    return Text(
      t,
      style: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: _textDark,
      ),
    );
  }

  List<Map<String, dynamic>> _medicines() {
    final v = payload["medicines"];
    if (v is List) {
      return v
          .whereType<Map>()
          .map((e) => e.map((k, val) => MapEntry(k.toString(), val)))
          .toList()
          .cast<Map<String, dynamic>>();
    }
    return const [];
  }

  Widget _actionButton({
    required String title,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: _buttonText,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("overview".tr),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        surfaceTintColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
          iconSize: 20,
        ),
      ),
      body: Obx(() {
        if (controller.isPrescriptionLoading.value) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 26,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                width: MediaQuery.of(context).size.width * .6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(_primaryColor),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'loading'.tr,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        color: _primaryColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        final meds = _medicines();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Material(
                        elevation: 5,
                        color: Colors.white,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 12),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _title("chief_complaints".tr),
                                        const SizedBox(height: 4),
                                        _value(_txt(payload["note"])),
                                        const SizedBox(height: 12),
                                        _title("diagnosis".tr),
                                        const SizedBox(height: 4),
                                        _value(_first(payload["diagnosis"])),
                                        const SizedBox(height: 12),
                                        _title("investigations".tr),
                                        const SizedBox(height: 4),
                                        _value(
                                          _first(payload["investigations"]),
                                        ),
                                        const SizedBox(height: 12),
                                        _title("surgery".tr),
                                        const SizedBox(height: 4),
                                        _value(_first(payload["surgery"])),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Flexible(
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _title("medicine".tr),
                                        const SizedBox(height: 4),
                                        ListView.builder(
                                          itemCount: meds.length,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            final m = meds[index];
                                            final name = _txt(m["name"] ?? "");
                                            final note = _txt(m["note"] ?? "");
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                _value('${index + 1}. $name'),
                                                _value('${"notes".tr}: $note'),
                                                const SizedBox(height: 12),
                                              ],
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              _title("follow_up_date".tr),
                              const SizedBox(height: 4),
                              _value(_txt(payload["followUpDate"])),
                              const SizedBox(height: 12),
                              _title("referred_to".tr),
                              const SizedBox(height: 4),
                              _value(_txt(payload["referredTo"])),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: _actionButton(
                              title: 'back_to_edit'.tr,
                              color: const Color(0xFF888E9D),
                              onTap: () => Get.back(),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Flexible(
                            flex: 1,
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
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
