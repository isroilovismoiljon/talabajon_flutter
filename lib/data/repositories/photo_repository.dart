import 'package:talabajon/core/network/client.dart';
import 'package:talabajon/data/models/photo/google_photo_model.dart';

import '../../core/utils/result.dart';

class PhotoRepository {
  PhotoRepository({required ApiClientStudent client}) : _client = client;
  final ApiClientStudent _client;

  Future<Result<GooglePhotoModel>> google({required String title, int? page, int? pageSize}) async {
    var result = await _client.get(
      '/Photo/google',
      queryParams: {
        'query': title,
        'page': page ?? 1,
        'pageSize': pageSize ?? 20
      }
    );
    return result.fold(
      (error) {
        return Result.error(error);
      },
      (value) {
        return Result.ok(GooglePhotoModel.fromJson(value));
      },
    );
  }
}
