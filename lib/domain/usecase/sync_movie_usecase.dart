import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/data_state/resource.dart';
import 'package:flutter_architecture/core/usecase/base_usecase.dart';
import 'package:flutter_architecture/domain/repository/movie_repository.dart';

class SyncMovieUseCase extends BaseUseCase<Unit, bool> {
  final MovieRepository repository;

  SyncMovieUseCase(this.repository);

  @override
  Future<Resource<bool>> execute(Unit input) async {
    return await repository.syncHomeMovies();
  }
}
