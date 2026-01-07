import 'package:dio/dio.dart';
import 'token_interceptor.dart';
import 'token_storage.dart';

class DioClient {
  final Dio dio;

  DioClient(String baseUrl)
      : dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            headers: {
              "Content-Type": "application/json",
            },
          ),
        ) {
    dio.interceptors.add(
      TokenInterceptor(TokenStorage()),
    );   dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
      requestHeader: true,
      responseHeader: true,
    ));
  }
}
