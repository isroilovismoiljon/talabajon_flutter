import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:talabajon/core/constants/status.dart';
import 'package:talabajon/data/repositories/photo_repository.dart';
import 'package:talabajon/features/service/managers/photo/photo_event.dart';
import 'package:talabajon/features/service/managers/photo/photo_state.dart';

import '../../../../data/models/photo/photo_model.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final PhotoRepository _photoRepo;

  PhotoBloc({required PhotoRepository photoRepo}) : _photoRepo = photoRepo, super(PhotoState.initial()) {
    on<GoogleEvent>(
      _fetchGoogle,
      transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 300)).switchMap(mapper),
    );
    on<YandexEvent>(
      _fetchYandex,
      transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 300)).switchMap(mapper),
    );
    on<TogglePhotoSelectionEvent>(_togglePhotoSelection);
    on<SetPhotoLimitEvent>(_setPhotoLimit);
    on<RemovePhotoEvent>(_removePhoto);
  }

  Future<void> _fetchGoogle(GoogleEvent event, Emitter<PhotoState> emit) async {
    if (event.title.isEmpty) {
      emit(
        state.copyWith(
          googleStatus: Status.success,
          google: PhotoModel(
            success: true,
            data: PhotoData(
              photos: [],
              totalCount: 0,
              page: 1,
              pageSize: 10,
              totalPages: 0,
              query: '',
              source: '',
            ),
            timestamp: DateTime.now().toString(),
          ),
        ),
      );
      return;
    }

    emit(state.copyWith(googleStatus: Status.loading, errorGoogle: null));

    final result = await _photoRepo.google(
      title: event.title,
      page: event.page,
      pageSize: event.pageSize,
    );

    result.fold(
      (error) => emit(
        state.copyWith(
          googleStatus: Status.error,
          errorGoogle: error.toString(),
        ),
      ),
      (success) => emit(
        state.copyWith(
          googleStatus: Status.success,
          google: success,
        ),
      ),
    );
  }

  Future<void> _fetchYandex(YandexEvent event, Emitter<PhotoState> emit) async {
    if (event.title.isEmpty) {
      emit(
        state.copyWith(
          yandexState: Status.success,
          yandex: PhotoModel(
            success: true,
            data: PhotoData(
              photos: [],
              totalCount: 0,
              page: 1,
              pageSize: 10,
              totalPages: 0,
              query: '',
              source: '',
            ),
            timestamp: DateTime.now().toString(),
          ),
        ),
      );
      return;
    }

    emit(state.copyWith(yandexState: Status.loading, errorYandex: null));

    final result = await _photoRepo.yandex(
      title: event.title,
      page: event.page,
      pageSize: event.pageSize,
    );

    result.fold(
      (error) => emit(
        state.copyWith(
          yandexState: Status.error,
          errorYandex: error.toString(),
        ),
      ),
      (success) => emit(
        state.copyWith(
          yandexState: Status.success,
          yandex: success,
        ),
      ),
    );
  }

  void _togglePhotoSelection(TogglePhotoSelectionEvent event, Emitter<PhotoState> emit) {
    final updatedList = List<Photo>.from(state.selectedPhotos);

    if (updatedList.contains(event.photo)) {
      updatedList.remove(event.photo);
    } else {
      if (updatedList.length < state.pageCount) {
        updatedList.add(event.photo);
      }
    }

    emit(state.copyWith(selectedPhotos: updatedList));
  }

  void _setPhotoLimit(SetPhotoLimitEvent event, Emitter<PhotoState> emit) {
    emit(state.copyWith(pageCount: event.pageCount));
  }

  void _removePhoto(RemovePhotoEvent event, Emitter<PhotoState> emit) {
    final updatedList = List<Photo>.from(state.selectedPhotos);
    if (event.index >= 0 && event.index < updatedList.length) {
      updatedList.removeAt(event.index);
      emit(state.copyWith(selectedPhotos: updatedList));
    }
  }
}
