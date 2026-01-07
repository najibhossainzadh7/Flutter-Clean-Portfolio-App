import 'package:flutter_clean_portfolio_app/features/my_task/data/repositories/report.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_portfolio_app/features/my_task/data/models/report.dart';
import 'package:flutter_clean_portfolio_app/features/my_task/presentation/provider/my_task_providers.dart';

class ProfileReportViewModel extends AsyncNotifier<List<ProfileReport>> {
  late final ProfileReportRepository repository;

  @override
  Future<List<ProfileReport>> build() async {
    repository = ref.read(profilReportRepositoryProvider);
    return fetchReports();
  }

  Future<List<ProfileReport>> fetchReports() async {
    state = const AsyncValue.loading();
    try {
      final reports = await repository.getProfileReports();
      state = AsyncValue.data(reports);
      return reports;
    } catch (e, st) {
      state = AsyncValue.error(e.toString(), st);
      return [];
    }
  }

  Future<List<ProfileReport>> fetchFilterReports(String query) async {
    if (query.isEmpty) {
      return state.value ?? [];
    }

    state = const AsyncValue.loading();
    try {
      final filtered = await repository.filterReports(query);
      state = AsyncValue.data(filtered);
      return filtered;
    } catch (e, st) {
      state = AsyncValue.error(e.toString(), st);
      return [];
    }
  }
}
