import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabajon/data/repositories/payments_repository.dart';
import 'package:talabajon/features/balance/managers/payment/payment_event.dart';
import 'package:talabajon/features/balance/managers/payment/payment_state.dart';

import '../../../../core/constants/status.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc({
    required PaymentsRepository paymentRepo,
  }) : _paymentRepo = paymentRepo,
       super(PaymentState.initial()) {
    on<PaymentNewEvent>(_fetchPayment);
  }

  final PaymentsRepository _paymentRepo;

  Future<void> _fetchPayment(PaymentNewEvent event, Emitter<PaymentState> emit) async {
    emit(state.copyWith(paymentStatus: Status.loading, errorMessage: null));
    final result = await _paymentRepo.payment(event.data);
    result.fold(
      (error) => emit(state.copyWith(errorMessage: error.toString(), paymentStatus: Status.error)),
      (success) => emit(state.copyWith(paymentStatus: Status.success, payment: success)),
    );
  }
}
