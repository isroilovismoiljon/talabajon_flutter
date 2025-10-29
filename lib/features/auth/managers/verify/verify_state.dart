import 'package:equatable/equatable.dart';
import 'package:talabajon/data/models/auth/register_response_model.dart';
import '../../../../core/constants/status.dart';

class VerifyState extends Equatable {
  final Status verifyStatus;
  final String? errorMessage;
  final RegisterResponseModel? verify;

  const VerifyState({
    required this.verifyStatus,
    required this.errorMessage,
    required this.verify,
  });

  factory VerifyState.initial() => VerifyState(
    verifyStatus: Status.idle,
    errorMessage: null,
    verify: null,
  );

  VerifyState copyWith({
    Status? verifyStatus,
    String? errorMessage,
    RegisterResponseModel? verify,
  }) {
    return VerifyState(
      verifyStatus: verifyStatus ?? this.verifyStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      verify: verify ?? this.verify,
    );
  }

  @override
  List<Object?> get props => [verifyStatus, errorMessage, verify];
}
