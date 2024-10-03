import 'package:dio/dio.dart';
import 'package:flutter_architecture/data/datasource/dto/movie_details_response_dto.dart';
import 'package:flutter_architecture/data/datasource/dto/movie_response.dart';
import 'package:retrofit/retrofit.dart';

part 'movie_service.g.dart';

@RestApi()
abstract class MovieService {
  factory MovieService(Dio dio) {
    return _MovieService(dio);
  }

  @GET('/3/movie/now_playing')
  Future<HttpResponse<MovieResponseDto>> getNowPlayingMovies(
      @Query("language") String? language, @Query("page") int? page);

  @GET('/3/movie/top_rated')
  Future<HttpResponse<MovieResponseDto>> getTopRateMovies(
      @Query("language") String? language, @Query("page") int? page);

  @GET('/3/movie/upcoming')
  Future<HttpResponse<MovieResponseDto>> getUpComingMovies(
      @Query("language") String? language, @Query("page") int? page);

  @GET('/3/movie/popular')
  Future<HttpResponse<MovieResponseDto>> getPopularMovies(
      @Query("language") String? language, @Query("page") int? page);

  @GET('/3/movie/{id}')
  Future<HttpResponse<MovieDetailsResponseDto>> getMovieDetails(
      @Path("id") int id,
      @Query("language") String? language,
      @Query("page") int? page);

  @GET('/3/search/movie')
  Future<HttpResponse<MovieResponseDto>> searchMovies(
      @Query("query") String? query,
      @Query("language") String? language,
      @Query("page") int? page);
}
