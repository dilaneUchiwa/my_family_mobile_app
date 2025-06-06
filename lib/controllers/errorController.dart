import 'package:my_family_mobile_app/controllers/homeController.dart';
import 'package:my_family_mobile_app/controllers/toastController.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:my_family_mobile_app/utils/storageConstant.dart';

class ErrorController {

  static handleError(errorResponseString) {
    print(errorResponseString);
    try {
      var errorObj = json.decode(errorResponseString.toString());
      var statusCode = errorObj['status'] ?? errorObj['statusCode'];
      var message = errorObj['details']  ?? errorObj['message'] ?? errorObj['error'];
      if (statusCode == 403 || statusCode == 401) {
        showMessage(message);
        logoutUser();
      } else {
        showMessage(message);
      }

    } catch (error) {

      showMessage('error_message_server'.tr);
    }
  }

  static void showMessage(message) {
    ToastController(title: 'error'.tr, message: message.toString().tr,type: ToastType.error).showToast();
  }

  static void logoutUser() async {
    var isLoggedIn = GetStorage().read(StorageConstants.loggedIn);
    isLoggedIn = isLoggedIn != null ? isLoggedIn : false;
    if (isLoggedIn) {
      Homecontroller homeController = Get.find();
      homeController.logoutUser('logout_session_expired'.tr);
    }
  }
}
