import 'package:equatable/equatable.dart';
import 'package:talabajon/data/models/photo/photo_model.dart';
import '../../../../core/constants/status.dart';

class PhotoState extends Equatable {
  final Status googleStatus, yandexState;
  final String? errorGoogle, errorYandex;
  final PhotoModel? google, yandex;
  final List<Photo> selectedPhotos;
  final int pageCount;

  const PhotoState({
    required this.googleStatus,
    required this.yandexState,
    required this.errorGoogle,
    required this.errorYandex,
    required this.google,
    required this.yandex,
    required this.selectedPhotos,
    required this.pageCount,
  });

  factory PhotoState.initial() => const PhotoState(
    googleStatus: Status.idle,
    yandexState: Status.idle,
    errorGoogle: null,
    errorYandex: null,
    google: null,
    yandex: null,
    selectedPhotos: [],
    pageCount: 0,
  );

  PhotoState copyWith({
    Status? googleStatus,
    Status? yandexState,
    String? errorGoogle,
    String? errorYandex,
    PhotoModel? google,
    PhotoModel? yandex,
    List<Photo>? selectedPhotos,
    int? pageCount,
  }) {
    return PhotoState(
      googleStatus: googleStatus ?? this.googleStatus,
      yandexState: yandexState ?? this.yandexState,
      errorGoogle: errorGoogle ?? this.errorGoogle,
      errorYandex: errorYandex ?? this.errorYandex,
      google: google ?? this.google,
      yandex: yandex ?? this.yandex,
      selectedPhotos: selectedPhotos ?? this.selectedPhotos,
      pageCount: pageCount ?? this.pageCount,
    );
  }

  @override
  List<Object?> get props => [googleStatus, yandexState, errorGoogle, errorYandex, google, yandex, selectedPhotos, pageCount];
}
