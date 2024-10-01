import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/domain/model/movie.dart';
import '../../core/usecase/base_usecase.dart';
import '../repository/movie_repository.dart';

class FetchMoviesUseCase extends BaseNormalUseCase<Unit, HomeMovies> {
  final MovieRepository repository;

  FetchMoviesUseCase(this.repository);

  @override
  Future<HomeMovies> execute(Unit input) async {
    return await repository.fetchLocalMovies();
  }
}
