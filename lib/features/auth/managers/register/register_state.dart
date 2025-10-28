import 'package:equatable/equatable.dart';
import 'package:talabajon/data/models/auth/register_response_model.dart';
import '../../../../core/constants/status.dart';

class RegisterState extends Equatable {
  final Status registerStatus;
  final String? errorMessage;
  final String? telegramDeepLink;
  final RegisterResponseModel? register;

  const RegisterState({
    required this.registerStatus,
    required this.errorMessage,
    required this.telegramDeepLink,
    required this.register,
  });

  factory RegisterState.initial() => RegisterState(
    registerStatus: Status.idle,
    errorMessage: null,
    telegramDeepLink: "",
    register: null,
  );

  RegisterState copyWith({
    Status? registerStatus,
    String? errorMessage,
    String? telegramDeepLink,
    RegisterResponseModel? register,
  }) {
    return RegisterState(
      registerStatus: registerStatus ?? this.registerStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      telegramDeepLink: telegramDeepLink ?? this.telegramDeepLink,
      register: register ?? this.register,
    );
  }

  @override
  List<Object?> get props => [
    registerStatus,
    errorMessage,
    telegramDeepLink,
    register,
  ];
}
