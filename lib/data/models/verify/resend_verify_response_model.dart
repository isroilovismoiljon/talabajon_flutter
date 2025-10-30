class ResendVerifyResponseModel {
  final bool success;
  final ResendVerifyData data;
  final String? timestamp;

  ResendVerifyResponseModel({
    required this.success,
    required this.data,
    this.timestamp,
  });

  factory ResendVerifyResponseModel.fromJson(Map<String, dynamic> json) {
    return ResendVerifyResponseModel(
      success: json['success'],
      data: ResendVerifyData.fromJson(json['data']),
      timestamp: json['timestamp'],
    );
  }
}

class ResendVerifyData {
  final bool success;
  final String? message;
  final dynamic user;
  final String? token;
  final String? refreshToken;
  final String? tokenExpiry;
  final String? verificationCode;
  final String? telegramDeepLink;
  final bool requiresVerification;

  ResendVerifyData({
    required this.success,
    this.message,
    this.user,
    this.token,
    this.refreshToken,
    this.tokenExpiry,
    this.verificationCode,
    this.telegramDeepLink,
    required this.requiresVerification,
  });

  factory ResendVerifyData.fromJson(Map<String, dynamic> json) {
    return ResendVerifyData(
      success: json['success'],
      message: json['message'],
      user: json['user'],
      token: json['token'],
      refreshToken: json['refreshToken'],
      tokenExpiry: json['tokenExpiry'],
      verificationCode: json['verificationCode'],
      telegramDeepLink: json['telegramDeepLink'],
      requiresVerification: json['requiresVerification'],
    );
  }
}
