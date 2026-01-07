import 'dart:typed_data';

import 'package:flutter_clean_portfolio_app/core/local_data.dart/data/repositories/local_data.dart';
import 'package:flutter_clean_portfolio_app/core/local_data.dart/presentation/view_model.dart/local_data.dart';
import 'package:flutter_clean_portfolio_app/core/network/dio.dart';
import 'package:flutter_clean_portfolio_app/core/network/token.dart';
import 'package:flutter_clean_portfolio_app/features/auth/data/repositories/sign_in_repository.dart';
import 'package:flutter_clean_portfolio_app/features/auth/data/repositories/sign_up_repository.dart';
import 'package:flutter_clean_portfolio_app/features/auth/presentation/viewmodel/sign_in_viewmodel.dart';
import 'package:flutter_clean_portfolio_app/features/auth/presentation/viewmodel/sign_up_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
final avatarRepositoryProvider = Provider((ref) {
  return AvatarRepository();
});

final avatarProvider = StateNotifierProvider<AvatarViewModel, Uint8List?>(
  (ref) {
    return AvatarViewModel(ref.read(avatarRepositoryProvider));
  },
);


final signInRepositoryProvider = Provider<SignInRepository>((ref) {
  return SignInRepository(
    ref.watch(dioProvider),      
    ref.watch(tokenStorageProvider),
  );
});


final signInProvider =
    AsyncNotifierProvider<SignInNotifier, void>(SignInNotifier.new);


  final signUpRepositoryProvider = Provider<SignUpRepository>((ref) {
      return SignUpRepository(
    ref.watch(dioProvider),
    ref.watch(tokenStorageProvider),
  );
});

final signUpViewModelProvider =
    AsyncNotifierProvider<SignUpViewModel, void>(SignUpViewModel.new);


final userTypeProvider = StateProvider<String>((ref) {
  return "Choose Your Stack";
});
