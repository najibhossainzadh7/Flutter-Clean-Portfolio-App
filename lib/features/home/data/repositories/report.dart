import 'package:dio/dio.dart';
import 'package:flutter_clean_portfolio_app/core/failure.dart';
import 'package:flutter_clean_portfolio_app/features/home/data/models/report.dart';

class ReportRepository {
  final Dio dio;

  ReportRepository({required this.dio});

  Future<List<ReportModel>> getReports({
    String? search,
    String? date,
  }) async {
    try {
      final response = await dio.get(
        '/reports',
        queryParameters: {
          if (search != null && search.isNotEmpty) 's': search,
          if (date != null && date.isNotEmpty) 'date': date,
        },
      );

      final data = response.data?['data']?['result'];

      if (data == null || data is! List) {
        throw const UnknownFailure('Invalid reports data format');
      }

      return data
          .map<ReportModel>(
            (e) => ReportModel.fromJson(e as Map<String, dynamic>),
          )
          .toList();
    }

    on DioException catch (e) {
      if (e.response != null) {
        final message =
            e.response?.data?['message'] ?? 'Failed to load reports';
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
