import 'package:equatable/equatable.dart';
import 'package:talabajon/data/models/auth/register_response_model.dart';
import '../../../../core/constants/status.dart';

class RegisterState extends Equatable {
  final Status registerStatus;
  final String? errorMessage;
  final RegisterResponseModel? register;

  const RegisterState({
    required this.registerStatus,
    required this.errorMessage,
    required this.register,
  });

  factory RegisterState.initial() => RegisterState(
    registerStatus: Status.idle,
    errorMessage: null,
    register: null,
  );

  RegisterState copyWith({
    Status? registerStatus,
    String? errorMessage,
    RegisterResponseModel? register,
  }) {
    return RegisterState(
      registerStatus: registerStatus ?? this.registerStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      register: register ?? this.register,
    );
  }

  @override
  List<Object?> get props => [registerStatus, errorMessage, register];
}
