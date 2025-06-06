import 'dart:convert';
import 'package:bia_survey_mobile_app/api_call/authentification.dart';
import 'package:bia_survey_mobile_app/api_call/utils/dioPrivate.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:bia_survey_mobile_app/domain/models/account.dart';

final String apiUrl = '${dotenv.get('USER_SERVICE')}/api/v1/account';

Future<Account?> getMe() async {
  try {
    final Dio dio = await getDioPrivate();
    final response = await dio.get(
      '$apiUrl/me/authenticated',
    );

    if (response.statusCode == 200) {
      return Account.fromJson(response.data);
    } else {
      print('Failed to load data: ${response.statusCode}');
      return null;
    }
  } catch (error) {
    print('Error: $error');
    return null;
  }
}

Future<bool> updateMe(Account account) async {
  try {
   
    final Dio dio = await getDioPrivate();
    final response=await dio.patch(
      '$apiUrl/${account.id}',
       data: account
    );

    return response.statusCode == 200;
   
  } catch (e) {
    print('Error: $e');
    return false;
  }
}
