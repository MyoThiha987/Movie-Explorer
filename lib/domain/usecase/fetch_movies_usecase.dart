import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/domain/model/movie.dart';
import '../../core/usecase/base_usecase.dart';
import '../repository/movie_repository.dart';

class FetchMoviesUseCase extends BaseStreamUseCase<Unit, List<Movie>> {
  final MovieRepository repository;

  FetchMoviesUseCase(this.repository);

  @override
  Stream<List<Movie>> execute(Unit input) {
    return repository.fetchLocalMovies();
  }
}
