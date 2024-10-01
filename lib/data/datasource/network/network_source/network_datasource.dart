import 'package:flutter_architecture/data/datasource/dto/movie_details_response_dto.dart';

import '../../dto/movie_dto.dart';

abstract class NetworkDatasource{
  Future<List<MovieDto>> getUpComingMovies();
  Future<List<MovieDto>> getNowPlayingMovies();
  Future<List<MovieDto>> getTopRatedMovies();
  Future<List<MovieDto>> getPopularMovies();
  Future<MovieDetailsResponseDto> getMovieDetails(int movieId);
}