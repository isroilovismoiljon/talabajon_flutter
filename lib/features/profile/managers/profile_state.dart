import 'package:equatable/equatable.dart';
import 'package:talabajon/data/models/photo/photo_model.dart';
import 'package:talabajon/data/models/user/me_model.dart';

import '../../../../core/constants/status.dart';

class ProfileState extends Equatable {
  final Status profileStatus;
  final String? errorMessage;
  final MeModel? profile;

  const ProfileState({
    required this.profileStatus,
    required this.errorMessage,
    required this.profile,
  });

  factory ProfileState.initial() => ProfileState(
    profileStatus: Status.idle,
    errorMessage: null,
    profile: null,
  );

  ProfileState copyWith({
    Status? profileStatus,
    String? errorMessage,
    MeModel? profile,
  }) {
    return ProfileState(
      profileStatus: profileStatus ?? this.profileStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      profile: profile ?? this.profile,
    );
  }

  @override
  List<Object?> get props => [profileStatus, errorMessage, profile];
}
