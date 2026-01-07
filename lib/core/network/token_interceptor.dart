import 'package:dio/dio.dart';
import 'token_storage.dart';

class TokenInterceptor extends Interceptor {
  final TokenStorage storage;

  TokenInterceptor(this.storage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await storage.getToken();

    if (token != null) {
      options.headers['Authorization'] = "Bearer $token";
    }

    return handler.next(options);
  }
}
