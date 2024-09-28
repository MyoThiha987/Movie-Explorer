import 'package:flutter_architecture/core/data_state/resource.dart';
import 'package:flutter_architecture/domain/model/movie.dart';

abstract class MovieRepository{
  Future<Resource<List<Movie>>> getPopularMovies(String language , int page);
}