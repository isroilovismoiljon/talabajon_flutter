import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabajon/core/constants/status.dart';
import 'package:talabajon/data/repositories/auth_repository.dart';
import 'package:talabajon/features/auth/managers/register/register_event.dart';
import 'package:talabajon/features/auth/managers/register/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({
    required AuthRepository authRepo,
  }) : _authRepo = authRepo,
       super(RegisterState.initial()) {
    on<RegisterPostEvent>(_fetchRegister);
  }

  final AuthRepository _authRepo;

  Future<void> _fetchRegister(RegisterPostEvent event, Emitter<RegisterState> emit) async {
    emit(state.copyWith(registerStatus: Status.loading, errorMessage: null));
    var result = await _authRepo.register(event.data);
    result.fold(
      (error) => emit(state.copyWith(errorMessage: error.toString(), registerStatus: Status.error)),
      (success) {
        print("success : ${success.data?.telegramDeepLink} ${success.data?.user?.id}");
        emit(state.copyWith(registerStatus: Status.success, register: success));
      },
    );
  }
}
