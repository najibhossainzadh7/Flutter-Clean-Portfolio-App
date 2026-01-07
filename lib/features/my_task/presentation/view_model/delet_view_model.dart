import 'package:flutter_clean_portfolio_app/features/my_task/presentation/provider/my_task_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_portfolio_app/core/failure.dart';
import 'package:flutter_clean_portfolio_app/features/my_task/data/repositories/delet_report.dart';

class DeleteReportViewModel extends AsyncNotifier<void> {
  late final DeleteReportRepository repository;

  @override
  Future<void> build() {
    repository = ref.read(deleteReportRepositoryProvider);
    return Future.value();
  }

  Future<void> deleteReport(String postId) async {
    state = const AsyncValue.loading();
    try {
      await repository.deleteReport(postId);
      state = const AsyncValue.data(null); 
    } on Failure catch (e) {
      state = AsyncValue.error(e.message, StackTrace.current);
    } catch (e) {
      state = AsyncValue.error(e.toString(), StackTrace.current);
    }
  }
}
