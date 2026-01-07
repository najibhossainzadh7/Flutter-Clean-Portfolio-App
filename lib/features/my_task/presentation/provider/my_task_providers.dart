import 'package:flutter_clean_portfolio_app/features/my_task/data/models/report.dart';
import 'package:flutter_clean_portfolio_app/features/my_task/data/repositories/delet_report.dart';
import 'package:flutter_clean_portfolio_app/features/my_task/presentation/view_model/delet_view_model.dart';
import 'package:flutter_clean_portfolio_app/features/my_task/presentation/view_model/report_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_portfolio_app/core/network/dio.dart';
import 'package:flutter_clean_portfolio_app/features/my_task/data/repositories/report.dart';

final profilReportRepositoryProvider = Provider<ProfileReportRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return ProfileReportRepository(dio: dio);
});

final deleteReportProvider =
    AsyncNotifierProvider<DeleteReportViewModel, void>(
  () => DeleteReportViewModel(),
);

final deleteReportRepositoryProvider = Provider<DeleteReportRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return DeleteReportRepository(dio: dio);
});

final profileReportViewModelProvider =
    AsyncNotifierProvider<ProfileReportViewModel, List<ProfileReport>>(
  () => ProfileReportViewModel(),
);
