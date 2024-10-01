import 'package:flutter_architecture/domain/model/movie_details.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/data_state/resource.dart';
import '../../di/di.dart';
import '../../domain/model/movie.dart';
import '../../domain/usecase/fetch_movie_details_usecase.dart';

part 'fetch_movie_details_usecase_provider.g.dart';

@riverpod
Future<MovieDetails> fetchMovieDetails(ref, int movieId) async {
  final fetchMovieDetailUseCase = instance<FetchMovieDetailsUseCase>();
  final result = await fetchMovieDetailUseCase.execute(movieId);

  switch (result) {
    case Success():
      return result.data;
    case Error():
      throw Failure(message: result.error.message);
  }
}
