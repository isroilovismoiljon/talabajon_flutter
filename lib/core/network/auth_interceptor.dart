import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import '../routing/router.dart';
import '../routing/routes.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage secureStorage;

  AuthInterceptor({required this.secureStorage});

  final dio = Dio(
    BaseOptions(
      baseUrl: "http://89.223.126.116/api",
      // baseUrl: "http://172.20.10.6:8888/api/v1",
      // validateStatus: (status) => true,
    ),
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    var token = await secureStorage.read(key: 'token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
      // options.headers['Authorization'] = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6Imlzcm9pbG92QGdtYWlsLmNvbSIsImp0aSI6ImNkODNmM2U2LWJiOGYtNGZhNS04OWE5LTZjODA3NTUyNTk1MCIsInVzZXJpZCI6IjE3IiwiZXhwIjoxODUyNzM0NjI3LCJpc3MiOiJsb2NhbGhvc3QiLCJhdWQiOiJhdWRpZW5jZSJ9.qn8y9L8vQngTOyGbDBX1lyx9hc9ynIGEn07PYjaoQOw';
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode == 401) {
      var login = await secureStorage.read(key: 'login');
      var password = await secureStorage.read(key: 'password');

      if (login == null || password == null) await logout();

      var result = await dio.post('auth/login', data: {'login': login, 'password': password});
      String? token = result.data['token'];

      if (result.statusCode != 200 || token == null) await logout();

      await secureStorage.write(key: "token", value: token);
      final headers = response.requestOptions.headers;
      headers["Authorization"] = "Bearer $token";

      var retry = await dio.fetch(
        RequestOptions(
          baseUrl: response.requestOptions.baseUrl,
          path: response.requestOptions.path,
          method: response.requestOptions.method,
          data: response.requestOptions.data,
          headers: headers,
        ),
      );
      if (retry.statusCode != 200) await logout();
      super.onResponse(response, handler);
    } else{
      super.onResponse(response, handler);
    }

  }

  Future<void> logout() async {
    await secureStorage.delete(key: "token");
    await secureStorage.delete(key: "login");
    await secureStorage.delete(key: "password");
    router.go(Routes.login);
    return;
  }
}
