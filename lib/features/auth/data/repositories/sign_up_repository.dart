import 'package:dio/dio.dart';
import 'package:flutter_clean_portfolio_app/core/failure.dart';
import 'package:flutter_clean_portfolio_app/core/network/token_storage.dart';
import 'package:flutter_clean_portfolio_app/features/auth/data/models/sign_up.dart';

class SignUpRepository {
  final Dio dio;
  final TokenStorage tokenStorage;

  SignUpRepository(this.dio, this.tokenStorage);

  Future<SignUpResponse> register(SignUpModel user) async {
    try {
      final res = await dio.post(
        "/users/signup",
        data: await user.toFormData(),
        options: Options(contentType: 'multipart/form-data'),
      );

      final data = res.data;

      if (data["token"] != null) {
        await tokenStorage.saveToken(data["token"]);
      }

      final userId = data["data"]?["user"]?["_id"];
      if (userId != null) {
        await tokenStorage.saveUserId(userId);
      }

      return SignUpResponse(
        success: data["status"] == "success",
        message: data["message"],
        token: data["token"],
        data: data["data"],
      );
    } on DioException catch (e) {
      throw ServerFailure(e.response?.data["message"] ?? "Registration failed");
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }
}

class SignUpResponse {
  final bool success;
  final String? message;
  final String? token;
  final dynamic data;

  SignUpResponse({required this.success, this.message, this.token, this.data});
}
