import 'package:dio/dio.dart';
import 'package:my_family_mobile_app/domain/models/tokens.dart';
import 'package:my_family_mobile_app/services/utils/AuthManager.dart';


Future<Dio> getDioPrivate() async {
  Dio dioPrivate = Dio(BaseOptions(
  contentType: 'application/json',
  validateStatus: (status) => status !=-1 ,
));

  Tokens? token = await AuthManager.getToken();
  
  // Request interceptor
  dioPrivate.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
    if (options.headers['Authorization'] == null) {
      options.headers['Authorization'] = 'Bearer ${token?.accessToken}';
    }
    return handler.next(options);
  }));

  // Response interceptor
  dioPrivate.interceptors.add(InterceptorsWrapper(onError: (DioError error, handler) async {
    if (error.response != null && error.response?.statusCode == 401 && !error.requestOptions.extra['retry']) {
      error.requestOptions.extra['retry'] = true;

      try {
        
        // token = await verifyAndRefreshToken(token!);
        // if(token==null) return ;

        // error.requestOptions.headers['Authorization'] = 'Bearer ${token?.accessToken}';
        
        // AuthManager.storeTokens(token);

        return handler.resolve(await dioPrivate.fetch(error.requestOptions));

      } catch (refreshError) {
        print('Error refreshing token: $refreshError');
        return handler.next(error);
      }
    }

    return handler.next(error);
  }));

  return dioPrivate;
}
