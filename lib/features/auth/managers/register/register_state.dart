import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/constants/status.dart';

part 'register_state.freezed.dart';

@freezed
abstract class RegisterState with _$RegisterState{
  const factory RegisterState({
    required Status statusRegister,
    required String? errorMessageRegister
  }) = _RegisterState;

  factory RegisterState.initial() => const RegisterState(
      statusRegister: Status.idle,
      errorMessageRegister: null
  );
}