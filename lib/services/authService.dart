import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:my_family_mobile_app/controllers/errorController.dart';
import 'package:my_family_mobile_app/domain/models/account.dart';
import 'package:my_family_mobile_app/domain/models/tokens.dart';
import 'package:my_family_mobile_app/helpers/urls.dart';
import 'package:my_family_mobile_app/services/utils/AuthManager.dart';
import 'package:my_family_mobile_app/services/utils/dioPrivate.dart';

Future<Account?> login(dynamic authObject) async {
  try {
    final Dio dio = await getDioPrivate();
    final response = await dio.post(
      URL.loginUrl,
      data: jsonEncode(authObject),
    );

    if (response.statusCode == 200) {
      final tokens = Tokens(accessToken: response.data['accessToken'], refreshToken: response.data['refreshToken']);
      Get.find<AuthManager>().login(tokens);
      return Account.fromJson(response.data);
    } else {
      ErrorController.handleError(response);
      return null;
    }
  } catch (error) {
    ErrorController.handleError(error);
    return null;
  }
}

Future<Account?> register(dynamic registerObject) async {
  try {
    final Dio dio = await getDioPrivate();
    final response = await dio.post(
      URL.registerUrl,
      data: jsonEncode(registerObject),
    );

    if (response.statusCode == 200) {
      final tokens = Tokens(accessToken: response.data['accessToken'], refreshToken: response.data['refreshToken']);
      Get.find<AuthManager>().login(tokens);
      return Account.fromJson(response.data);
    } else {
      ErrorController.handleError(response);
      return null;
    }
  } catch (error) {
    ErrorController.handleError(error);
    return null;
  }
}

Future<bool> verify() async {
  try {
    final Dio dio = await getDioPrivate();
    final response = await dio.get(URL.verifyUrl);

    if (response.statusCode == 200) {
      return true;
    } else {
      ErrorController.handleError(response);
      return false;
    }
  } catch (error) {
    ErrorController.handleError(error);
    return false;
  }
}

Future<Tokens?> refresh(String refreshToken) async {
  try {
    final Dio dio = await getDioPrivate();
    final response = await dio.post(
      URL.refreshUrl,
      data: jsonEncode({'refreshToken': refreshToken}),
    );

    if (response.statusCode == 200) {
      final tokens = Tokens(accessToken: response.data['accessToken'], refreshToken: response.data['refreshToken']);
      return tokens;
    } else {
      ErrorController.handleError(response);
      return null;
    }
  } catch (error) {
    ErrorController.handleError(error);
    return null;
  }
}

Future<Tokens?> verifyAndRefreshToken(Tokens? token) async {
  try {
      final bool isValid = await verify();
      if (isValid) return null;
      
      if (token == null) return null ;
      final refreshToken = token.refreshToken;

      final token2 = await refresh(refreshToken);
      return token2;
      
  } catch (error) {
    ErrorController.handleError(error);
    return null;
  }
}