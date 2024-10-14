import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../di/di.dart';
import '../../domain/model/movie.dart';
import '../../domain/usecase/fetch_favourite_movies_usecase.dart';

part 'favourite_movie_provider.g.dart';

@riverpod
Stream<List<Movie>> fetchFavouriteMovies(ref, Unit unit) {
  final fetchMovieUseCase = instance<FetchFavouriteMoviesUseCase>();
  final result = fetchMovieUseCase.execute(unit);
  return result;
}
