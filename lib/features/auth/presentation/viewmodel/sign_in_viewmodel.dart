import 'package:flutter_clean_portfolio_app/features/auth/presentation/provider/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_portfolio_app/core/failure.dart';
import 'package:flutter_clean_portfolio_app/features/auth/data/models/sign_in.dart';
import 'package:flutter_clean_portfolio_app/features/auth/data/repositories/sign_in_repository.dart';

class SignInNotifier extends AsyncNotifier<void> {
  late final SignInRepository _repository;

  @override
  Future<void> build() async {
    _repository = ref.read(signInRepositoryProvider);
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty) {
      state = AsyncError(
        ValidationFailure('Email is required'),
        StackTrace.current,
      );
      return;
    }

    if (!email.contains('@')) {
      state = AsyncError(
        ValidationFailure('Enter a valid email'),
        StackTrace.current,
      );
      return;
    }

    if (password.isEmpty) {
      state = AsyncError(
        ValidationFailure('Password is required'),
        StackTrace.current,
      );
      return;
    }

    if (password.length < 8) {
      state = AsyncError(
        ValidationFailure('Password must be at least 8 characters'),
        StackTrace.current,
      );
      return;
    }

    state = const AsyncLoading();

    try {
      final user = SignInModel(
        email: email.trim(),
        password: password.trim(),
      );

      final response = await _repository.signIn(user);

      if (!response.success) {
        throw ServerFailure(
          response.message ?? 'Login failed',
        );
      }

      state = const AsyncData(null);
    } on Failure catch (e) {
      state = AsyncError(e, StackTrace.current);
    } catch (e) {
      state = AsyncError(
        UnknownFailure(e.toString()),
        StackTrace.current,
      );
    }
  }
}
