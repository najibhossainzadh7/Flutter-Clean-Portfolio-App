import 'dart:io';
import 'package:dio/dio.dart';

class SignUpModel {
  SignUpModel({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirm,
    required this.stack,
    this.profilePhoto,
  });

  final File? profilePhoto;
  final String name;
  final String email;
  final String password;
  final String passwordConfirm;
  final String stack;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'passwordConfirm': passwordConfirm,
      'stack': stack,
    };
  }

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      ...toJson(),
      if (profilePhoto != null)
        'profilePhoto': await MultipartFile.fromFile(
          profilePhoto!.path,
          filename: profilePhoto!.path.split('/').last,
        ),
    });
  }
}
