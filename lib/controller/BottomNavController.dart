// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class BottomNavController extends GetxController {
//   RxInt index = 0.obs; // HOME = PAGE 0
//   PageController pageController = PageController(initialPage: 0);

//   void changeTab(int i) {
//     index.value = i;
//     pageController.jumpToPage(i);
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class BottomNavController extends GetxController {
//   final RxInt currentIndex = 0.obs;
//   late final PageController pageController;

//   @override
//   void onInit() {
//     pageController = PageController(initialPage: currentIndex.value);
//     super.onInit();
//   }

//   void changeTab(int i) {
//     currentIndex.value = i;
//     pageController.jumpToPage(i);
//   }

//   @override
//   void onClose() {
//     pageController.dispose();
//     super.onClose();
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class BottomNavController extends GetxController {
//   final RxInt currentIndex = 0.obs;
//   late final PageController pageController;

//   @override
//   void onInit() {
//     super.onInit();
//     pageController = PageController(initialPage: currentIndex.value);
//   }

//   void changeTab(int i) {
//     if (!pageController.hasClients) return; // 🔥 IMPORTANT FIX
//     currentIndex.value = i;
//     pageController.jumpToPage(i);
//   }

//   @override
//   void onClose() {
//     pageController.dispose();
//     super.onClose();
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class BottomNavController extends GetxController {
  final RxInt currentIndex = 0.obs;
  late final PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: currentIndex.value);
  }

  void changeTab(int i) {
    if (!pageController.hasClients) return;
    currentIndex.value = i;
    pageController.jumpToPage(i);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
