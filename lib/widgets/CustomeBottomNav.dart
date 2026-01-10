
import 'package:beh_doctor/controller/BottomNavController.dart';
import 'package:beh_doctor/theme/Appcolars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavController controller = Get.put(
      BottomNavController(),
    ); // ✅ SAFE (build ke andar)

    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          navItem(controller, "Home", Icons.home, 0),
          navItem(controller, "Earnings", Icons.attach_money, 1),
          navItem(controller, "Queue", Icons.list_alt, 2),
          navItem(controller, "More", Icons.more_horiz, 3),
        ],
      ),
    );
  }

  Widget navItem(
    BottomNavController controller,
    String title,
    IconData icon,
    int pageIndex,
  ) {
    return GestureDetector(
      onTap: () => controller.changeTab(pageIndex),
      child: Obx(() {
        final selected = controller.currentIndex.value == pageIndex;
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: selected ? AppColors.color008541 : Colors.grey),
            const SizedBox(height: 2),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: selected ? AppColors.color008541 : Colors.grey,
              ),
            ),
          ],
        );
      }),
    );
  }
}
