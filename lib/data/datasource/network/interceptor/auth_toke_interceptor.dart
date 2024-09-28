import 'package:dio/dio.dart';

class AuthTokeInterceptor extends Interceptor {
  final String token;

  AuthTokeInterceptor({required this.token});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(
        options..headers['Authorization'] = "Bearer $token", handler);
  }
}
