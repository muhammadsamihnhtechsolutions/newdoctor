import 'package:beh_doctor/modules/AppointmentController.dart';
import 'package:beh_doctor/widgets/AppointmentListWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentTabScreen extends StatelessWidget {
  final AppointmentController _controller =
      Get.isRegistered<AppointmentController>()
      ? Get.find<AppointmentController>()
      : Get.put(AppointmentController());

  AppointmentTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _controller.fetchAppointments();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),

      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "appointments".tr,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),

      body: Column(
        children: [
          /// ================= SAME TAB UI AS WITHDRAW =================
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Obx(() {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF008541)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    _innerTab(
                      title: "upcoming".tr,
                      isSelected: _controller.selectedTab.value == 0,
                      onTap: () => _controller.changeTab(0),
                    ),
                    _innerTab(
                      title: "past".tr,
                      isSelected: _controller.selectedTab.value == 1,
                      onTap: () => _controller.changeTab(1),
                    ),
                  ],
                ),
              );
            }),
          ),

          /// ================= PAGE VIEW =================
          Expanded(
            child: Obx(() {
              return PageView(
                controller: _controller.pageController,
                onPageChanged: (i) => _controller.changeTab(i),
                children: [
                  AppointmentListWidget(
                    appointments: _controller.upcomingAppointments,
                    isLoading: _controller.isLoading.value,
                    errorMessage: _controller.errorMessage.value,
                    onRefresh: () async => _controller.fetchAppointments(),
                     isCompleted:false,
                    
                  ),

                  AppointmentListWidget(
                    appointments: _controller.pastAppointments,
                    isLoading: _controller.isLoading.value,
                    errorMessage: _controller.errorMessage.value,
                    onRefresh: () async => _controller.fetchAppointments(),
                    isCompleted:true,
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  /// 🔥 SAME INNER TAB AS WITHDRAW / TEST RESULT
  Widget _innerTab({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF008541) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
