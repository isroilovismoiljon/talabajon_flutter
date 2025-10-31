class ForgotPasswordModel {
  final String username;

  ForgotPasswordModel({
    required this.username,
  });

  Map<String, dynamic> toJson() => {
    "username": username,
  };
}
