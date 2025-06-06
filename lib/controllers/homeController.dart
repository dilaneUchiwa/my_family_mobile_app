import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:my_family_mobile_app/controllers/toastController.dart';
import 'package:my_family_mobile_app/domain/models/account.dart';
import 'package:my_family_mobile_app/domain/models/node.dart';
import 'package:my_family_mobile_app/routes/appRoutes.dart';
import 'package:my_family_mobile_app/services/utils/AuthManager.dart';
import 'package:my_family_mobile_app/utils/storageConstant.dart';

class Homecontroller extends GetxController{
    var account = Account(
      username: '',
      email: '',
      baseNode: BaseNode(
        id: 0,
        title: '',
        firstName: '',
        lastName: '',
        birthDate: DateTime.now(),
        gender: '',
        address: '',
        phone: '',
        interests: [],
        userId: 0,
        baseNode: false,
      ),
    ).obs;

    void logoutUser(String logoutMessage) {
      var isLoggedIn = GetStorage().read(StorageConstants.loggedIn);
      isLoggedIn = isLoggedIn ?? false;
      if (isLoggedIn) {
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(now);
        GetStorage().write(StorageConstants.lastLoginTime, formattedDate);
        GetStorage().remove(StorageConstants.loggedIn);
        Get.find<AuthManager>().logout();
        ToastController(
          title: 'Info',
          message: logoutMessage,
          type: ToastType.info
        ).showToast();
        Get.offAllNamed(AppRoutes.login);
      }
    }
}