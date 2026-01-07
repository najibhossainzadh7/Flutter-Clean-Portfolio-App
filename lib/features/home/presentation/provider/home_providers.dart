import 'package:flutter_clean_portfolio_app/features/home/data/models/mentor.dart';
import 'package:flutter_clean_portfolio_app/features/home/data/models/report.dart';
import 'package:flutter_clean_portfolio_app/features/home/data/models/user.dart';
import 'package:flutter_clean_portfolio_app/features/home/data/repositories/mentor.dart';
import 'package:flutter_clean_portfolio_app/features/home/data/repositories/report.dart';
import 'package:flutter_clean_portfolio_app/features/home/presentation/view_model/report_view_model.dart';
import 'package:flutter_clean_portfolio_app/features/home/presentation/view_model/user_data_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_portfolio_app/core/network/dio.dart';
import 'package:flutter_clean_portfolio_app/features/home/presentation/view_model/forms_report_view_model.dart';

import '../../data/repositories/form_report.dart';
final formsReportProvider =
    AsyncNotifierProvider<FormsReportViewModel, void>(
  FormsReportViewModel.new,
);

final homeRefreshTriggerProvider = StateProvider<int>((ref) => 0);

final formReportRepositoryProvider = Provider<FormReportRepository>((ref) {
  final dio = ref.read(dioProvider); 
  return FormReportRepository(dio: dio);
});

final mentorRepoProvider = Provider<MentorRepository>((ref) {
  return MentorRepository(
    dio: ref.read(dioProvider),
  );
});

final mentorsProvider = FutureProvider<List<MentorModel>>((ref) async {
  return ref.read(mentorRepoProvider).getMentors();
});

final reportRepositoryProvider = Provider<ReportRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return ReportRepository(dio: dio);
});
final reportViewModelProvider =
    AsyncNotifierProvider<ReportViewModel, List<ReportModel>>(
  ReportViewModel.new,
);

final calendarProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

final userViewModelProvider =
    AsyncNotifierProvider<UserViewModel, UserModel>(
  UserViewModel.new,
);
