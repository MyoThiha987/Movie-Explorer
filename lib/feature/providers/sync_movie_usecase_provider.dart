import 'package:dartz/dartz.dart';
import 'package:flutter_architecture/core/data_state/resource.dart';
import 'package:flutter_architecture/di/di.dart';
import 'package:flutter_architecture/domain/model/movie.dart';
import 'package:flutter_architecture/domain/usecase/sync_movie_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sync_movie_usecase_provider.g.dart';

@riverpod
Future<bool> fetchPopularMovies(ref,Unit unit) async {
  final fetchMovieUseCase = instance<SyncMovieUseCase>();
  final result = await fetchMovieUseCase.execute(unit);

  switch (result) {
    case Success():
      return result.data;
    case Error():
      throw Failure(message:result.error.message);
  }
}
