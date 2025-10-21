import 'package:dio/dio.dart';
import '../utils/result.dart';
import 'auth_interceptor.dart';

class ApiClient {
  ApiClient({required AuthInterceptor interceptor, required String baseUrl})
      : dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      // validateStatus: (value) => true,
    ),
  )..interceptors.add(interceptor);

  late final Dio dio;

  Future<Result<T>> get<T>(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      var response = await dio.get(path, queryParameters: queryParams);
      if (response.statusCode != 200) {
        return Result.error(Exception(response.data));
      }
      return Result.ok(response.data as T);
    } on Exception catch (exception) {
      return Result.error(exception);
    }
  }

  Future<Result<T>> post<T>(String path, {required data, Map<String, dynamic>? queryParams}) async {
    try {
      final response = await dio.post(path, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Result.ok(response.data);
      } else {
        return Result.error(Exception(response.data));
      }
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<T>> patch<T>(String path, {required data, Map<String, dynamic>? queryParams}) async {
    try {
      var response = await dio.patch(path, data: data, queryParameters: queryParams);
      if (response.statusCode != 200) {
        return Result.error(response.data);
      }
      return Result.ok(response.data);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result> delete<T>(String path) async {
    try {
      var response = await dio.delete(path);
      if (response.statusCode != 204) {
        return Result.error(response.data);
      }
      return Result.ok(response.data);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}