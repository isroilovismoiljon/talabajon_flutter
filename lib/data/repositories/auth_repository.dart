import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/network/client.dart';
import '../../core/routing/router.dart';
import '../../core/routing/routes.dart';
import '../../core/utils/result.dart';
import '../models/forgot_password_model.dart';
import '../models/login_model.dart';
import '../models/register_model.dart';

class AuthRepository {
  final ApiClientStudent _client;
  final FlutterSecureStorage _secureStorage;

  AuthRepository({required ApiClientStudent client, required FlutterSecureStorage secureStorage})
      : _client = client, _secureStorage = secureStorage;

  Future<Result<String>> register(RegisterModel model) async {
    var result = await _client.post<Map<String, dynamic>>(
      '/auth/register',
      data: model.toJson(),
    );
    return result.fold(
          (error) => Result.error(error),
          (value)async {
        final String token = value['accessToken'];
        await _secureStorage.write(key: 'token', value: token);
        await _secureStorage.write(key: 'login', value: model.username);
        await _secureStorage.write(key: 'password', value: model.password);
        return Result.ok(token);
      },
    );
  }

  Future<Result<String>> login(LoginModel model) async {
    var result = await _client.post<Map<String, dynamic>>(
      '/auth/login',
      data: model.toJson(),
    );
    return result.fold(
          (error) => Result.error(error),
          (value)async {
        final String token = value['accessToken'];
        await _secureStorage.write(key: 'token', value: token);
        await _secureStorage.write(key: 'login', value: model.username);
        await _secureStorage.write(key: 'password', value: model.password);
        return Result.ok(token);
      },
    );
  }

  Future<Result<void>> sendEmail(ForgotPasswordModel model) async {
    var result = await _client.post<Map<String, dynamic>>(
      '/auth/reset-password/email',
      data: model.toJson(),
    );
    return result.fold(
          (error) => Result.error(error),
          (value)async {
        return Result.ok(null);
      },
    );
  }

  // Future<Result<bool>> verify(ForgotPasswordModel model) async {
  //   var result = await _client.post<Map<String, dynamic>>(
  //     '/auth/reset-password/verify',
  //     data: model.toJsonVerify(),
  //   );
  //   return result.fold(
  //         (error) => Result.error(error),
  //         (value)async {
  //       return Result.ok(true);
  //     },
  //   );
  // }

  // Future<Result<bool>> reset(ForgotPasswordModel model) async {
  //   var result = await _client.post<Map<String, dynamic>>(
  //     '/auth/reset-password/reset',
  //     data: model.toJsonReset(),
  //   );
  //   return result.fold(
  //         (error) => Result.error(error),
  //         (value)async {
  //       return Result.ok(true);
  //     },
  //   );
  // }

  Future<void> logout()async{
    await _secureStorage.delete(key: 'token');
    await _secureStorage.delete(key: 'login');
    await _secureStorage.delete(key: 'password');
    router.go(Routes.login);
  }
}
