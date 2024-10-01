
import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/domain/model/movie.dart';
import 'package:flutter_architecture/domain/usecase/fetch_movies_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../di/di.dart';

part 'fetch_local_movies_usecase_provider.g.dart';

@riverpod
Future<HomeMovies> fetchLocalMovies(ref,Unit unit) async {
  final fetchMovieUseCase = instance<FetchMoviesUseCase>();
  final result = await fetchMovieUseCase.execute(unit);
  return result;
}