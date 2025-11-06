
import '../../../../data/models/photo/photo_model.dart';

sealed class PhotoEvent {}

final class GoogleEvent extends PhotoEvent {
  final String title;
  final int? page, pageSize;

  GoogleEvent({required this.title, this.page, this.pageSize});
}

final class YandexEvent extends PhotoEvent {
  final String title;
  final int? page, pageSize;

  YandexEvent({required this.title, this.page, this.pageSize});
}

final class TogglePhotoSelectionEvent extends PhotoEvent {
  final Photo photo;

  TogglePhotoSelectionEvent(this.photo);
}

final class SetPhotoLimitEvent extends PhotoEvent {
  final int pageCount;

  SetPhotoLimitEvent(this.pageCount);
}

final class RemovePhotoEvent extends PhotoEvent {
  final int index;

  RemovePhotoEvent(this.index);
}
