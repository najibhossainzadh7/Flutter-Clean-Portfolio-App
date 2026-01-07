import 'package:dio/dio.dart';
import 'package:flutter_clean_portfolio_app/core/failure.dart';
import 'package:flutter_clean_portfolio_app/core/network/token_storage.dart';
import 'package:flutter_clean_portfolio_app/features/auth/data/models/sign_in.dart';

class SignInRepository {
  final Dio dio;
  final TokenStorage tokenStorage;

  SignInRepository(this.dio, this.tokenStorage);

  Future<SignInResponse> signIn(SignInModel user) async {
    try {
      final res = await dio.post("/users/login", data: user.toJson());

      final data = res.data;

      if (data["token"] != null) {
        await tokenStorage.saveToken(data["token"]);
      }
      if (data["data"]["user"]["_id"] != null) {
        await tokenStorage.saveUserId(data["data"]["user"]["_id"]);
      } else {}

      return SignInResponse(
        success: data["status"] == "success",
        message: data["message"],
        token: data["token"],
        data: data["data"],
      );
    } on DioException catch (e) {
      throw ServerFailure(e.response?.data["message"] ?? "Login failed");
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }
}

class SignInResponse {
  final bool success;
  final String? message;
  final String? token;
  final dynamic data;

  SignInResponse({required this.success, this.message, this.token, this.data});
}
