import 'dart:ui';

import 'package:get/get.dart';
import 'package:beh_doctor/shareprefs.dart';

class LanguageController extends GetxController {
  var selectedLang = 'en'.obs;

  @override
  void onInit() {
    super.onInit();
    final saved = SharedPrefs.getLanguage();
    selectedLang.value = saved;
    Get.updateLocale(Locale(saved));
  }

  void changeLanguage(String langCode) {
    selectedLang.value = langCode;
    SharedPrefs.saveLanguage(langCode);
    Get.updateLocale(Locale(langCode));
  }
}
