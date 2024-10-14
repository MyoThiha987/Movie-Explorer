import 'package:flutter_architecture/core/data_state/resource.dart';
import 'package:flutter_architecture/domain/model/movie.dart';
import 'package:flutter_architecture/domain/usecase/fetch_now_playing_movie_usecase.dart';
import 'package:flutter_architecture/domain/usecase/fetch_popular_movie_usecase.dart';
import 'package:flutter_architecture/domain/usecase/fetch_top_rate_movie_usecase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../di/di.dart';

part 'see_more_movie_provider.g.dart';

@riverpod
Future<List<Movie>> fetchSeeMoreMovies(ref, int page, int movieType) async {
  final fetchNowPlayingMovieUseCase = instance<FetchNowPlayingMovieUseCase>();
  final fetchTopRateMovieUseCase = instance<FetchTopRateMovieUseCase>();
  final fetchPopularMovieUseCase = instance<FetchPopularMovieUseCase>();
  Resource<List<Movie>> result;

  switch (movieType) {
    case 2:
      result = await fetchTopRateMovieUseCase.execute(page);
      break;
    case 3:
      result = await fetchPopularMovieUseCase.execute(page);
      break;
    default:
      result = await fetchNowPlayingMovieUseCase.execute(page);
      break;
  }

  switch (result) {
    case Success():
      return result.data;
    case Error():
      throw Failure(message: result.error.message);
  }
}
