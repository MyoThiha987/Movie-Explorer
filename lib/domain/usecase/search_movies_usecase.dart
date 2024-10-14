import 'package:flutter_architecture/core/data_state/resource.dart';

import '../../core/usecase/base_usecase.dart';
import '../model/movie.dart';
import '../repository/movie_repository.dart';

class SearchMoviesUseCase extends BaseUseCase<SearchMovieRequestParams, List<Movie>> {
  final MovieRepository repository;

  SearchMoviesUseCase(this.repository);

  @override
  Future<Resource<List<Movie>>> execute(SearchMovieRequestParams input) async{
    return  await repository.searchMovies(input.page, input.query);
  }
}
