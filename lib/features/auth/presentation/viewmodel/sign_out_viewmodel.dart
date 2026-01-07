import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_clean_portfolio_app/core/network/token.dart';

final signOutViewModelProvider =
    AsyncNotifierProvider<SignOutViewModel, void>(() => SignOutViewModel());

class SignOutViewModel extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    try {
      await clearHiveBox('avatarBox');

      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      final tokenStorage = ref.read(tokenStorageProvider);
      await tokenStorage.clearUser();
      await tokenStorage.clearToken();

      ref.invalidate(tokenStorageProvider);

      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> clearHiveBox(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      final box = Hive.box(boxName);
      await box.clear();
    } else {
      final box = await Hive.openBox(boxName);
      await box.clear();
    }
  }
}
