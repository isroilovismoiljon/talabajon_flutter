class VerifyResponseModel {
  final bool success;
  final VerifyData? data;
  final String? timestamp;

  VerifyResponseModel({
    required this.success,
    this.data,
    this.timestamp,
  });

  factory VerifyResponseModel.fromJson(Map<String, dynamic> json) {
    return VerifyResponseModel(
      success: json['success'] ?? false,
      data: json['data'] != null ? VerifyData.fromJson(json['data']) : null,
      timestamp: json['timestamp'],
    );
  }

  @override
  String toString() =>
      'VerifyResponseModel(success: $success, data: $data, timestamp: $timestamp)';
}

class VerifyData {
  final bool success;
  final String message;

  VerifyData({
    required this.success,
    required this.message,
  });

  factory VerifyData.fromJson(Map<String, dynamic> json) {
    return VerifyData(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }

  @override
  String toString() => 'VerifyData(success: $success, message: $message)';
}
