class MyPaymentsModel {
  bool success;
  List<PaymentData> data;
  Filter filter;
  int count;
  String timestamp;

  MyPaymentsModel({
    required this.success,
    required this.data,
    required this.filter,
    required this.count,
    required this.timestamp,
  });

  factory MyPaymentsModel.fromJson(Map<String, dynamic> json) => MyPaymentsModel(
    success: json["success"],
    data: List<PaymentData>.from(json["data"].map((x) => PaymentData.fromJson(x))),
    filter: Filter.fromJson(json["filter"]),
    count: json["count"],
    timestamp: json["timestamp"],
  );
}

class PaymentData {
  int id;
  String senderName;
  String senderUsername;
  String processedByAdminName;
  int requestedAmount;
  String photo;
  int? approvedAmount;
  int finalAmount;
  int paymentStatus;
  String createdAt;
  String? processedAt;
  bool amountWasAdjusted;

  PaymentData({
    required this.id,
    required this.senderName,
    required this.senderUsername,
    required this.processedByAdminName,
    required this.requestedAmount,
    required this.photo,
    this.approvedAmount,
    required this.finalAmount,
    required this.paymentStatus,
    required this.createdAt,
    this.processedAt,
    required this.amountWasAdjusted,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) => PaymentData(
    id: json["id"],
    senderName: json["senderName"],
    senderUsername: json["senderUsername"],
    processedByAdminName: json["processedByAdminName"],
    requestedAmount: (json["requestedAmount"] as num).toInt(),
    photo: json["photo"],
    approvedAmount: json["approvedAmount"] != null
        ? (json["approvedAmount"] as num).toInt()
        : null,
    finalAmount: (json["finalAmount"] as num).toInt(),
    paymentStatus: (json["paymentStatus"] as num).toInt(),
    createdAt: json["createdAt"],
    processedAt: json["processedAt"],
    amountWasAdjusted: json["amountWasAdjusted"],
  );
}

class Filter {
  dynamic status;

  Filter({this.status});

  factory Filter.fromJson(Map<String, dynamic> json) => Filter(
    status: json["status"],
  );
}
