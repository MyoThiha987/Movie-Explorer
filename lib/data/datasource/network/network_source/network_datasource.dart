import 'package:flutter_architecture/data/datasource/dto/movie_details_response_dto.dart';

import '../../dto/movie_dto.dart';

abstract class NetworkDatasource {
  Future<List<MovieDto>> getUpComingMovies();

  Future<List<MovieDto>> getNowPlayingMovies(int page);

  Future<List<MovieDto>> getTopRatedMovies(int page);

  Future<List<MovieDto>> getPopularMovies(int page);

  Future<MovieDetailsResponseDto> getMovieDetails(int movieId);

  Future<List<MovieDto>> searchMovies(int page, String query);
}
