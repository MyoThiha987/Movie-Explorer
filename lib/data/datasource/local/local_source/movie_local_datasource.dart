
import '../enitiy/movie_entity.dart';

abstract class MovieLocalDataSource {
  List<MovieEntity> getLocalMovies();
  void insertMovies(List<MovieEntity> movies);
  void deleteMovies();
  void updateMovie(int index,MovieEntity movie);
}