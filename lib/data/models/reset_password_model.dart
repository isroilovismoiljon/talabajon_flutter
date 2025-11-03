class ResetPasswordModel {
  final String username;
  final String verificationCode;
  final String password;

  ResetPasswordModel({
    required this.username,
    required this.verificationCode,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    "username": username,
    "verificationCode": verificationCode,
    "password": password,
  };
}
