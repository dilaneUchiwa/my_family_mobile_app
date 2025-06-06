import 'package:my_family_mobile_app/controllers/homeController.dart';
import 'package:my_family_mobile_app/controllers/toastController.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:my_family_mobile_app/utils/storageConstant.dart';

class ErrorController {
  ToastController toastController = ToastController(title: '');
  handleError(errorResponseString) {
    print(errorResponseString);
    try {
      var errorObj = json.decode(errorResponseString.toString());
      var statusCode = errorObj['statusCode'];
      var message = errorObj['message'];
      if (statusCode == 403) {
        // logoutUser();
        showMessage(message);
      } else {
        showMessage(message);
      }
    } catch (error) {
      showMessage('error_message_server'.tr);
    }
  }

  void showMessage(message) {
    toastController =
        new ToastController(title: 'Error', message: message.toString().tr);
    toastController.showToast();
  }

  void logoutUser() async {
    var isLoggedIn = GetStorage().read(StorageConstants.loggedIn);
    isLoggedIn = isLoggedIn != null ? isLoggedIn : false;
    if (isLoggedIn) {
      Homecontroller homeController = Get.find();
      homeController.logoutUser('logout_session_expired'.tr);
    }
  }
}
