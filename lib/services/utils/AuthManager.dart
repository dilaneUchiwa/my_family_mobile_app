import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:my_family_mobile_app/domain/models/account.dart';
import 'package:my_family_mobile_app/domain/models/tokens.dart';
import 'package:my_family_mobile_app/services/authService.dart';

class AuthManager extends GetxController {
  static AuthManager get to => Get.find();
  
  final _tokens = Rx<Tokens?>(Tokens(accessToken: "INIT", refreshToken: "INIT"));
  final _account = Rx<Account?>(null);
  static const _storage = FlutterSecureStorage();

  Tokens? get tokens => _tokens.value;
  Account? get account => _account.value;

  @override
  void onInit() {
    super.onInit();
    _loadTokens();
  }

  Future<void> _loadTokens() async {
    final storedTokens = await getToken();
    if (storedTokens != null) {
      _tokens.value = storedTokens;
    } else {
      logout();
    }
  }

  Future<void> verifyAndRefresh() async {
    final newTokens = await AuthService.verifyAndRefreshToken(_tokens.value!);
    if (newTokens is Tokens) {
      _tokens.value = newTokens;
      return;
    }
    logout();
  }

  Future<void> login(Tokens tokens) async {
    _tokens.value = tokens;
    await storeTokens(tokens);
  }

  void logout() {
    _tokens.value = null;
    _account.value = null;
    _clearTokens();
  }

  Future<void> _clearTokens() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
  }

  static Future<void> storeTokens(Tokens? tokens) async {
    if (tokens != null && tokens.accessToken != "INIT") {
      await _storage.write(key: 'access_token', value: tokens.accessToken);
      await _storage.write(key: 'refresh_token', value: tokens.refreshToken);
    }
  }

  static Future<Tokens?> getToken() async {
    final accessToken = await _storage.read(key: 'access_token');
    final refreshToken = await _storage.read(key: 'refresh_token');

    if (accessToken != null && refreshToken != null) {
      return Tokens(accessToken: accessToken, refreshToken: refreshToken);
    }
    return null;
  }
}
