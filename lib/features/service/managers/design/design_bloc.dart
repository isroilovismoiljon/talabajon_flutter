import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talabajon/core/constants/status.dart';
import 'package:talabajon/data/repositories/design_repository.dart';
import 'package:talabajon/features/service/managers/design/design_event.dart';
import 'package:talabajon/features/service/managers/design/design_state.dart';

class DesignBloc extends Bloc<DesignEvent, DesignState> {
  final DesignRepository _designRepo;

  DesignBloc({
    required DesignRepository designRepo,
  }) : _designRepo = designRepo,
       super(DesignState.initial()) {
    on<DesignListEvent>(_fetchDesign);
    add(DesignListEvent());
    on<DesignDetailEvent>(_fetchDesignDetail);
    on<SelectDesignPhotoEvent>(_onSelectDesignPhoto);

  }

  Future<void> _fetchDesign(DesignListEvent event, Emitter<DesignState> emit) async {
    emit(state.copyWith(designStatus: Status.loading, errorMessage: null));

    final result = await _designRepo.designList(
      pageNumber: event.pageNumber,
      pageSize: event.pageSize,
    );
    result.fold(
      (error) => emit(
        state.copyWith(designStatus: Status.error, errorMessage: error.toString()),
      ),
      (success) => emit(
        state.copyWith(designStatus: Status.success, design: success),
      ),
    );
  }

  Future<void> _fetchDesignDetail(DesignDetailEvent event, Emitter<DesignState> emit) async {
    emit(state.copyWith(detailStatus: Status.loading, errorMessage: null));

    final result = await _designRepo.designDetail(id: event.id);
    result.fold(
      (error) => emit(
        state.copyWith(detailStatus: Status.error, errorMessage: error.toString()),
      ),
      (success) => emit(
        state.copyWith(detailStatus: Status.success, detail: success),
      ),
    );
  }
  void _onSelectDesignPhoto(
      SelectDesignPhotoEvent event,
      Emitter<DesignState> emit,
      ) {
    emit(state.copyWith(selectedPhotos: event.selectedDesign));
  }

}
