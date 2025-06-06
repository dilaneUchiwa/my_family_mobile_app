import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;
  final usernameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  
  void register() {
    if(passwordTextController.text != confirmPasswordTextController.text) {
      Get.snackbar(
        'Error',
        'passwords_dont_match'.tr,
        backgroundColor: Colors.red,
        colorText: Colors.white
      );
      return;
    }
    
    // TODO: Implement actual registration with backend
    Get.snackbar(
      'Success',
      'registration_successful'.tr,
      backgroundColor: Colors.green,
      colorText: Colors.white
    );
    
    Get.offAllNamed('/login');
  }

  @override
  void onClose() {
    usernameTextController.dispose();
    emailTextController.dispose();
    passwordTextController.dispose();
    confirmPasswordTextController.dispose();
    super.onClose();
  }
}