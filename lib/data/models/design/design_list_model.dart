class DesignListModel {
  final bool success;
  final DesignData data;
  final String timestamp;

  DesignListModel({
    required this.success,
    required this.data,
    required this.timestamp,
  });

  factory DesignListModel.fromJson(Map<String, dynamic> json) {
    return DesignListModel(
      success: json['success'],
      data: DesignData.fromJson(json['data']),
      timestamp: json['timestamp'],
    );
  }
}

class DesignData {
  final List<Design> designs;
  final Pagination pagination;

  DesignData({
    required this.designs,
    required this.pagination,
  });

  factory DesignData.fromJson(Map<String, dynamic> json) {
    return DesignData(
      designs: (json['designs'] as List<dynamic>).map((e) => Design.fromJson(e)).toList(),
      pagination: Pagination.fromJson(json['pagination']),
    );
  }
}

class Design {
  final int id;
  final String title;
  final String createdByName;
  final String createdByUsername;
  final String createdAt;
  final String updatedAt;
  final String firstPhotoUrl;
  final int photoCount;

  Design({
    required this.id,
    required this.title,
    required this.createdByName,
    required this.createdByUsername,
    required this.createdAt,
    required this.updatedAt,
    required this.firstPhotoUrl,
    required this.photoCount,
  });

  factory Design.fromJson(Map<String, dynamic> json) {
    return Design(
      id: json['id'],
      title: json['title'],
      createdByName: json['createdByName'],
      createdByUsername: json['createdByUsername'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      firstPhotoUrl: json['firstPhotoUrl'],
      photoCount: json['photoCount'],
    );
  }
}

class Pagination {
  final int currentPage;
  final int pageSize;
  final int totalCount;
  final int totalPages;

  Pagination({
    required this.currentPage,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['currentPage'],
      pageSize: json['pageSize'],
      totalCount: json['totalCount'],
      totalPages: json['totalPages'],
    );
  }
}
