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
        final topRated = await networkDataSource.getTopRatedMovies();
        final nowPlaying = await networkDataSource.getNowPlayingMovies();
        final popular = await networkDataSource.getPopularMovies();


        final u = upcoming.map((movieDto) => movieDto.toEntity(0)).toList();
        final t = topRated.map((movieDto) => movieDto.toEntity(1)).toList();
        final n = nowPlaying.map((movieDto) => movieDto.toEntity(2)).toList();
        final p = popular.map((movieDto) => movieDto.toEntity(3)).toList();
        final result = u + t + n + p;
        print("Netwrok : ${u.first.originalTitle} ${t.first.originalTitle} ${n.first.originalTitle} ${p.first.originalTitle}");


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
  Future<HomeMovies> fetchLocalMovies() async {
    final result = await localDataSource.getLocalMovies();
    final movies = result.map((movieEntity) => movieEntity.toDomain()).toList();
    return HomeMovies(
      nowPlayingMovies: movies.where((movie) => movie.movieType == 1).toList(),
      topRatedMovies: movies.where((movie) => movie.movieType == 2).toList(),
      popularMovies: movies.where((movie) => movie.movieType == 3).toList(),
      upcomingMovies: movies.where((movie) => movie.movieType == 0).toList(),
    );
  }
}
