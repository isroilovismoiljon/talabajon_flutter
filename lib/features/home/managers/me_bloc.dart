import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabajon/core/constants/status.dart';
import 'package:talabajon/data/repositories/user_repository.dart';
import 'package:talabajon/features/home/managers/me_event.dart';
import 'package:talabajon/features/home/managers/me_state.dart';

class MeBloc extends Bloc<UserEvent, MeState> {
  MeBloc({
    required UserRepository meRepo,
  }) : _meRepo = meRepo,
       super(MeState.initial()) {
    on<MeEvent>(_fetchUserMe);
  }

  final UserRepository _meRepo;

  Future<void> _fetchUserMe(MeEvent event, Emitter<MeState> emit) async {
    emit(state.copyWith(meStatus: Status.loading, errorMessage: null));
    final result = await _meRepo.userMe();
    result.fold(
      (error) => emit(state.copyWith(errorMessage: error.toString(), meStatus: Status.error)),
      (success) => emit(state.copyWith(meStatus: Status.success, userMe: success)),
    );
  }
}
