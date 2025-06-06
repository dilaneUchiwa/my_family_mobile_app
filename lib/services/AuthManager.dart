import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_family_mobile_app/domain/models/account.dart';
import 'package:my_family_mobile_app/domain/models/tokens.dart';

class AuthManager extends ChangeNotifier {
  Tokens? _tokens=Tokens(accessToken: "INIT", refreshToken: "INIT");
  Account? _account; // user login 
  static const _storage = FlutterSecureStorage(); // instance of local secure storage

  Tokens? get tokens => _tokens;
  Account? get account => _account;
  
  AuthManager() {
    // Load tokens during the instantiation of AuthManager
    _loadTokens();
  }

  Future<void> _loadTokens() async {
    final storedTokens = await getToken();
    if (storedTokens != null) {
      _tokens = storedTokens;
      try {
        // final account = await getMe();
        // if (account != null && account.isActive!) {
        //   _account = account;
        // } else {
        //   logout();
        // }
      } catch (error) {
        logout();
      }
      notifyListeners();
    }else{
      logout();
      notifyListeners();
    }
  }


  Future<void> verifyAndRefresh() async {
    
      // final newTokens = await verifyAndRefreshToken(_tokens!);
      // if (newTokens is Tokens) {
      //   _tokens = newTokens;
      //   notifyListeners();
      //   return ;
      // }

      // logout();
    
  }

  Future<void> login(Tokens tokens) async {
    _tokens = tokens;
    await storeTokens(tokens);

    try {
      // final account = await getMe(); 
      // if(account!=null && account.isActive!){
      //   _account = account;
      //   notifyListeners();
      //   return;
      // }
      // logout();
    } catch (error) {
      logout();
    }
  }

  void logout() {
    _tokens = null;
    _account = null;
    _clearTokens();
    notifyListeners();
  }

  Future<void> _clearTokens() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
  }

  static Future<void> storeTokens(Tokens? tokens) async {
    if (tokens != null && tokens.accessToken!="INIT") {
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
