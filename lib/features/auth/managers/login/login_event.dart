import 'package:talabajon/data/models/auth/login_request_model.dart';

sealed class LoginEvent {}

final class LoginPostEvent extends LoginEvent {
  final LoginRequestModel data;

  LoginPostEvent(this.data);
}
