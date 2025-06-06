import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:my_family_mobile_app/controllers/toastController.dart';
import 'package:my_family_mobile_app/domain/models/account.dart';
import 'package:my_family_mobile_app/domain/models/mock.dart';
import 'package:my_family_mobile_app/domain/models/node.dart';
import 'package:my_family_mobile_app/routes/appRoutes.dart';
import 'package:my_family_mobile_app/services/utils/AuthManager.dart';
import 'package:my_family_mobile_app/utils/storageConstant.dart';

class Homecontroller extends GetxController {
  var hasConnection = true.obs;
  var previousConnection = false.obs;
  var currentBackPressTime = Rxn<DateTime>();
  var selectedNavIndex = 0.obs;
  var isOnline = true.obs;
  bool isChanged = false;
  final connectivity = Connectivity();
  late Timer _connectivityTimer;

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
  
  var relations = familyTreeRelations.obs;

  @override
  void onInit() {
    super.onInit();
    _initConnectivityChecks();
    _checkInitialConnectivity();
  }

  void _initConnectivityChecks() {
    _connectivityTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => _checkConnectivityAndPing()
    );
  }

  Future<void> _checkConnectivityAndPing() async {
    final connectivityResult = await connectivity.checkConnectivity();
    final hasNetworkConnection = connectivityResult != ConnectivityResult.none;
    hasConnection.value = hasNetworkConnection;
    isOnline.value = hasNetworkConnection ? await _pingGoogle() : false;
  }

  Future<bool> _pingGoogle() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  void _handleConnectivityChange(ConnectivityResult result) {
    previousConnection(hasConnection.value);
    _checkConnectivityAndPing();
    if (!previousConnection.value && hasConnection.value) {
      selectedNavIndex.value = 0;
      _refreshHomePage();
    }
  }

  Future<void> _checkInitialConnectivity() async {
    await _checkConnectivityAndPing();
  }

  void logoutUser(String logoutMessage) {
    final isLoggedIn = GetStorage().read(StorageConstants.loggedIn) ?? false;
    if (isLoggedIn) {
      final formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());
      GetStorage().write(StorageConstants.lastLoginTime, formattedDate);
      GetStorage().remove(StorageConstants.loggedIn);
      Get.find<AuthManager>().logout();
      ToastController(title: 'Info', message: logoutMessage, type: ToastType.info).showToast();
      Get.offAllNamed(AppRoutes.login);
    }
  }

  Future<void> _refreshHomePage() async {
    final isLoggedIn = GetStorage().read(StorageConstants.loggedIn) ?? false;
    if (!isLoggedIn) logoutUser('logout_session_expired'.tr);
  }

  Future<void> onRefresh() async {
    await resetState();
    await _checkInitialConnectivity();
  }

  @override
  Future<void> resetState() async {
    selectedNavIndex.value = 0;
    isChanged = false;
    hasConnection.value = true;
    previousConnection.value = false;
    currentBackPressTime.value = null;
    isOnline.value = true;
  }

  @override
  void onClose() {
    _connectivityTimer.cancel();
    super.onClose();
  }
}
