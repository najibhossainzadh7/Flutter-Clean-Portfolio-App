import 'package:flutter_clean_portfolio_app/features/home/data/models/report.dart';
import 'package:flutter_clean_portfolio_app/features/home/presentation/provider/home_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReportViewModel extends AsyncNotifier<List<ReportModel>> {
  @override
  Future<List<ReportModel>> build() async {
    return fetchReports();
  }

  Future<List<ReportModel>> fetchReports({String? search, String? date}) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(reportRepositoryProvider);
      final today = date ??
          "${DateTime.now().year}-"
          "${DateTime.now().month.toString().padLeft(2, '0')}-"
          "${DateTime.now().day.toString().padLeft(2, '0')}";
      final result = await repo.getReports(
        search: search ?? '',
        date: today,
      );
      state = AsyncValue.data(result);
      return result;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> updateSearch(String value) async {
    await fetchReports(search: value, date: null);
  }

  Future<void> updateDate(String date) async {
    await fetchReports(search: null, date: date);
  }
}
