import 'package:flutter_architecture/data/datasource/dto/movie_details_response_dto.dart';
import 'package:flutter_architecture/data/datasource/dto/movie_dto.dart';
import 'package:flutter_architecture/data/datasource/network/network_source/network_datasource.dart';

import '../service/movie_service.dart';

class NetworkDatasourceImpl extends NetworkDatasource {
  final MovieService service;

  NetworkDatasourceImpl({required this.service});

  @override
  Future<MovieDetailsResponseDto> getMovieDetails(int movieId) async {
    final response = await service.getMovieDetails(movieId, "en", 1);
    return response.data;
  }

  @override
  Future<List<MovieDto>> getNowPlayingMovies() async {
    final nowPlayingResponse = await service.getNowPlayingMovies("en", 1);
    final List<MovieDto> nowPlaying = nowPlayingResponse.data.results ?? [];
    return nowPlaying;
  }

  @override
  Future<List<MovieDto>> getPopularMovies() async {
    final popularResponse = await service.getPopularMovies("en", 1);
    final List<MovieDto> popular = popularResponse.data.results ?? [];
    return popular;
  }

  @override
  Future<List<MovieDto>> getTopRatedMovies() async {
    final topRatedResponse = await service.getTopRateMovies("en", 1);
    final List<MovieDto> topRated = topRatedResponse.data.results ?? [];
    return topRated;
  }

  @override
  Future<List<MovieDto>> getUpComingMovies() async {
    final upcomingResponse = await service.getUpComingMovies("en", 1);
    final List<MovieDto> upcoming = upcomingResponse.data.results ?? [];
    return upcoming;
  }
}
