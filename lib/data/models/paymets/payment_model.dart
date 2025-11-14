import 'dart:io';

import 'package:dio/dio.dart';

class PaymentModel {
  final num requestedAmount;
  final File? photo;

  PaymentModel({
    required this.requestedAmount,
    required this.photo,
  });

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      "RequestedAmount": requestedAmount,
      if (photo != null) "Photo": await MultipartFile.fromFile(photo!.path, filename: "profile.jpg"),
    });
  }
}
