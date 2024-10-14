import 'package:dartz/dartz.dart';

import '../../core/usecase/base_usecase.dart';
import '../model/movie.dart';
import '../repository/movie_repository.dart';

class FetchFavouriteMoviesUseCase extends BaseStreamUseCase<Unit, List<Movie>> {
  final MovieRepository repository;

  FetchFavouriteMoviesUseCase(this.repository);

  @override
  Stream<List<Movie>> execute(Unit input) {
    return repository.fetchFavouriteMovies();
  }
}
