class DesignDetailResponse {
  final bool success;
  final DesignDetailModel? data;
  final String? timestamp;

  DesignDetailResponse({
    required this.success,
    this.data,
    this.timestamp,
  });

  factory DesignDetailResponse.fromJson(Map<String, dynamic> json) {
    return DesignDetailResponse(
      success: json['success'] ?? false,
      data: json['data'] != null
          ? DesignDetailModel.fromJson(json['data'])
          : null,
      timestamp: json['timestamp'],
    );
  }
}

class DesignDetailModel {
  final int id;
  final String title;
  final CreatedBy createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Photo> photos;
  final int photoCount;
  final String firstPhotoUrl;

  DesignDetailModel({
    required this.id,
    required this.title,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.photos,
    required this.photoCount,
    required this.firstPhotoUrl,
  });

  factory DesignDetailModel.fromJson(Map<String, dynamic> json) {
    return DesignDetailModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      createdBy: json['createdBy'] != null
          ? CreatedBy.fromJson(json['createdBy'])
          : CreatedBy.empty(),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
      photos: (json['photos'] as List<dynamic>?)
          ?.map((e) => Photo.fromJson(e))
          .toList() ??
          [],
      photoCount: json['photoCount'] ?? 0,
      firstPhotoUrl: json['firstPhotoUrl'] ?? '',
    );
  }
}

class CreatedBy {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String? phoneNumber;
  final String? telegramId;
  final String? photo;
  final int balance;
  final int userRole;
  final String? referralId;
  final DateTime createdAt;
  final DateTime updatedAt;

  CreatedBy({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    this.phoneNumber,
    this.telegramId,
    this.photo,
    required this.balance,
    required this.userRole,
    this.referralId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json['id'] ?? 0,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      username: json['username'] ?? '',
      phoneNumber: json['phoneNumber'],
      telegramId: json['telegramId'],
      photo: json['photo'],
      balance: json['balance'] ?? 0,
      userRole: json['userRole'] ?? 0,
      referralId: json['referralId'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }

  factory CreatedBy.empty() {
    return CreatedBy(
      id: 0,
      firstName: '',
      lastName: '',
      username: '',
      balance: 0,
      userRole: 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}

class Photo {
  final int id;
  final String photoPath;
  final String photoUrl;
  final String originalFileName;
  final int fileSize;
  final String fileSizeFormatted;
  final String contentType;
  final double left;
  final double top;
  final double width;
  final double height;
  final DateTime createdAt;
  final DateTime updatedAt;

  Photo({
    required this.id,
    required this.photoPath,
    required this.photoUrl,
    required this.originalFileName,
    required this.fileSize,
    required this.fileSizeFormatted,
    required this.contentType,
    required this.left,
    required this.top,
    required this.width,
    required this.height,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] ?? 0,
      photoPath: json['photoPath'] ?? '',
      photoUrl: json['photoUrl'] ?? '',
      originalFileName: json['originalFileName'] ?? '',
      fileSize: json['fileSize'] ?? 0,
      fileSizeFormatted: json['fileSizeFormatted'] ?? '',
      contentType: json['contentType'] ?? '',
      left: (json['left'] ?? 0).toDouble(),
      top: (json['top'] ?? 0).toDouble(),
      width: (json['width'] ?? 0).toDouble(),
      height: (json['height'] ?? 0).toDouble(),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }
}
