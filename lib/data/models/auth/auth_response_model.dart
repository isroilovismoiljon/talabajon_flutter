class AuthResponseModel {
  final bool success;
  final String? message;
  final DateTime? timestamp;
  final AuthDataModel? data;

  AuthResponseModel({
    required this.success,
    this.message,
    this.timestamp,
    this.data,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      success: json['success'],
      message: json['message'],
      timestamp: json['timestamp'] != null ? DateTime.tryParse(json['timestamp']) : null,
      data: json['data'] != null ? AuthDataModel.fromJson(json['data']) : null,
    );
  }
}

class AuthDataModel {
  final bool? success;
  final String? message;
  final AuthUserModel? user;
  final String? token;
  final String? refreshToken;
  final String? tokenExpiry;
  final String? verificationCode;
  final String? telegramDeepLink;
  final bool? requiresVerification;

  AuthDataModel({
    this.success,
    this.message,
    this.user,
    this.token,
    this.refreshToken,
    this.tokenExpiry,
    this.verificationCode,
    this.telegramDeepLink,
    this.requiresVerification,
  });

  factory AuthDataModel.fromJson(Map<String, dynamic> json) {
    return AuthDataModel(
      success: json['success'],
      message: json['message'],
      user: json['user'] != null ? AuthUserModel.fromJson(json['user']) : null,
      token: json['token'],
      refreshToken: json['refreshToken'],
      tokenExpiry: json['tokenExpiry'],
      verificationCode: json['verificationCode'],
      telegramDeepLink: json['telegramDeepLink'],
      requiresVerification: json['requiresVerification'],
    );
  }
}

class AuthUserModel {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? phoneNumber;
  final String? telegramId;
  final String? photo;
  final double? balance;
  final int? userRole;
  final int? referralId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AuthUserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.phoneNumber,
    this.telegramId,
    this.photo,
    this.balance,
    this.userRole,
    this.referralId,
    this.createdAt,
    this.updatedAt,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      username: json['username'],
      phoneNumber: json['phoneNumber'],
      telegramId: json['telegramId'],
      photo: json['photo'],
      balance: (json['balance'] as num?)?.toDouble(),
      userRole: json['userRole'],
      referralId: json['referralId'],
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
    );
  }
}
