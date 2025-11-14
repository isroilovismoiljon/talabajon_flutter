import 'dart:io';

import 'package:dio/dio.dart';

class UpdateProfileModel {
  final String firstName, lastName, userName, phoneNumber;
  final File? photo;

  UpdateProfileModel({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.phoneNumber,
    required this.photo,
  });

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      "FirstName": firstName,
      "LastName": lastName,
      "Username": userName,
      "PhoneNumber": phoneNumber,
      if (photo != null)
        "Photo": await MultipartFile.fromFile(photo!.path, filename: "profile.jpg"),
    });
  }
}
