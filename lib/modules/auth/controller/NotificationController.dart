import 'package:beh_doctor/models/NotificationResponseModel.dart';
import 'package:beh_doctor/repo/AuthRepo.dart';
import 'package:get/get.dart';


class NotificationController extends GetxController {
  final AuthRepo _repo = AuthRepo();

  var isLoading = false.obs;
  var notifications = <NotificationModel>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final NotificationResponseModel response =
          await _repo.getNotificationList({});

      if (response.status == "success") {
        notifications.value =
            response.notificationData?.notificationList ?? [];
      } else {
        errorMessage.value = response.message ?? "Something went wrong";
      }
    } catch (e) {
      errorMessage.value = "Failed to load notifications";
    } finally {
      isLoading.value = false;
    }
  }
}
