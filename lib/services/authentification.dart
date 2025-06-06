import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import '../domain/models/tokens.dart';

final apiUrl = '${dotenv.get('AUTH_SERVICE')}/auth';

final Dio dio = Dio(BaseOptions(
  baseUrl: apiUrl,
  contentType: 'application/json',
  validateStatus: (status) => status !=-1 ,
));

Future<Tokens?> signIn(String login, String password) async {
  try {
    final response = await dio.post(
      '/login',
      data: {'login': login, 'password': password},
    );

    if (response.statusCode == 200) {
      return Tokens.fromJson(response.data);
    } else if (response.statusCode == 404) {
      return Tokens.getNotFound();
    } else {
      return null;
    }

  } catch (e) {
    // throw Exception('Error during sign-in: $e');
    return null;
  }
}

Future<Tokens?> verifyAndRefreshToken(Tokens tokens) async {
  try {
    final response = await dio.post(
      '/verifyToken',
      data: {'token': tokens.accessToken},
    );

    if (response.statusCode == 200) {
      return response.data;
    }

    final refreshResponse = await dio.get(
      '/refreshToken',
      options: Options(headers: {
        'Authorization': 'Bearer ${tokens.refreshToken}'
      }),
    );

    if(refreshResponse.statusCode==401) return null;

    return Tokens.fromJson(refreshResponse.data);
    
  } catch (e) {
    // throw Exception('Error during token verification/refresh: $e');
    return null;
  }
}
