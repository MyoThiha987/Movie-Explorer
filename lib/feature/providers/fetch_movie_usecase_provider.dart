import 'package:flutter_architecture/core/data_state/resource.dart';
import 'package:flutter_architecture/di/di.dart';
import 'package:flutter_architecture/domain/model/movie.dart';
import 'package:flutter_architecture/domain/usecase/fetch_movie_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_movie_usecase_provider.g.dart';

@riverpod
Future<List<Movie>> fetchPopularMovies(ref, int page) async {
  final fetchMovieUseCase = instance<FetchMovieUseCase>();
  final result = await fetchMovieUseCase.execute(page);

  switch (result) {
    case Success():
      return result.data;
    case Error():
      throw Failure(message:result.error.message);
  }
}
