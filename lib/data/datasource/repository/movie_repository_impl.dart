import 'package:flutter_architecture/core/data_state/resource.dart';
import 'package:flutter_architecture/core/network/exception_handler/exception_handler.dart';
import 'package:flutter_architecture/data/datasource/network/mapper/movie_mapper.dart';
import 'package:flutter_architecture/data/datasource/network/service/movie_service.dart';
import 'package:flutter_architecture/domain/model/movie.dart';
import 'package:flutter_architecture/domain/repository/movie_repository.dart';
import '../../../core/network/connection_checker.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieService service;
  final ConnectionChecker connectionChecker;

  MovieRepositoryImpl({required this.service, required this.connectionChecker});

  @override
  Future<Resource<List<Movie>>> getPopularMovies(
      String language, int page) async {
    if (await connectionChecker.isConnected) {
      try {
        final response = await service.getPopularMovies(language, page);
        final List<Movie> movies = response.data.results?.map((movie) => movie.toDomain()).toList() ?? [];
        return Success(data: movies);
      } catch (error) {
        return Error(error: ExceptionHandler.handle(error).errorBody);
      }
    } else {
      return Error(error: ErrorType.NO_INTERNET_CONNECTION.getError());
    }
  }
}
