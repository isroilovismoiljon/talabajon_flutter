import 'package:equatable/equatable.dart';
import 'package:talabajon/data/models/auth/auth_response_model.dart';
import '../../../../core/constants/status.dart';

class LoginState extends Equatable {
  final Status loginStatus;
  final String? errorMessage;
  final AuthResponseModel? login;

  const LoginState({
    required this.loginStatus,
    required this.errorMessage,
    required this.login,
  });

  factory LoginState.initial() => LoginState(
    loginStatus: Status.idle,
    errorMessage: null,
    login: null,
  );

  LoginState copyWith({
    Status? loginStatus,
    String? errorMessage,
    AuthResponseModel? login,
  }) {
    return LoginState(
      loginStatus: loginStatus ?? this.loginStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      login: login ?? this.login,
    );
  }

  @override
  List<Object?> get props => [loginStatus, errorMessage, login];
}
