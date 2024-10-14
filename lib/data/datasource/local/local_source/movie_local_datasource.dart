
import '../enitiy/movie_entity.dart';

abstract class MovieLocalDataSource {
  Stream<List<MovieEntity>> getLocalMovies();
  Stream<List<MovieEntity>> getFavouriteMovies();
  Future<void> insertMovies(List<MovieEntity> movies);
  Future<void> deleteMovies();
  Future<void> updateMovie(int index,MovieEntity movie);
}