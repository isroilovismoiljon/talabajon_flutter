import 'package:equatable/equatable.dart';
import 'package:talabajon/data/models/verify/resend_verify_response_model.dart';

import '../../../../core/constants/status.dart';

class ResendVerifyState extends Equatable {
  final Status resendStatus;
  final String? errorMessage;
  final ResendVerifyResponseModel? resend;

  const ResendVerifyState({
    required this.resendStatus,
    required this.errorMessage,
    required this.resend,
  });

  factory ResendVerifyState.initial() => ResendVerifyState(
    resendStatus: Status.idle,
    errorMessage: null,
    resend: null,
  );

  ResendVerifyState copyWith({
    Status? resendStatus,
    String? errorMessage,
    ResendVerifyResponseModel? resend,
  }) {
    return ResendVerifyState(
      resendStatus: resendStatus ?? this.resendStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      resend: resend ?? this.resend,
    );
  }

  @override
  List<Object?> get props => [resendStatus, errorMessage, resend];
}
