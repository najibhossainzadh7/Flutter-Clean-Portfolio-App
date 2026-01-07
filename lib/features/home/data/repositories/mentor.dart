import 'package:dio/dio.dart';
import 'package:flutter_clean_portfolio_app/core/failure.dart';
import 'package:flutter_clean_portfolio_app/features/home/data/models/mentor.dart';

class MentorRepository {
  final Dio dio;

  MentorRepository({required this.dio});

  Future<List<MentorModel>> getMentors() async {
    try {
      final response = await dio.get('/users/trainers');

      final data = response.data?['data'];

      if (data == null || data is! List) {
        throw const UnknownFailure('Invalid mentors data format');
      }

      return data
          .map<MentorModel>(
            (e) => MentorModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    }

    on DioException catch (e) {
      if (e.response != null) {
        final message =
            e.response?.data?['message'] ?? 'Failed to load mentors';
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
