class ForgotPasswordModel {
  final String username;

  ForgotPasswordModel({
    required this.username,
  });

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) => ForgotPasswordModel(
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
  };
}
