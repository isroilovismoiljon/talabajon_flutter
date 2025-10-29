import 'package:talabajon/data/models/verify/verify_response_model.dart';

sealed class VerifyEvent {}

final class VerifyPostEvent extends VerifyEvent {
  final VerifyResponseModel data;

  VerifyPostEvent(this.data);
}
