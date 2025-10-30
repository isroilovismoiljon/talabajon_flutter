import 'package:talabajon/data/models/verify/resend_verify_request_model.dart';

sealed class ResendVerifyEvent {}

final class ResendVerifyPostEvent extends ResendVerifyEvent {
  final ResendVerifyRequestModel data;

  ResendVerifyPostEvent(this.data);
}
