import 'package:talabajon/core/network/client.dart';
import 'package:talabajon/data/models/user/me_model.dart';
import 'package:talabajon/data/models/user/update_profile_model.dart';

import '../../core/utils/result.dart';

class UserRepository {
  UserRepository({
    required ApiClientStudent client,
  }) : _client = client;
  final ApiClientStudent _client;

  Future<Result<MeModel>> userMe() async {
    var result = await _client.get('/User/me');
    return result.fold(
      (error) {
        return Result.error(error);
      },
      (value) {
        return Result.ok(MeModel.fromJson(value));
      },
    );
  }

  Future<Result<MeModel>> updateProfile(UpdateProfileModel data) async {
    var result = await _client.patch('/User/update-profile',data: await data.toFormData());
    return result.fold(
          (error) {
        return Result.error(error);
      },
          (value) {
        return Result.ok(MeModel.fromJson(value));
      },
    );
  }
}
