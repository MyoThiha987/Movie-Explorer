import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/data_state/resource.dart';
import 'package:flutter_architecture/di/di.dart';
import 'package:flutter_architecture/domain/model/movie.dart';
import 'package:flutter_architecture/domain/usecase/sync_movie_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/usecase/fetch_movies_usecase.dart';
import '../../domain/usecase/update_movie_usecase.dart';

part 'home_movie_provider.g.dart';

@riverpod
Future<bool> syncHomeMovies(SyncHomeMoviesRef ref, Unit unit) async {
  final fetchMovieUseCase = instance<SyncMovieUseCase>();
  final result = await fetchMovieUseCase.execute(unit);
  switch (result) {
    case Success():
      return result.data;
    case Error():
      throw Failure(message: result.error.message);
  }
}

@riverpod
Stream<List<Movie>> fetchHomeMovies(ref, Unit unit) {
  final fetchMovieUseCase = instance<FetchMoviesUseCase>();
  final result =  fetchMovieUseCase.execute(unit);
  return result;
}

@riverpod
Future<void> favouriteMovie(FavouriteMovieRef ref, int index,Movie movie) async{
  final updateMovieUseCase = instance<UpdateMovieUseCase>();
  await updateMovieUseCase.execute((index,movie));
}
