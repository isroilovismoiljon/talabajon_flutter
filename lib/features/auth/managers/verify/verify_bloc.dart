import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabajon/data/repositories/auth_repository.dart';
import 'package:talabajon/features/auth/managers/verify/verify_event.dart';
import 'package:talabajon/features/auth/managers/verify/verify_state.dart';

import '../../../../core/constants/status.dart';

class VerifyBloc extends Bloc<VerifyEvent, VerifyState> {
  VerifyBloc({
    required AuthRepository authRepo,
  }) : _authRepo = authRepo,
       super(VerifyState.initial()) {
    on<VerifyPostEvent>(_fetchVerify);
  }

  final AuthRepository _authRepo;

  Future<void> _fetchVerify(VerifyPostEvent event, Emitter<VerifyState> emit) async {
    emit(state.copyWith(verifyStatus: Status.loading, errorMessage: null));
    var result = await _authRepo.verify(event.data);
    result.fold(
      (error) => emit(
        state.copyWith(
          errorMessage: error.toString(),
          verifyStatus: Status.error,
        ),
      ),
      (success) {
        emit(
          state.copyWith(
            verifyStatus: Status.success,
            verify: success,
          ),
        );
      },
    );
  }
}
