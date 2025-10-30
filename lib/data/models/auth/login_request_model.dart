class LoginRequestModel {
  final String username, password;

  LoginRequestModel({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
  };
}
