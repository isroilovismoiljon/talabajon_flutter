class RegisterRequestModel {
  final String username;
  final String firstName;
  final String lastName;
  final String password;
  final int? referralId;

  RegisterRequestModel({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.password,
    this.referralId,
  });

  Map<String, dynamic> toJson() => {
    "username": username,
    "first_name": firstName,
    "last_name": lastName,
    "password": password,
    if (referralId != null) "referral_id": referralId,
  };
}
