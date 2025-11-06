import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabajon/core/constants/status.dart';
import 'package:talabajon/data/repositories/user_repository.dart';
import 'package:talabajon/features/home/managers/me_event.dart';
import 'package:talabajon/features/home/managers/me_state.dart';
import 'package:talabajon/features/profile/managers/profile_event.dart';
import 'package:talabajon/features/profile/managers/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required UserRepository profileRepo,
  }) : _profileRepo = profileRepo,
       super(ProfileState.initial()) {
    on<UpdateProfileEvent>(_fetchUpdateProfile);
  }

  final UserRepository _profileRepo;

  Future<void> _fetchUpdateProfile(UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(profileStatus: Status.loading, errorMessage: null));
    final result = await _profileRepo.updateProfile(event.profile);
    result.fold(
      (error) => emit(state.copyWith(errorMessage: error.toString(), profileStatus: Status.error)),
      (success) {
        emit(state.copyWith(profileStatus: Status.success, profile: success));
      },
    );
  }
}
