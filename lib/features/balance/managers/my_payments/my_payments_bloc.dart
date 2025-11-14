import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabajon/data/repositories/payments_repository.dart';
import 'package:talabajon/features/balance/managers/my_payments/my_payments_event.dart';
import 'package:talabajon/features/balance/managers/my_payments/my_payments_state.dart';

import '../../../../core/constants/status.dart';

class MyPaymentsBloc extends Bloc<PaymentsEvent, MyPaymentsState> {
  MyPaymentsBloc({
    required PaymentsRepository paymentsRepo,
  }) : _paymentsRepo = paymentsRepo,
       super(MyPaymentsState.initial()) {
    on<MyPaymentsEvent>(_fetchMyPayments);
    add(MyPaymentsEvent());
  }

  final PaymentsRepository _paymentsRepo;

  Future<void> _fetchMyPayments(MyPaymentsEvent event, Emitter<MyPaymentsState> emit) async {
    emit(state.copyWith(paymentStatus: Status.loading, errorMessage: null));
    final result = await _paymentsRepo.myPayments();
    result.fold(
      (error) => emit(state.copyWith(errorMessage: error.toString(), paymentStatus: Status.error)),
      (success) => emit(state.copyWith(paymentStatus: Status.success, payments: success)),
    );
  }
}
