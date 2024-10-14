import 'package:flutter_architecture/data/datasource/dto/movie_details_response_dto.dart';
import 'package:flutter_architecture/data/datasource/dto/movie_dto.dart';
import 'package:flutter_architecture/data/datasource/network/network_source/network_datasource.dart';

import '../service/movie_service.dart';

class NetworkDatasourceImpl extends NetworkDatasource {
  final MovieService service;

  NetworkDatasourceImpl({required this.service});

  @override
  Future<MovieDetailsResponseDto> getMovieDetails(int movieId) async {
    final response = await service.getMovieDetails(movieId, 1);
    return response.data;
  }

  @override
  Future<List<MovieDto>> getNowPlayingMovies(int page) async {
    final nowPlayingResponse = await service.getNowPlayingMovies(page);
    final List<MovieDto> nowPlaying = nowPlayingResponse.data.results ?? [];
    return nowPlaying;
  }

  @override
  Future<List<MovieDto>> getPopularMovies(int page) async {
    final popularResponse = await service.getPopularMovies(page);
    final List<MovieDto> popular = popularResponse.data.results ?? [];
    return popular;
  }

  @override
  Future<List<MovieDto>> getTopRatedMovies(int page) async {
    final topRatedResponse = await service.getTopRateMovies(page);
    final List<MovieDto> topRated = topRatedResponse.data.results ?? [];
    return topRated;
  }

  @override
  Future<List<MovieDto>> getUpComingMovies() async {
    final upcomingResponse = await service.getUpComingMovies(1);
    final List<MovieDto> upcoming = upcomingResponse.data.results ?? [];
    return upcoming;
  }

  @override
  Future<List<MovieDto>> searchMovies(int page, String query) async {
    final searchResponse = await service.searchMovies(query,page);
    final List<MovieDto> searchMovies = searchResponse.data.results ?? [];
    return searchMovies;
  }
}
