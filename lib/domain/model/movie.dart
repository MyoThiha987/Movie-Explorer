class Movie {
  int id;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  double voteAverage;
  int voteCount;

  Movie({required this.id,
      required this.originalTitle,
      required this.overview,
      required this.popularity,
      required this.releaseDate,
      required this.posterPath,
      required this.voteAverage,
      required this.voteCount});
}

class Failure implements Exception {
  final String message;

  @override
  String toString() {
    return message;
  }


  Failure({required this.message});
}
