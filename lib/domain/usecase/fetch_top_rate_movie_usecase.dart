import '../../core/data_state/resource.dart';
import '../../core/usecase/base_usecase.dart';
import '../model/movie.dart';
import '../repository/movie_repository.dart';

class FetchTopRateMovieUseCase extends BaseUseCase<int, List<Movie>> {
  final MovieRepository repository;

  FetchTopRateMovieUseCase(this.repository);

  @override
  Future<Resource<List<Movie>>> execute(int input) async {
    return await repository.fetchTopRateAllMovies(input);
  }
}