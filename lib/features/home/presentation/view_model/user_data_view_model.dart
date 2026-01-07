import 'package:flutter_clean_portfolio_app/features/home/data/models/user.dart';
import 'package:flutter_clean_portfolio_app/features/home/data/repositories/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_portfolio_app/core/network/dio.dart';
import 'package:flutter_clean_portfolio_app/core/network/token.dart';

class UserViewModel extends AsyncNotifier<UserModel> {
  late final UserRepository repository;

  @override
  Future<UserModel> build() async {
    repository = UserRepository(
      dio: ref.read(dioProvider),
      tokenStorage: ref.read(tokenStorageProvider),
    );

    return fetchUser();
  }

  Future<UserModel> fetchUser() {
    return repository.getCurrentUser();
  }

  Future<void> refreshUser() async {
    state = const AsyncValue.loading();
    try {
      final user = await repository.getCurrentUser();
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
