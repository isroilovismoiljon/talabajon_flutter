class RegisterResponseModel {
  final bool success;
  final String? message;
  final DateTime? timestamp;
  final RegisterDataModel? data;

  RegisterResponseModel({
    required this.success,
    this.message,
    this.timestamp,
    this.data,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      success: json['success'] ?? false,
      message: json['message'],
      timestamp: json['timestamp'] != null
          ? DateTime.tryParse(json['timestamp'])
          : null,
      data: json['data'] != null ? RegisterDataModel.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'timestamp': timestamp?.toIso8601String(),
    'data': data?.toJson(),
  };
}

class RegisterDataModel {
  final bool? success;
  final String? message;
  final RegisterUserModel? user;
  final String? token;
  final String? refreshToken;
  final String? tokenExpiry;
  final String? verificationCode;
  final String? telegramDeepLink;
  final bool? requiresVerification;

  RegisterDataModel({
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

  factory RegisterDataModel.fromJson(Map<String, dynamic> json) {
    return RegisterDataModel(
      success: json['success'],
      message: json['message'],
      user: json['user'] != null ? RegisterUserModel.fromJson(json['user']) : null,
      token: json['token'],
      refreshToken: json['refreshToken'],
      tokenExpiry: json['tokenExpiry'],
      verificationCode: json['verificationCode'],
      telegramDeepLink: json['telegramDeepLink'],
      requiresVerification: json['requiresVerification'],
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'message': message,
    'user': user?.toJson(),
    'token': token,
    'refreshToken': refreshToken,
    'tokenExpiry': tokenExpiry,
    'verificationCode': verificationCode,
    'telegramDeepLink': telegramDeepLink,
    'requiresVerification': requiresVerification,
  };
}

class RegisterUserModel {
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

  RegisterUserModel({
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

  factory RegisterUserModel.fromJson(Map<String, dynamic> json) {
    return RegisterUserModel(
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
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'username': username,
    'phoneNumber': phoneNumber,
    'telegramId': telegramId,
    'photo': photo,
    'balance': balance,
    'userRole': userRole,
    'referralId': referralId,
    'createdAt': createdAt?.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };
}
