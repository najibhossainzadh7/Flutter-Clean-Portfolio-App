import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_clean_portfolio_app/features/home/presentation/provider/home_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/form_report.dart';
import '../../data/models/creat_report.dart';

class FormsReportViewModel extends AsyncNotifier<void> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay? signInTime;
  TimeOfDay? signOutTime;
  String? mentor;

  late final FormReportRepository repository;

  @override
  FutureOr<void> build() {
    repository = ref.read(formReportRepositoryProvider);
  }

  void pickDate(DateTime date) => selectedDate = date;
  void pickSignIn(TimeOfDay time) => signInTime = time;
  void pickSignOut(TimeOfDay time) => signOutTime = time;
  void setMentor(String m) => mentor = m;

  Future<void> submitReport({
    required String internId,
    required String task,
    required String tutor,
    required String reportText,
    required String mentorId,
  }) async {
    state = const AsyncValue.loading();

    String formatTimeOfDay(TimeOfDay? time) {
      if (time == null) return '';
      final hour12 = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
      final minutes = time.minute.toString().padLeft(2, '0');
      final period = time.period == DayPeriod.am ? 'AM' : 'PM';
      return '$hour12:$minutes $period';
    }

    final report = CreateReportModel(
      internId: internId,
      mentorId: mentorId,
      signIn: formatTimeOfDay(signInTime),
      signOut: formatTimeOfDay(signOutTime),
      task: task,
      report: reportText,
    );

    try {
      await Future.any([
        repository.report(report),
        Future.delayed(const Duration(seconds: 8), () {
          throw TimeoutException('Request Timeout');
        }),
      ]);

      state = const AsyncValue.data(null); 
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
