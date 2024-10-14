import 'package:flutter_architecture/domain/model/movie.dart';

import '../../core/data_state/resource.dart';
import '../../core/usecase/base_usecase.dart';
import '../repository/movie_repository.dart';

class FetchNowPlayingMovieUseCase extends BaseUseCase<int, List<Movie>> {
  final MovieRepository repository;

  FetchNowPlayingMovieUseCase(this.repository);

  @override
  Future<Resource<List<Movie>>> execute(int input) async {
    return await repository.fetchNowPlayingAllMovies(input);
  }
}