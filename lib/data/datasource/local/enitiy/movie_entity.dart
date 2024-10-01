import 'package:hive_flutter/adapters.dart';
part 'movie_entity.g.dart';

@HiveType(typeId: 0)
class MovieEntity {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String originalTitle;
  @HiveField(2)
  final String overview;
  @HiveField(3)
  final double popularity;
  @HiveField(4)
  final String posterPath;
  @HiveField(5)
  final String backdropPath;
  @HiveField(6)
  final String releaseDate;
  @HiveField(7)
  final double voteAverage;
  @HiveField(8)
  final int voteCount;
  @HiveField(9)
  final int movieType;
  @HiveField(10)
  final bool isFavourite;

  MovieEntity(
      {required this.id,
      required this.originalTitle,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.backdropPath,
      required this.releaseDate,
      required this.voteAverage,
      required this.voteCount,
      required this.movieType,
      required this.isFavourite});
}
