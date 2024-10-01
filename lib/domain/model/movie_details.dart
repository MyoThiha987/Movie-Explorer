class MovieDetails {
  String backdropPath;
  int id;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  String releaseDate;
  double voteAverage;
  int voteCount;
  List<ProductionCompany> productionCompanies;

  MovieDetails(
      {required this.backdropPath,
      required this.id,
      required this.originalTitle,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.releaseDate,
      required this.voteAverage,
      required this.voteCount,
      required this.productionCompanies});
}

class ProductionCompany {
  int id;
  String logoPath;
  String name;
  String originCountry;

  ProductionCompany(
      {required this.id,
      required this.logoPath,
      required this.name,
      required this.originCountry});
}
