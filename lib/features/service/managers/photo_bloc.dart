import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:talabajon/core/constants/status.dart';
import 'package:talabajon/data/repositories/photo_repository.dart';
import 'package:talabajon/features/service/managers/photo_event.dart';
import 'package:talabajon/features/service/managers/photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  PhotoBloc({required PhotoRepository photoRepo}) : _photoRepo = photoRepo, super(PhotoState.initial()) {
    on<GoogleEvent>(
      _fetchGoogle,
      transformer: (events, mapper) => events.debounceTime(const Duration(milliseconds: 500)).switchMap(mapper),
    );
  }

  final PhotoRepository _photoRepo;

  Future<void> _fetchGoogle(GoogleEvent event, Emitter<PhotoState> emit) async {
    emit(state.copyWith(googleStatus: Status.loading, errorMessage: null));
    final result = await _photoRepo.google(title: event.title, page: event.page, pageSize: event.pageSize);
    result.fold(
      (error) {
        print("❎ error : $error");
        emit(state.copyWith(errorMessage: error.toString(), googleStatus: Status.error));
      },
      (success) {
        print("✅ success");
        emit(state.copyWith(googleStatus: Status.success, google: success));
      },
    );
  }
}
