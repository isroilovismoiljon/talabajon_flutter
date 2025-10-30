class ResendVerifyRequestModel {
  final int userId;

  ResendVerifyRequestModel({
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
    "userId": userId,
  };
}
