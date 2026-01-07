import 'package:flutter_clean_portfolio_app/core/network/token_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tokenStorageProvider = StateProvider((ref) => TokenStorage());
