import 'package:dio/dio.dart';
import 'package:flutter_clean_portfolio_app/features/my_task/data/models/report.dart';
import 'package:flutter_clean_portfolio_app/core/failure.dart';

class ProfileReportRepository {
  final Dio dio;

  ProfileReportRepository({required this.dio});

  List<ProfileReport> _parseReports(dynamic data) {
    if (data is! List) return [];
    return data.map((e) => ProfileReport.fromJson(e)).toList();
  }

  Future<List<ProfileReport>> getProfileReports() async {
    try {
      final res = await dio.get("/reports/myreports");
      final reportsData = res.data?['data']?['reports'];
      if (reportsData == null) {
        throw ServerFailure("No reports found");
      }
      return _parseReports(reportsData);
    } on DioException catch (dioError) {
      final message = dioError.response?.data['message'] ?? dioError.message ?? "Failed to fetch reports";
      throw ServerFailure(message);
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }

  Future<List<ProfileReport>> filterReports(String query) async {
    try {
      final res = await dio.get("/reports/myreports?date=$query");
      final reportsData = res.data?['data']?['reports'];
      if (reportsData == null) {
        throw ServerFailure("No reports found for this date");
      }
      return _parseReports(reportsData);
    } on DioException catch (dioError) {
      final message = dioError.response?.data['message'] ?? dioError.message ?? "Failed to fetch reports";
      throw ServerFailure(message);
    } catch (e) {
      throw UnknownFailure(e.toString());
    }
  }
}
