import 'package:my_family_mobile_app/routes/appRoutes.dart';
import 'package:my_family_mobile_app/routes/router.dart';
import 'package:my_family_mobile_app/utils/storageConstant.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    startTime();
    super.onInit();
  }

  startTime() async {
    return Timer(const Duration(seconds: 3, milliseconds: 0), routeUser);
  }

  void routeUser() async {
    final isLoggedIn = GetStorage().read(StorageConstants.loggedIn)??false;
    final seenIntro = GetStorage().read(StorageConstants.seenIntro);
    Get.offNamed(
      isLoggedIn? AppRoutes.home :
        seenIntro != null && seenIntro ? AppRoutes.login : AppRoutes.introHome);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
