import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabajon/core/constants/status.dart';
import 'package:talabajon/data/repositories/auth_repository.dart';
import 'package:talabajon/features/auth/managers/login/login_event.dart';
import 'package:talabajon/features/auth/managers/login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthRepository authRepo,
  }) : _authRepo = authRepo,
       super(LoginState.initial()) {
    on<LoginPostEvent>(_fetchLogin);
  }

  final AuthRepository _authRepo;

  Future<void> _fetchLogin(LoginPostEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(loginStatus: Status.loading, errorMessage: null));
    var result = await _authRepo.login(event.data);
    result.fold(
      (error) => emit(state.copyWith(errorMessage: error.toString(), loginStatus: Status.error)),
      (success) => emit(state.copyWith(loginStatus: Status.success, login: success)),
    );
  }
}
