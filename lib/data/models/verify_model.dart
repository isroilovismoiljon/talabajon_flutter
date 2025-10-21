class VerifyModel {
  final int userId;
  final String verificationCode;

  VerifyModel({
    required this.userId,
    required this.verificationCode,
  });

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "verificationCode": verificationCode,
  };
}
