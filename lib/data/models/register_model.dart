
class RegisterModel {
  final String username;
  final String firstName;
  final String lastName;
  final String password;
  final int referralId;

  RegisterModel({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.referralId,
  });

  Map<String, dynamic> toJson() => {
    "username": username,
    "firstName": firstName,
    "lastName": lastName,
    "password": password,
    "referralId": referralId,
  };
}
