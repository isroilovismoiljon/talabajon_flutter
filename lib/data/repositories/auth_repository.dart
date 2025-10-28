import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:talabajon/data/models/auth/register_response_model.dart';

import '../../core/network/client.dart';
import '../../core/utils/result.dart';
import '../models/auth/register_request_model.dart';

class AuthRepository {
  final ApiClientStudent _client;
  final FlutterSecureStorage _secureStorage;

  AuthRepository({
    required ApiClientStudent client,
    required FlutterSecureStorage secureStorage,
  }) : _client = client,
       _secureStorage = secureStorage;

  Future<Result<RegisterResponseModel>> register(RegisterRequestModel model) async {
    var result = await _client.post<Map<String, dynamic>>(
      '/Auth/register',
      data: model.toJson(),
    );
    return result.fold(
      (error) {
        print("error: ${error}");
        return Result.error(error);
      },
      (value) async {
        print("succes: ${value}");
        return Result.ok(RegisterResponseModel.fromJson(value));
      },
    );
  }
}
