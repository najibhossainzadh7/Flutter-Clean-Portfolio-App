  import 'dart:typed_data';
  import 'package:flutter_clean_portfolio_app/core/local_data.dart/data/repositories/local_data.dart';
  import 'package:flutter_riverpod/flutter_riverpod.dart';

  class AvatarViewModel extends StateNotifier<Uint8List?> {
    final AvatarRepository repository;

    AvatarViewModel(this.repository) : super(null) {
      _loadInitialAvatar();
    }

    Future<void> _loadInitialAvatar() async {
      final bytes = await repository.loadAvatar();
      if (bytes != null) {
        state = bytes;
      } 
    }

    Future<void> setAvatar(Uint8List bytes) async {
      await repository.saveAvatar(bytes);
      state = bytes;
    }
  }
