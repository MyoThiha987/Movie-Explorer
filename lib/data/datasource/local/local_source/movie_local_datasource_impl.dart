import 'package:flutter_architecture/data/datasource/local/enitiy/movie_entity.dart';
import 'package:flutter_architecture/data/datasource/local/local_source/movie_local_datasource.dart';
import 'package:hive/hive.dart';

class MovieLocalDataSourceImpl extends MovieLocalDataSource {
  final Box<MovieEntity> movieBox;

  MovieLocalDataSourceImpl({required this.movieBox});

  @override
  void deleteMovies() {
    movieBox.deleteFromDisk();
  }

  @override
  List<MovieEntity> getLocalMovies() {
    return movieBox.values.toList();
  }

  @override
  void insertMovies(List<MovieEntity> movies) {
    for (var movie in movies) {
      movieBox.add(movie); // Adds each movie entity to the box.
    }
  }

  @override
  void updateMovie(int index, MovieEntity movie) {
    movieBox.putAt(index, movie);
  }
}
