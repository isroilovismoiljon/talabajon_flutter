import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:talabajon/data/models/auth/auth_response_model.dart';
import 'package:talabajon/data/models/auth/login_request_model.dart';
import 'package:talabajon/data/models/verify/resend_verify_request_model.dart';
import 'package:talabajon/data/models/verify/resend_verify_response_model.dart';
import 'package:talabajon/data/models/verify/verify_response_model.dart';

import '../../core/network/client.dart';
import '../../core/utils/result.dart';
import '../models/auth/register_request_model.dart';
import '../models/verify/verify_request_model.dart';

class AuthRepository {
  final ApiClientStudent _client;
  final FlutterSecureStorage _secureStorage;

  AuthRepository({
    required ApiClientStudent client,
    required FlutterSecureStorage secureStorage,
  }) : _client = client,
       _secureStorage = secureStorage;

  Future<Result<AuthResponseModel>> register(RegisterRequestModel model) async {
    var result = await _client.post<Map<String, dynamic>>(
      '/Auth/register',
      data: model.toJson(),
    );
    return result.fold(
      (error) {
        // print("error: ${error}");
        return Result.error(error);
      },
      (value) async {
        print("succes: ${value}");
        return Result.ok(AuthResponseModel.fromJson(value));
      },
    );
  }

  Future<Result<AuthResponseModel>> login(LoginRequestModel model) async {
    var result = await _client.post<Map<String, dynamic>>(
      '/Auth/login',
      data: model.toJson(),
    );
    return result.fold(
      (error) {
        return Result.error(error);
      },
      (value) async {
        print("token: ${ value["data"]?["token"]}");
        _secureStorage.write(key: "token", value:  value["data"]?["token"]);
        return Result.ok(AuthResponseModel.fromJson(value));
      },
    );
  }

  Future<Result<VerifyResponseModel>> verify(VerifyRequestModel model) async {
    var result = await _client.post<Map<String, dynamic>>(
      '/Auth/verify',
      data: model.toJson(),
    );
    return result.fold(
      (error) {
        // print("error: ${error}");
        return Result.error(error);
      },
      (value) async {
        // print("succes: ${value}");
        return Result.ok(VerifyResponseModel.fromJson(value));
      },
    );
  }

  Future<Result<ResendVerifyResponseModel>> resendVerify(ResendVerifyRequestModel model) async {
    var result = await _client.post<Map<String, dynamic>>(
      '/Auth/resend-verification-code',
      data: model.toJson(),
    );
    return result.fold(
      (error) {
        // print("error: ${error}");
        return Result.error(error);
      },
      (value) async {
        // print("succes: ${value}");
        return Result.ok(ResendVerifyResponseModel.fromJson(value));
      },
    );
  }
}
