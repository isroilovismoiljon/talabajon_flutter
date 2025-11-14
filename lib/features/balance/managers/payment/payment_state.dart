import 'package:equatable/equatable.dart';
import 'package:talabajon/data/models/paymets/payment_response_model.dart';

import '../../../../core/constants/status.dart';

class PaymentState extends Equatable {
  final Status paymentStatus;
  final String? errorMessage;
  final PaymentResponseModel? payment;

  const PaymentState({
    required this.paymentStatus,
    required this.errorMessage,
    required this.payment,
  });

  factory PaymentState.initial() => PaymentState(
    paymentStatus: Status.idle,
    errorMessage: null,
    payment: null,
  );

  PaymentState copyWith({
    Status? paymentStatus,
    String? errorMessage,
    PaymentResponseModel? payment,
  }) {
    return PaymentState(
      paymentStatus: paymentStatus ?? this.paymentStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      payment: payment ?? this.payment,
    );
  }

  @override
  List<Object?> get props => [paymentStatus, errorMessage, payment];
}
