import 'package:dio/dio.dart';
import 'package:flutter_clean_portfolio_app/core/network/dio_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  return DioClient("BASE URL").dio;
});
