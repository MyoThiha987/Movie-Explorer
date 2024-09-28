import 'package:dio/dio.dart';
import 'package:flutter_architecture/data/datasource/network/response/movie_response.dart';
import 'package:retrofit/retrofit.dart';

part 'movie_service.g.dart';

@RestApi()
abstract class MovieService {
  factory MovieService(Dio dio) {
    return _MovieService(dio);
  }

  @GET('/3/movie/popular')
  Future<HttpResponse<MovieResponseDto>> getPopularMovies(
      @Query("language") String? language,
      @Query("page") int? page);
}
