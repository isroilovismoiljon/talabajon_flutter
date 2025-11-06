class MeModel {
  bool success;
  UserData data;
  String? message;
  DateTime timestamp;


  MeModel({
    required this.success,
    required this.data,
    required this.message,
    required this.timestamp,
  });

  factory MeModel.fromJson(Map<String, dynamic> json) {
    return MeModel(
      success: json['success'],
      data: UserData.fromJson(json['data']),
      message: json["message"],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}

class UserData {
  int id;
  String firstName;
  String lastName;
  String username;
  String? phoneNumber;
  String telegramId;
  String photo;
  int balance;
  int userRole;
  int? referralId;
  DateTime createdAt;
  DateTime updatedAt;

  UserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    this.phoneNumber,
    required this.telegramId,
    required this.photo,
    required this.balance,
    required this.userRole,
    this.referralId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      username: json['username'],
      phoneNumber: json['phoneNumber'],
      telegramId: json['telegramId'],
      photo: json['photo'],
      balance: json['balance'],
      userRole: json['userRole'],
      referralId: json['referralId'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
