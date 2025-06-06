import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:my_family_mobile_app/controllers/errorController.dart';
import 'package:my_family_mobile_app/controllers/homeController.dart';
import 'package:my_family_mobile_app/controllers/toastController.dart';
import 'package:my_family_mobile_app/routes/appRoutes.dart';
import 'package:my_family_mobile_app/services/authService.dart';
import 'package:my_family_mobile_app/utils/storageConstant.dart';

class LoginController extends GetxController {
  late ToastController toastController;
  ErrorController errorController = new ErrorController();
  var isLodaing = false.obs;
  var rememberMe = true.obs;
  final idTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  RxList<Map<String, dynamic>> biometricOptions = RxList();
  final flutterSecureStorage = const FlutterSecureStorage();
  var lastLoggedInUser = "".obs;
  var currentLocale = 'en'.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
    currentLocale.value = Get.locale?.languageCode ?? 'en';
  }

  void initData() async {
    rememberMe.value = GetStorage().read(StorageConstants.rememberMe) ?? false;
    String? userName = await flutterSecureStorage.read(key: StorageConstants.userName);
    lastLoggedInUser.value = userName ?? "";
    if (GetStorage().read(StorageConstants.rememberMe) ?? false) {
      String? password = await flutterSecureStorage.read( key:  StorageConstants.password);
      idTextController.text = userName ?? "";
      passwordTextController.text = password ?? '';
    }
  }

  void changeLanguage(String langCode) {
    currentLocale.value = langCode;
    Get.updateLocale(Locale(langCode));
    GetStorage().write(StorageConstants.langCode, langCode);
  }

  void authenticate({bool biometricLogin = false}) async {
    Get.dialog(
        Center(
            child: CircularProgressIndicator(
                color: Get.theme.colorScheme.primary)),
        barrierDismissible: false);
    try {
     
      var requestObject = {
        'username': idTextController.text.trim(),
        'password': passwordTextController.text.trim()
      };
      
      final account = await login(requestObject);

      if(account==null){
        Get.back(); 
      }else{
        Get.put(Homecontroller()).account.value = account;
          await GetStorage().write(StorageConstants.loggedIn, true);

        passwordTextController.clear();
        idTextController.clear();
        if (rememberMe.value) {
          await flutterSecureStorage.write(
              key: StorageConstants.userName, value: idTextController.text.trim());
          await flutterSecureStorage.write(
              key: StorageConstants.password, value: passwordTextController.text.trim());
        } else {
          await flutterSecureStorage.delete(key: StorageConstants.userName);
          await flutterSecureStorage.delete(key: StorageConstants.password);
        }

        Get.offAndToNamed(AppRoutes.home);
        toastController =
            ToastController(title: 'Success', message: 'logged in');
        toastController.showToast();
      }

    } catch (error) {
      ErrorController.handleError(error);
      Get.back();
    }
  }

  @override
  void onClose() {
    idTextController.dispose();
    passwordTextController.dispose();
    super.onClose();
  }
}
