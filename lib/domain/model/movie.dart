class Movie {
  int id;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String backdropPath;
  String releaseDate;
  double voteAverage;
  int voteCount;
  int movieType;
  bool isFavourite;

  Movie(
      {required this.id,
      required this.originalTitle,
      required this.overview,
      required this.popularity,
      required this.releaseDate,
      required this.posterPath,
      required this.backdropPath,
      required this.voteAverage,
      required this.voteCount,
      required this.movieType,
      required this.isFavourite});
}

class HomeMovies {
  List<Movie> nowPlayingMovies;
  List<Movie> topRatedMovies;
  List<Movie> popularMovies;
  List<Movie> upcomingMovies;

  HomeMovies(
      {required this.nowPlayingMovies,
      required this.topRatedMovies,
      required this.popularMovies,
      required this.upcomingMovies});
}

class Failure implements Exception {
  final String message;

  @override
  String toString() {
    return message;
  }

  Failure({required this.message});
}
