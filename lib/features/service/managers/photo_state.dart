import 'package:equatable/equatable.dart';
import 'package:talabajon/data/models/photo/google_photo_model.dart';

import '../../../../core/constants/status.dart';

class PhotoState extends Equatable {
  final Status googleStatus;
  final String? errorMessage;
  final GooglePhotoModel? google;

  const PhotoState({
    required this.googleStatus,
    required this.errorMessage,
    required this.google,
  });

  factory PhotoState.initial() => PhotoState(
    googleStatus: Status.idle,
    errorMessage: null,
    google: null,
  );

  PhotoState copyWith({
    Status? googleStatus,
    String? errorMessage,
    GooglePhotoModel? google,
  }) {
    return PhotoState(
      googleStatus: googleStatus ?? this.googleStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      google: google ?? this.google,
    );
  }

  @override
  List<Object?> get props => [googleStatus, errorMessage, google];
}
