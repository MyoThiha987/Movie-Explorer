import 'dart:async';
import 'package:flutter_architecture/core/data_state/resource.dart';
import 'package:flutter_architecture/core/network/exception_handler/exception_handler.dart';
import 'package:flutter_architecture/data/datasource/local/local_source/movie_local_datasource.dart';
import 'package:flutter_architecture/data/datasource/mapper/movie_mapper.dart';
import 'package:flutter_architecture/data/datasource/network/network_source/network_datasource.dart';
import 'package:flutter_architecture/domain/model/movie.dart';
import 'package:flutter_architecture/domain/model/movie_details.dart';
import 'package:flutter_architecture/domain/repository/movie_repository.dart';
import '../../../core/network/connection_checker.dart';

class MovieRepositoryImpl extends MovieRepository {
  final ConnectionChecker connectionChecker;
  final NetworkDatasource networkDataSource;
  final MovieLocalDataSource localDataSource;

  MovieRepositoryImpl(
      {required this.connectionChecker,
      required this.networkDataSource,
      required this.localDataSource});

  @override
  Future<Resource<bool>> syncHomeMovies() async {
    if (await connectionChecker.isConnected) {
      try {
        final upcoming = await networkDataSource.getUpComingMovies();
        final topRated = await networkDataSource.getTopRatedMovies(1);
        final nowPlaying = await networkDataSource.getNowPlayingMovies(1);
        final popular = await networkDataSource.getPopularMovies(1);
        final u = upcoming.map((movieDto) => movieDto.toEntity(0)).toList();
        final t = topRated.map((movieDto) => movieDto.toEntity(2)).toList();
        final n = nowPlaying.map((movieDto) => movieDto.toEntity(1)).toList();
        final p = popular.map((movieDto) => movieDto.toEntity(3)).toList();
        final result = u + t + n + p;
        localDataSource.insertMovies(result);
        return Success(data: true);
      } catch (error) {
        return Error(error: ExceptionHandler.handle(error).errorBody);
      }
    } else {
      return Error(error: ErrorType.NO_INTERNET_CONNECTION.getError());
    }
  }

  @override
  Stream<List<Movie>> fetchLocalMovies() async* {
    final data = localDataSource.getLocalMovies();
    yield* data.map((moviesEntityList) =>
        moviesEntityList.map((movieEntity) => movieEntity.toDomain()).toList());
  }

  @override
  Future<Resource<MovieDetails>> getMovieDetails(int movieId) async {
    if (await connectionChecker.isConnected) {
      try {
        final response = await networkDataSource.getMovieDetails(movieId);
        return Success(data: response.toDomain());
      } catch (error) {
        return Error(error: ExceptionHandler.handle(error).errorBody);
      }
    } else {
      return Error(error: ErrorType.NO_INTERNET_CONNECTION.getError());
    }
  }

  @override
  Future<Resource<List<Movie>>> searchMovies(int page, String query) async {
    if (await connectionChecker.isConnected) {
      try {
        final response = await networkDataSource.searchMovies(page, query);
        final searchMovies =
            response.map((movieDto) => movieDto.toDomain(0)).toList();
        return Success(data: searchMovies);
      } catch (error) {
        return Error(error: ExceptionHandler.handle(error).errorBody);
      }
    } else {
      return Error(error: ErrorType.NO_INTERNET_CONNECTION.getError());
    }
  }

  @override
  Future<void> updateMovie(int index, Movie movie) async {
    await localDataSource.updateMovie(index, movie.toEntity());
  }

  @override
  Stream<List<Movie>> fetchFavouriteMovies() async* {
    final data = localDataSource.getFavouriteMovies();
    yield* data.map((moviesEntityList) {
      return moviesEntityList
          .map((movieEntity) => movieEntity.toDomain())
          .toList();
    });
  }

  @override
  Future<Resource<List<Movie>>> fetchNowPlayingAllMovies(int page) async {
    if (await connectionChecker.isConnected) {
      try {
        final nowPlayingSource = await networkDataSource.getNowPlayingMovies(page);
        final nowPlayingMovies =
            nowPlayingSource.map((movieDto) => movieDto.toDomain(1)).toList();
        return Success(data: nowPlayingMovies);
      } catch (error) {
        return Error(error: ExceptionHandler.handle(error).errorBody);
      }
    } else {
      return Error(error: ErrorType.NO_INTERNET_CONNECTION.getError());
    }
  }

  @override
  Future<Resource<List<Movie>>> fetchPopularAllMovies(int page) async {
    if (await connectionChecker.isConnected) {
      try {
        final popularMovieSource = await networkDataSource.getPopularMovies(page);
        final popularMovies =
            popularMovieSource.map((movieDto) => movieDto.toDomain(3)).toList();
        return Success(data: popularMovies);
      } catch (error) {
        return Error(error: ExceptionHandler.handle(error).errorBody);
      }
    } else {
      return Error(error: ErrorType.NO_INTERNET_CONNECTION.getError());
    }
  }

  @override
  Future<Resource<List<Movie>>> fetchTopRateAllMovies(int page) async {
    if (await connectionChecker.isConnected) {
      try {
        final topRatedSource = await networkDataSource.getTopRatedMovies(page);
        final topRatedMovies =
            topRatedSource.map((movieDto) => movieDto.toDomain(2)).toList();
        return Success(data: topRatedMovies);
      } catch (error) {
        return Error(error: ExceptionHandler.handle(error).errorBody);
      }
    } else {
      return Error(error: ErrorType.NO_INTERNET_CONNECTION.getError());
    }
  }
}
