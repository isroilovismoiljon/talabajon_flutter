import 'package:equatable/equatable.dart';
import 'package:talabajon/data/models/design/design_detail_response.dart';
import 'package:talabajon/data/models/design/design_list_model.dart';

import '../../../../core/constants/status.dart';

class DesignState extends Equatable {
  final Status designStatus, detailStatus;
  final String? errorMessage;
  final DesignListModel? design;
  final DesignDetailResponse? detail;
  final Design? selectedPhotos;
  final int pageCount;

  const DesignState({
    required this.designStatus,
    required this.detailStatus,
    required this.errorMessage,
    required this.design,
    required this.detail,
    required this.selectedPhotos,
    required this.pageCount,
  });

  factory DesignState.initial() => const DesignState(
    designStatus: Status.idle,
    detailStatus: Status.idle,
    errorMessage: null,
    design: null,
    detail: null,
    selectedPhotos: null,
    pageCount: 0,
  );

  DesignState copyWith({
    Status? designStatus,
    Status? detailStatus,
    String? errorMessage,
    DesignListModel? design,
    DesignDetailResponse? detail,
    Design? selectedPhotos,
    int? pageCount,
  }) {
    return DesignState(
      designStatus: designStatus ?? this.designStatus,
      detailStatus: detailStatus ?? this.detailStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      design: design ?? this.design,
      detail: detail ?? this.detail,
      selectedPhotos: selectedPhotos ?? this.selectedPhotos,
      pageCount: pageCount ?? this.pageCount,
    );
  }

  @override
  List<Object?> get props => [designStatus, detailStatus, errorMessage, design, detail, selectedPhotos, pageCount];
}
