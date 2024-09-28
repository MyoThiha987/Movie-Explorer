import 'package:flutter_architecture/core/data_state/resource.dart';
import 'package:flutter_architecture/core/usecase/base_usecase.dart';
import 'package:flutter_architecture/domain/model/movie.dart';
import 'package:flutter_architecture/domain/repository/movie_repository.dart';

class FetchMovieUseCase extends BaseUseCase<int, List<Movie>> {
  final MovieRepository repository;

  FetchMovieUseCase(this.repository);

  @override
  Future<Resource<List<Movie>>> execute(int page) {
    return repository.getPopularMovies("en", page);
  }
}
