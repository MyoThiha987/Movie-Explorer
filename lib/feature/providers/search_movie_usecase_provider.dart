import 'package:flutter_architecture/domain/model/movie.dart';
import 'package:flutter_architecture/domain/usecase/search_movies_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/data_state/resource.dart';
import '../../di/di.dart';

part 'search_movie_usecase_provider.g.dart';

@riverpod
Future<List<Movie>> searchMovies(ref, SearchMovieRequestParams params) async {
  final searchMovieUseCase = instance<SearchMoviesUseCase>();

  final result = await searchMovieUseCase.execute(SearchMovieRequestParams(
      page: params.page, query: params.query));
  switch (result) {
    case Success():
      print("Success ${result.data}");
      return result.data;
    case Error():
      throw Failure(message: result.error.message);
  }
}
