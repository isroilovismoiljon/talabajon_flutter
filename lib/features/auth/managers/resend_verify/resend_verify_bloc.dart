import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabajon/data/repositories/auth_repository.dart';
import 'package:talabajon/features/auth/managers/resend_verify/resend_verify_event.dart';
import 'package:talabajon/features/auth/managers/resend_verify/resend_verify_state.dart';

import '../../../../core/constants/status.dart';

class ResendVerifyBloc extends Bloc<ResendVerifyEvent, ResendVerifyState> {
  ResendVerifyBloc({
    required AuthRepository authRepo,
  }) : _authRepo = authRepo,
       super(ResendVerifyState.initial()) {
    on<ResendVerifyPostEvent>(_fetchResendVerify);
  }

  final AuthRepository _authRepo;

  Future<void> _fetchResendVerify(ResendVerifyPostEvent event, Emitter<ResendVerifyState> emit) async {
    emit(state.copyWith(resendStatus: Status.loading, errorMessage: null));
    var result = await _authRepo.resendVerify(event.data);
    result.fold(
      (error) => emit(state.copyWith(errorMessage: error.toString(), resendStatus: Status.error)),
      (success) => emit(state.copyWith(resendStatus: Status.success, resend: success)),
    );
  }
}
