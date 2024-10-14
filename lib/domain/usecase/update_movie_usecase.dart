import '../../core/usecase/base_usecase.dart';
import '../model/movie.dart';
import '../repository/movie_repository.dart';

class UpdateMovieUseCase extends BaseNormalUseCase<(int, Movie), void> {
  final MovieRepository repository;

  UpdateMovieUseCase(this.repository);

  @override
  Future<void> execute((int, Movie) input) async {
    return await repository.updateMovie(input.$1, input.$2);
  }
}
