import 'package:talabajon/core/network/client.dart';
import 'package:talabajon/data/models/design/design_detail_response.dart';
import 'package:talabajon/data/models/design/design_list_model.dart';
import 'package:talabajon/data/models/photo/photo_model.dart';

import '../../core/utils/result.dart';

class DesignRepository {
  DesignRepository({required ApiClientStudent client}) : _client = client;
  final ApiClientStudent _client;

  Future<Result<DesignListModel>> designList({int? pageNumber, int? pageSize}) async {
    var result = await _client.get(
      '/Design',
      queryParams: {
        'pageNumber': pageNumber ?? 1,
        'pageSize': pageSize ?? 20,
      },
    );
    return result.fold(
      (error) => Result.error(error),
      (value) => Result.ok(DesignListModel.fromJson(value)),
    );
  }

  Future<Result<DesignDetailResponse>> designDetail({required int id}) async {
    var result = await _client.get(
      '/Design/$id',
    );
    return result.fold(
      (error) => Result.error(error),
      (value) => Result.ok(DesignDetailResponse.fromJson(value)),
    );
  }
}
