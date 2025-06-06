import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:my_family_mobile_app/controllers/toastController.dart';
import 'package:my_family_mobile_app/domain/models/account.dart';
import 'package:my_family_mobile_app/domain/models/node.dart';
import 'package:my_family_mobile_app/routes/appRoutes.dart';
import 'package:my_family_mobile_app/services/utils/AuthManager.dart';
import 'package:my_family_mobile_app/utils/storageConstant.dart';

class Homecontroller extends GetxController {
  var hasConnection = true.obs;
  var previousConnection = false.obs;
  var currentBackPressTime = Rxn<DateTime>();
  var selectedNavIndex = 0.obs;
  bool isChanged = false;
  final connectivity = Connectivity();

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
              title: 'Info', message: logoutMessage, type: ToastType.info)
          .showToast();
      Get.offAllNamed(AppRoutes.login);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    initData();
  }

  Future<void> onRefresh() async {
    await resetState();
    initData();
  }

  void initData() async {
    var connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      hasConnection(true);
    } else if (connectivityResult == ConnectivityResult.wifi) {
      hasConnection(true);
    } else {
      hasConnection(false);
    }
    // fetchuserProfile();
  }

  void _connectionChange(ConnectivityResult result) {
    previousConnection(hasConnection.value);
    if (result == ConnectivityResult.mobile) {
      hasConnection(true);
    } else if (result == ConnectivityResult.wifi) {
      hasConnection(true);
    } else {
      hasConnection(false);
    }

    if (!previousConnection.value) {
      selectedNavIndex.value = 0;
      refreshHomePage();
    }
  }

  Future<Null> refreshHomePage() async {
    var isLoggedIn = GetStorage().read(StorageConstants.loggedIn);
    isLoggedIn = isLoggedIn != null ? isLoggedIn : false;
    if (isLoggedIn) {
      // onRefreshBalance();
    } else {
      logoutUser('logout_session_expired'.tr);
    }
  }
  
  @override
  Future<void> resetState() async {
    selectedNavIndex.value = 0;
    isChanged = false;
    hasConnection.value = true;
    previousConnection.value = false;
    currentBackPressTime.value = null;
  }
}
