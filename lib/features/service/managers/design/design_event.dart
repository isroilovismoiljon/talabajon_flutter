import '../../../../data/models/design/design_list_model.dart';

sealed class DesignEvent {}

final class DesignListEvent extends DesignEvent {
  final int? pageNumber, pageSize;

  DesignListEvent({this.pageNumber, this.pageSize});
}

final class DesignDetailEvent extends DesignEvent {
  final int id;

  DesignDetailEvent({required this.id});
}
final class SelectDesignPhotoEvent extends DesignEvent {
  final Design selectedDesign;

  SelectDesignPhotoEvent(this.selectedDesign);
}

