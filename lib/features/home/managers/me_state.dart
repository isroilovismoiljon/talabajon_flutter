import 'package:equatable/equatable.dart';
import 'package:talabajon/data/models/photo/photo_model.dart';
import 'package:talabajon/data/models/user/me_model.dart';

import '../../../../core/constants/status.dart';

class MeState extends Equatable {
  final Status meStatus;
  final String? errorMessage;
  final MeModel? userMe;

  const MeState({
    required this.meStatus,
    required this.errorMessage,
    required this.userMe,
  });

  factory MeState.initial() => MeState(
    meStatus: Status.idle,
    errorMessage: null,
    userMe: null,
  );

  MeState copyWith({
    Status? meStatus,
    String? errorMessage,
    MeModel? userMe,
  }) {
    return MeState(
      meStatus: meStatus ?? this.meStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      userMe: userMe ?? this.userMe,
    );
  }

  @override
  List<Object?> get props => [meStatus, errorMessage, userMe];
}
