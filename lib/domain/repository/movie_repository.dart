import 'package:flutter_architecture/core/data_state/resource.dart';
import 'package:flutter_architecture/domain/model/movie.dart';
import 'package:flutter_architecture/domain/model/movie_details.dart';

abstract class MovieRepository {
  Future<Resource<bool>> syncHomeMovies();

  Stream<List<Movie>> fetchLocalMovies();

  Stream<List<Movie>> fetchFavouriteMovies();

  Future<void> updateMovie(int index, Movie movie);

  Future<Resource<MovieDetails>> getMovieDetails(int movieId);

  Future<Resource<List<Movie>>> searchMovies(int page, String query);

  Future<Resource<List<Movie>>> fetchNowPlayingAllMovies(int page);

  Future<Resource<List<Movie>>> fetchTopRateAllMovies(int page);

  Future<Resource<List<Movie>>> fetchPopularAllMovies(int page);
}
