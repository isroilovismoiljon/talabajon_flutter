import 'package:talabajon/core/network/client.dart';
import 'package:talabajon/data/models/paymets/my_payments_model.dart';
import 'package:talabajon/data/models/paymets/payment_model.dart';
import 'package:talabajon/data/models/paymets/payment_response_model.dart';

import '../../core/utils/result.dart';

class PaymentsRepository {
  PaymentsRepository({required ApiClientStudent client}) : _client = client;
  final ApiClientStudent _client;

  Future<Result<MyPaymentsModel>> myPayments() async {
    var result = await _client.get(
      '/Payment/my-payments',
    );
    return result.fold(
      (error) {
        return Result.error(error);
      },
      (value) {
        return Result.ok(MyPaymentsModel.fromJson(value));
      },
    );
  }

  Future<Result<PaymentResponseModel>> payment(PaymentModel data) async {
    var result = await _client.post(
      '/Payment',
      data: await data.toFormData(),
    );
    return result.fold(
      (error) {
        return Result.error(error);
      },
      (value) {
        return Result.ok(PaymentResponseModel.fromJson(value));
      },
    );
  }
}
