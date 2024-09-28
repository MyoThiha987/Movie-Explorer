import 'package:dio/dio.dart';
import 'package:flutter_architecture/data/datasource/network/interceptor/auth_toke_interceptor.dart';

class DioFactory {

  Future<Dio> provideDio() async {
    final BaseOptions options = BaseOptions(
      baseUrl: 'https://api.themoviedb.org', // Replace with your API base URL
      connectTimeout: const Duration(
          milliseconds: 5000), // Use a Duration for the connectTimeout
      receiveTimeout: const Duration(
          milliseconds: 3000), // Use a Duration for the receiveTimeout
    );

    final Dio dio = Dio(options);
    dio.interceptors.add(AuthTokeInterceptor(
        token:
            'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2MWEzMWQzNWUwYTMyNzg1ZjJlNGM0NDk5ZjA0M2FlOCIsInN1YiI6IjVkYzM5NDBjOWQ4OTM5MDAxODM0YjVlZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Eve0FD4yriTnRWsCD0P2bTXplUlUObIIfs1Q5ChAdgc'));

    return dio;
  }
}
