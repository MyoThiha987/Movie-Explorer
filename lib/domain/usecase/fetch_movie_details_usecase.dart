import 'package:flutter_architecture/core/data_state/resource.dart';
import 'package:flutter_architecture/core/usecase/base_usecase.dart';
import 'package:flutter_architecture/domain/model/movie_details.dart';
import 'package:flutter_architecture/domain/repository/movie_repository.dart';

class FetchMovieDetailsUseCase implements BaseUseCase<int, MovieDetails> {
  final MovieRepository repository;

  FetchMovieDetailsUseCase(this.repository);

  @override
  Future<Resource<MovieDetails>> execute(int input) async {
    return await repository.getMovieDetails(input);
  }
}
