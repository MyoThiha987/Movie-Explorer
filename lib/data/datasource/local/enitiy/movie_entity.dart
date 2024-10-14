import 'package:hive_flutter/adapters.dart';

part 'movie_entity.g.dart';

@HiveType(typeId: 0)
class MovieEntity extends HiveObject {
  @HiveField(0)
  final String autoId;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String originalTitle;
  @HiveField(3)
  final String overview;
  @HiveField(4)
  final double popularity;
  @HiveField(5)
  final String posterPath;
  @HiveField(6)
  final String backdropPath;
  @HiveField(7)
  final String releaseDate;
  @HiveField(8)
  final double voteAverage;
  @HiveField(9)
  final int voteCount;
  @HiveField(10)
  final int movieType;
  @HiveField(11)
  final bool isFavourite;

  MovieEntity(
      {required this.autoId,
      required this.id,
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

  MovieEntity copy({
    String? autoId,
    int? id,
    String? originalTitle,
    String? overview,
    double? popularity,
    String? posterPath,
    String? backdropPath,
    String? releaseDate,
    double? voteAverage,
    int? voteCount,
    int? movieType,
    bool? isFavourite,
  }) {
    return MovieEntity(
      autoId: autoId ?? this.autoId,
      id: id ?? this.id,
      originalTitle: originalTitle ?? this.originalTitle,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      posterPath: posterPath ?? this.posterPath,
      backdropPath: backdropPath ?? this.backdropPath,
      releaseDate: releaseDate ?? this.releaseDate,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      movieType: movieType ?? this.movieType,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}
