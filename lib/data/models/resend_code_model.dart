class ResendCodeModel {
  final int userId;

  ResendCodeModel({
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
    "userId": userId,
  };
}
