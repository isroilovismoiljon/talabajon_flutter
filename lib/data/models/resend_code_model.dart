class ResendCodeModel {
  final int userId;

  ResendCodeModel({
    required this.userId,
  });

  factory ResendCodeModel.fromJson(Map<String, dynamic> json) => ResendCodeModel(
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
  };
}
