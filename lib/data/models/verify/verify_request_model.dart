class VerifyRequestModel {
  final int userId;
  final String verificationCode;

  VerifyRequestModel({
    required this.userId,
    required this.verificationCode,
  });

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "verificationCode": verificationCode,
  };
}
