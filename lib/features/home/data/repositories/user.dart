import 'package:dio/dio.dart';
import 'package:flutter_clean_portfolio_app/core/failure.dart';
import 'package:flutter_clean_portfolio_app/core/network/token_storage.dart';
import 'package:flutter_clean_portfolio_app/features/home/data/models/user.dart';

class UserRepository {
  final Dio dio;
  final TokenStorage tokenStorage;

  UserRepository({
    required this.dio,
    required this.tokenStorage,
  });

  Future<UserModel> getCurrentUser() async {
    try {
      final userId = await tokenStorage.getUserId();
      if (userId == null) {
        throw const AuthFailure('User not logged in');
      }

      final response = await dio.get('/users/interns');

      final data = response.data?['data'];
      if (data == null || data is! List) {
        throw const UnknownFailure('Invalid users data format');
      }

      final userJson = data.cast<Map<String, dynamic>>().firstWhere(
            (u) => u['_id'].toString() == userId.toString(),
            orElse: () => throw const NotFoundFailure('User not found'),
          );

      return UserModel.fromJson(userJson);
    }

    on DioException catch (e) {
      if (e.response != null) {
        final message =
            e.response?.data?['message'] ?? 'Failed to load user';
        throw ServerFailure(message);
      }

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw const NetworkFailure('Connection timeout');
      }

      throw const NetworkFailure('No internet connection');
    }

    on Failure {
      rethrow;
    }

    catch (e) {
      throw UnknownFailure(e.toString());
    }
  }
}
