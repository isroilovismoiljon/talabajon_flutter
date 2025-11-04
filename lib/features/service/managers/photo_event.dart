sealed class PhotoEvent {}

final class GoogleEvent extends PhotoEvent {
  final String title;
  final int? page,pageSize;

  GoogleEvent({required this.title,this.page, this.pageSize,});
}
