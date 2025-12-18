import 'package:beh_doctor/routes/AppRoutes.dart';
import 'package:beh_doctor/modules/auth/controller/DoctorProfileController.dart';
import 'package:beh_doctor/shareprefs.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _bootstrap();
  }


   

  Future<void> _bootstrap() async {
    await SharedPrefs.init();

    final token = SharedPrefs.getToken();

    if (token.isEmpty) {
      Get.offAllNamed(Routes.LOGIN);
      return;
    }

    if (!Get.isRegistered<DoctorProfileController>()) {
      Get.put(DoctorProfileController(), permanent: true);
    }

    Get.offAllNamed(Routes.BOTTOM_NAV);
  }
}
