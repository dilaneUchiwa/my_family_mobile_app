import 'dart:convert';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:my_family_mobile_app/controllers/errorController.dart';
import 'package:my_family_mobile_app/domain/models/account.dart';
import 'package:my_family_mobile_app/domain/models/space/space_node.dart';
import 'package:my_family_mobile_app/domain/models/tokens.dart';
import 'package:my_family_mobile_app/helpers/urls.dart';
import 'package:my_family_mobile_app/services/nodeService.dart';
import 'package:my_family_mobile_app/services/spaceService.dart';
import 'package:my_family_mobile_app/services/utils/AuthManager.dart';
import 'package:my_family_mobile_app/services/utils/dioPrivate.dart';

class AuthService {
  static Future<Account?> login(dynamic authObject) async {
    try {
      final Dio dio = await getDioPrivate();
      final response = await dio.post(
        URL.loginUrl,
        data: authObject, // Envoi direct de l'objet sans jsonEncode
      );

      if (response.statusCode == 200) {
        final tokens = Tokens(
            accessToken: response.data['accessToken'],
            refreshToken: response.data['refreshToken']);
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

  static Future<bool> register(dynamic registerObject) async {
    try {
      final Dio dio = await getDioPrivate();
      final response = await dio.post(
        URL.registerUrl,
        data: registerObject, // Envoi direct de l'objet sans jsonEncode
      );

      if (response.statusCode == 200) {
        final tokens = Tokens(
            accessToken: response.data['accessToken'],
            refreshToken: response.data['refreshToken']);
        await Get.find<AuthManager>().login(tokens);
        registerObject['baseNode'] = true;
        final node = await NodeService.createNode(registerObject);
        if (node == null) {
          return false;
        } else {
          final spaceNode = await SpaceService.createSpaceNode(SpaceNode(
              id: 0, userId: node.userId.toString(), pseudo: registerObject['username']));
          if (spaceNode == null) {
            return false;
          } else {
            return true;
          }
        }
      } else {
        ErrorController.handleError(response);
        return false;
      }
    } catch (error) {
      ErrorController.handleError(error);
      return false;
    }
  }

  static Future<bool> verify() async {
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

  static Future<Tokens?> refresh(String refreshToken) async {
    try {
      final Dio dio = await getDioPrivate();
      final response = await dio.post(
        URL.refreshUrl,
        data: jsonEncode({'refreshToken': refreshToken}),
      );

      if (response.statusCode == 200) {
        final tokens = Tokens(
            accessToken: response.data['accessToken'],
            refreshToken: response.data['refreshToken']);
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

  static Future<Tokens?> verifyAndRefreshToken(Tokens? token) async {
    try {
      final bool isValid = await verify();
      if (isValid) return null;

      if (token == null) return null;
      final refreshToken = token.refreshToken;

      final token2 = await refresh(refreshToken);
      return token2;
    } catch (error) {
      ErrorController.handleError(error);
      return null;
    }
  }
}
