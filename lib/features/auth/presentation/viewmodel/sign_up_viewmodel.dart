import 'dart:io';
import 'package:flutter_clean_portfolio_app/features/auth/presentation/provider/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_portfolio_app/core/failure.dart';
import 'package:flutter_clean_portfolio_app/features/auth/data/models/sign_up.dart';
import 'package:flutter_clean_portfolio_app/features/auth/data/repositories/sign_up_repository.dart';


class SignUpViewModel extends AsyncNotifier<void> {
  late final SignUpRepository _repository;

  @override
  Future<void> build() async {
    _repository = ref.read(signUpRepositoryProvider);
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required String passwordConfirm,
    required String stack,
    File? profilePhoto,
  }) async {
    state = const AsyncLoading();

    try {
      final user = SignUpModel(
        name: name,
        email: email,
        password: password,
        passwordConfirm: passwordConfirm,
        stack: stack,
        profilePhoto: profilePhoto,
      );

      final response = await _repository.register(user);

      if (!response.success) {
        throw ServerFailure(response.message ?? "Registration failed");
      }

      state = const AsyncData(null);
    } on Failure catch (e) {
      state = AsyncError(e, StackTrace.current);
    } catch (e) {
      state = AsyncError(UnknownFailure(e.toString()), StackTrace.current);
    }
  }
}
