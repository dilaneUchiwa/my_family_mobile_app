import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:my_family_mobile_app/controllers/errorController.dart';
import 'package:my_family_mobile_app/controllers/toastController.dart';
import 'package:my_family_mobile_app/utils/storageConstant.dart';

class LoginController extends GetxController {
  late ToastController toastController;
  ErrorController errorController = new ErrorController();
  var isLodaing = false.obs;
  var rememberMe = true.obs;
  final idTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  RxList<Map<String, dynamic>> biometricOptions = RxList();
  FlutterSecureStorage flutterSecureStorage = FlutterSecureStorage();
  var lastLoggedInUser = "".obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  void initData() async {
    rememberMe.value = GetStorage().read(StorageConstants.rememberMe) ?? false;
    String? userName = await flutterSecureStorage.read(key: 'username');
    lastLoggedInUser.value = userName ?? "";
    if (GetStorage().read(StorageConstants.rememberMe) ?? false) {
      String? password = await flutterSecureStorage.read(key: 'password');
      idTextController.text = userName ?? "";
      //passwordTextController.text = password ?? '';
    }
  }

  void authenticate({bool biometricLogin = false}) async {
    // Get.dialog(
    //     Center(
    //         child: CircularProgressIndicator(
    //             color: Get.theme.colorScheme.primary)),
    //     barrierDismissible: false);
    // AuthService authService = new AuthService();
    // try {
    //   String? userName = await flutterSecureStorage.read(key: 'username');
    //   String? password = await flutterSecureStorage.read(key: 'password');
    //   var requestObject = {
    //     'client_id': 'PUBLIC_CLIENT',
    //     'grant_type': 'password',
    //     'username': biometricLogin
    //         ? 'c_$userName'
    //         : 'c_${idTextController.text.trim()}',
    //     'password':
    //         biometricLogin ? password : passwordTextController.text.trim(),
    //   };
    //   LoginResponce loginResponce =
    //       await authService.authenticate(requestObject);
    //   Get.back();
    //   await GetStorage().write('tokenType', loginResponce.tokenType);
    //   await GetStorage().write('accessToken', loginResponce.accessToken);
    //   await GetStorage().write('refreshToken', loginResponce.refreshToken);
    //   await GetStorage().write('tokenExpiry', loginResponce.expiresIn);
    //   await GetStorage().write(
    //     'tokenExpiryTime',
    //     DateFormat('dd/MM/yyyy HH:mm:ss').format(
    //       DateTime.now().add(
    //         Duration(seconds: loginResponce.expiresIn ?? 0),
    //       ),
    //     ),
    //   );
    //   await GetStorage()
    //       .write('refreshTokenExpiry', loginResponce.refreshExpiresIn);
    //   await GetStorage().write(StorageConstants.loggedIn, true);

    //   if (userName != null &&
    //       userName.isNotEmpty &&
    //       idTextController.text.trim().isNotEmpty &&
    //       idTextController.text.trim() != userName) {
    //     GetStorage().remove(StorageConstants.faceId);
    //     userName = idTextController.text.trim();
    //     password = passwordTextController.text.trim();
    //     GetStorage().remove(StorageConstants.fingerprint);
    //   }
    //   flutterSecureStorage.write(
    //       key: 'username', value: userName ?? idTextController.text);
    //   flutterSecureStorage.write(
    //       key: 'password', value: password ?? passwordTextController.text);
    //   passwordTextController.clear();
    //   Get.offAndToNamed('/home');
    //   toastController =
    //       new ToastController(title: 'Success', message: 'logged in');
    //   toastController.showToast();
    // } catch (error) {
    //   print(error);
    //   Get.back();
    //   errorController.handleError(error);
    // }
  }

  @override
  void onClose() {
    idTextController.dispose();
    passwordTextController.dispose();
    super.onClose();
  }
}
