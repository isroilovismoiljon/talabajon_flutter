class PaymentResponseModel {
  final bool success;
  final String message;
  final PaymentData data;
  final DateTime timestamp;

  PaymentResponseModel({
    required this.success,
    required this.message,
    required this.data,
    required this.timestamp,
  });

  factory PaymentResponseModel.fromJson(Map<String, dynamic> json) {
    return PaymentResponseModel(
      success: json['success'],
      message: json['message'],
      data: PaymentData.fromJson(json['data']),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}

class PaymentData {
  final int id;
  final Sender sender;
  final int requestedAmount;
  final int? approvedAmount;
  final int finalAmount;
  final String photo;
  final String? description;
  final int paymentStatus;
  final String? rejectReason;
  final int? processedByAdmin;
  final DateTime? processedAt;
  final String? adminNotes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool amountWasAdjusted;

  PaymentData({
    required this.id,
    required this.sender,
    required this.requestedAmount,
    this.approvedAmount,
    required this.finalAmount,
    required this.photo,
    required this.description,
    required this.paymentStatus,
    this.rejectReason,
    this.processedByAdmin,
    this.processedAt,
    this.adminNotes,
    required this.createdAt,
    required this.updatedAt,
    required this.amountWasAdjusted,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      id: json['id'],
      sender: Sender.fromJson(json['sender']),
      requestedAmount: json['requestedAmount'],
      approvedAmount: json['approvedAmount'],
      finalAmount: json['finalAmount'],
      photo: json['photo'],
      description: json['description'],
      paymentStatus: json['paymentStatus'],
      rejectReason: json['rejectReason'],
      processedByAdmin: json['processedByAdmin'],
      processedAt: json['processedAt'],
      adminNotes: json['adminNotes'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      amountWasAdjusted: json['amountWasAdjusted'],
    );
  }
}

class Sender {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String phoneNumber;
  final String telegramId;
  final String photo;
  final int balance;
  final int userRole;
  final int? referralId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Sender({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.phoneNumber,
    required this.telegramId,
    required this.photo,
    required this.balance,
    required this.userRole,
    this.referralId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
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
