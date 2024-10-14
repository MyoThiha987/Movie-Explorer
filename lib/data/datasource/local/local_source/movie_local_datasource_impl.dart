import 'dart:developer';

import 'package:flutter_architecture/data/datasource/local/enitiy/movie_entity.dart';
import 'package:flutter_architecture/data/datasource/local/local_source/movie_local_datasource.dart';
import 'package:hive/hive.dart';

class MovieLocalDataSourceImpl extends MovieLocalDataSource {
  final Box<MovieEntity> movieBox;

  MovieLocalDataSourceImpl({required this.movieBox});

  @override
  Future<void> deleteMovies() async {
    await movieBox.deleteFromDisk();
  }

  @override
  Stream<List<MovieEntity>> getLocalMovies() async* {
    final initialMovies =
        movieBox.values.where((movie) => movie.isFavourite == true).toList();
    yield initialMovies..sort((a, b) => a.releaseDate.compareTo(b.releaseDate));
    ;

    final movieChanges = movieBox.watch().map((event) {
      return movieBox.values.toList()
        ..sort((a, b) => a.releaseDate.compareTo(b.releaseDate));
    });
    yield* movieChanges;
  }

  @override
  Future<void> insertMovies(List<MovieEntity> movies) async {
    final favMovies = movieBox.values
        .toList()
        .where((movies) => movies.isFavourite)
        .toList()
      ..sort((a, b) => a.id.compareTo(b.id));
    final mappedMovies = movies.map((movie) {
      if (favMovies.any((favMovie) => favMovie.id == movie.id)) {
        // If the movie is in the favorite list, copy with favorite status preserved
        return movie.copy(isFavourite: true);
      } else {
        // Otherwise, return the movie as is
        return movie;
      }
    }).toList();
    await movieBox.clear();
    final movieMap = {for (var movie in mappedMovies) movie.autoId: movie};
    await movieBox.putAll(movieMap);
  }

  @override
  Future<void> updateMovie(int index, MovieEntity movie) async {
    final moviesToUpdate =
        movieBox.values.where((existingMovie) => existingMovie.id == movie.id);
    // Update the movie using the found movie's autoId
    for (var movie in moviesToUpdate) {
      await movieBox.put(
          movie.autoId, movie.copy(isFavourite: !movie.isFavourite));
    }
  }

  @override
  Stream<List<MovieEntity>> getFavouriteMovies() async* {
    final initialMovies = movieBox.values
        .where((movie) => movie.isFavourite == true)
        .toList()
        .fold<Map<int, MovieEntity>>(
          {},
          (map, movie) {
            map[movie.id] = movie;
            return map;
          },
        )
        .values
        .toList()
      ..sort((a, b) => a.releaseDate.compareTo(b.releaseDate));

    yield initialMovies;

    final favourite = movieBox.watch().map((event) {
      return movieBox.values
          .where((movieBox) => movieBox.isFavourite == true)
          .toList()
          .fold<Map<int, MovieEntity>>(
            {},
            (map, movie) {
              map[movie.id] = movie;
              return map;
            },
          )
          .values
          .toList()
        ..sort((a, b) => a.releaseDate.compareTo(b.releaseDate));
    });

    yield* favourite;
  }
}
