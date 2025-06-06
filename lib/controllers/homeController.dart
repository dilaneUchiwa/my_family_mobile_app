import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:my_family_mobile_app/controllers/toastController.dart';
import 'package:my_family_mobile_app/utils/storageConstant.dart';

class Homecontroller extends GetxController{
    void logoutUser(String logooutMessage) {
    var isLoggedIn = GetStorage().read(StorageConstants.loggedIn);
    isLoggedIn = isLoggedIn != null ? isLoggedIn : false;
    if (isLoggedIn) {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(now);
      GetStorage().write('lastLoginTime', formattedDate);
      GetStorage().remove(StorageConstants.loggedIn);
      // GetStorage().remove(StorageConstants.pushNotification);
      // GetStorage().remove(StorageConstants.sms);
      // GetStorage().remove(StorageConstants.email);
      ToastController(title: 'error'.tr, message: logooutMessage).showToast();
      Get.offNamedUntil(
          '/login', (route) => route.settings.name == '/auth-home');
    }
  }
}