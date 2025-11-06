import 'package:equatable/equatable.dart';

class PhotoModel {
  final bool success;
  final PhotoData data;
  final String timestamp;

  PhotoModel({
    required this.success,
    required this.data,
    required this.timestamp,
  });

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
      success: json['success'],
      data: PhotoData.fromJson(json['data']),
      timestamp: json['timestamp'],
    );
  }
}

class PhotoData {
  final List<Photo> photos;
  final int totalCount;
  final int page;
  final int pageSize;
  final int totalPages;
  final String query;
  final String source;

  PhotoData({
    required this.photos,
    required this.totalCount,
    required this.page,
    required this.pageSize,
    required this.totalPages,
    required this.query,
    required this.source,
  });

  factory PhotoData.fromJson(Map<String, dynamic> json) {
    return PhotoData(
      photos: (json['photos'] as List<dynamic>?)?.map((e) => Photo.fromJson(e)).toList() ?? [],
      totalCount: json['totalCount'],
      page: json['page'],
      pageSize: json['pageSize'],
      totalPages: json['totalPages'],
      query: json['query'],
      source: json['source'],
    );
  }
}

class Photo extends Equatable {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String fullUrl;
  final int width;
  final int height;
  final String source;
  final String? author;
  final String? authorUrl;

  const Photo({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.fullUrl,
    required this.width,
    required this.height,
    required this.source,
    this.author,
    this.authorUrl,
  });

  @override
  List<Object?> get props => [id];

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      title: json['title'],
      thumbnailUrl: json['thumbnailUrl'],
      fullUrl: json['fullUrl'],
      width: json['width'],
      height: json['height'],
      source: json['source'],
      author: json['author'],
      authorUrl: json['authorUrl'],
    );
  }
}
