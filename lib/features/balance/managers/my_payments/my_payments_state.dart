import 'package:equatable/equatable.dart';
import 'package:talabajon/data/models/paymets/my_payments_model.dart';

import '../../../../core/constants/status.dart';

class MyPaymentsState extends Equatable {
  final Status paymentStatus;
  final String? errorMessage;
  final MyPaymentsModel? payments;

  const MyPaymentsState({
    required this.paymentStatus,
    required this.errorMessage,
    required this.payments,
  });

  factory MyPaymentsState.initial() => MyPaymentsState(
    paymentStatus: Status.idle,
    errorMessage: null,
    payments: null,
  );

  MyPaymentsState copyWith({
    Status? paymentStatus,
    String? errorMessage,
    MyPaymentsModel? payments,
  }) {
    return MyPaymentsState(
      paymentStatus: paymentStatus ?? this.paymentStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      payments: payments ?? this.payments,
    );
  }

  @override
  List<Object?> get props => [paymentStatus, errorMessage, payments];
}
