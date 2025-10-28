import 'package:talabajon/data/models/auth/register_request_model.dart';

sealed class RegisterEvent {}
final class RegisterPostEvent extends RegisterEvent {
  final RegisterRequestModel data;

  RegisterPostEvent(this.data);
}
