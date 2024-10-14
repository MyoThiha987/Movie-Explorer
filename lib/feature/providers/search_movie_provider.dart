import 'dart:async';

import 'package:flutter_architecture/domain/model/movie.dart';
import 'package:flutter_architecture/domain/usecase/search_movies_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/data_state/resource.dart';
import '../../di/di.dart';

part 'search_movie_provider.g.dart';

@riverpod
class SearchText extends _$SearchText {
  Timer? _debounceTimer;

  @override
  String build() {
    ref.onDispose(() {
      _debounceTimer?.cancel();
    });
    return '';
  }

  String updateSearchText(String search) {
    if (_debounceTimer != null) {
      _debounceTimer!.cancel();
    }
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      state = search;
    });

    return state;
  }
}

@riverpod
Future<List<Movie>> searchMovies(ref, SearchMovieRequestParams params) async {
  final searchMovieUseCase = instance<SearchMoviesUseCase>();

  final result = await searchMovieUseCase.execute(SearchMovieRequestParams(
      page: params.page, query: params.query));
  switch (result) {
    case Success():
      return result.data;
    case Error():
      throw Failure(message: result.error.message);
  }
}
