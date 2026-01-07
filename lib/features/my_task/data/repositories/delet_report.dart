import 'package:dio/dio.dart';
import 'package:flutter_clean_portfolio_app/core/failure.dart';

class DeleteReportRepository {
  final Dio dio;

  DeleteReportRepository({required this.dio});

  Future<void> deleteReport(String postId) async {
    try {
      final res = await dio.delete("/reports/$postId");

    
      final status = res.data['status'] ?? '';
      final message = res.data['message'] ?? 'Delete failed';

      if (status.toLowerCase() != 'success') {
        throw ServerFailure(message);
      }
    } on DioException catch (dioError) {
      final message =
          dioError.response?.data['message'] ?? dioError.message ?? 'Delete failed';
      throw ServerFailure(message);
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }
}
