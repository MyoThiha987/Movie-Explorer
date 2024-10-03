import 'package:flutter_architecture/core/data_state/resource.dart';
import 'package:flutter_architecture/domain/model/movie.dart';
import 'package:flutter_architecture/domain/model/movie_details.dart';

abstract class MovieRepository {
  Future<Resource<bool>> syncHomeMovies();

  Future<HomeMovies> fetchLocalMovies();

  Future<Resource<MovieDetails>> getMovieDetails(int movieId);

  Future<Resource<List<Movie>>> searchMovies(int page, String query);
}
