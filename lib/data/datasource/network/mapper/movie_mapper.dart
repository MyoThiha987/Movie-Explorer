import 'package:flutter_architecture/data/datasource/dto/movie_dto.dart';
import 'package:flutter_architecture/data/datasource/network/mapper/extensions.dart';
import 'package:flutter_architecture/domain/model/movie.dart';

extension Movies on MovieDto {
  Movie toDomain() {
    return Movie(
        id: id.orZero(),
        originalTitle: original_title.orEmpty(),
        overview: overview.orEmpty(),
        popularity: popularity.orZero(),
        releaseDate: release_date.orEmpty(),
        posterPath: poster_path.orEmpty(),
        voteAverage: vote_average.orZero(),
        voteCount: vote_count.orZero());
  }
}
