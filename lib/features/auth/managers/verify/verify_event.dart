import 'package:talabajon/data/models/verify/verify_request_model.dart';
import 'package:talabajon/data/models/verify/verify_response_model.dart';

sealed class VerifyEvent {}

final class VerifyPostEvent extends VerifyEvent {
  final VerifyRequestModel data;

  VerifyPostEvent(this.data);
}
