import 'package:dio/dio.dart';
import 'package:flutter_clean_portfolio_app/core/failure.dart';
import 'package:flutter_clean_portfolio_app/features/home/data/models/creat_report.dart';

class FormReportRepository {
  final Dio dio;

  FormReportRepository({required this.dio});

  Future<ReportResponse> report(CreateReportModel report) async {
    try {
      final formData = await report.toFormData();

      final response = await dio.post(
        '/reports',
        data: formData,
      );

      final data = response.data;
      if (data == null) {
        throw const UnknownFailure('Empty response from server');
      }

      return ReportResponse(
        success: data['status'] == 'success',
        message: data['message'] as String?,
        data: data['data'],
      );
    }

    on DioException catch (e) {
      if (e.response != null) {
        final message =
            e.response?.data?['message'] ?? 'Server error occurred';
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

class ReportResponse {
  final bool success;
  final String? message;
  final dynamic data;

  const ReportResponse({
    required this.success,
    this.message,
    this.data,
  });
}
