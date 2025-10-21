class ResetPasswordModel {
  final String username;
  final String verificationCode;
  final String password;

  ResetPasswordModel({
    required this.username,
    required this.verificationCode,
    required this.password,
  });

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) => ResetPasswordModel(
    username: json["username"],
    verificationCode: json["verificationCode"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "verificationCode": verificationCode,
    "password": password,
  };
}
