import 'package:flutter_architecture/data/datasource/dto/movie_details_response_dto.dart';
import 'package:flutter_architecture/data/datasource/dto/movie_dto.dart';
import 'package:flutter_architecture/data/datasource/local/enitiy/movie_entity.dart';
import 'package:flutter_architecture/data/datasource/mapper/extensions.dart';
import 'package:flutter_architecture/domain/model/movie.dart';
import 'package:flutter_architecture/domain/model/movie_details.dart';

extension Movies on MovieDto {
  Movie toDomain(int movieType) {
    return Movie(
        id: id.orZero(),
        originalTitle: original_title.orEmpty(),
        overview: overview.orEmpty(),
        popularity: popularity.orZero(),
        releaseDate: release_date.orEmpty(),
        posterPath: poster_path.orEmpty(),
        backdropPath: backdrop_path.orEmpty(),
        voteAverage: vote_average.orZero(),
        voteCount: vote_count.orZero(),
        movieType: movieType,
        isFavourite: false);
  }
}

extension MovieModel on MovieEntity {
  Movie toDomain() {
    return Movie(
        id: id,
        originalTitle: originalTitle,
        overview: overview,
        popularity: popularity,
        releaseDate: releaseDate,
        posterPath: posterPath,
        backdropPath: backdropPath,
        voteAverage: voteAverage,
        voteCount: voteCount,
        movieType: movieType,
        isFavourite: isFavourite);
  }
}

extension MovieLocalEntity on MovieDto {
  MovieEntity toEntity(int movieType) {
    return MovieEntity(
        id: id.orZero(),
        originalTitle: original_title.orEmpty(),
        overview: overview.orEmpty(),
        popularity: popularity.orZero(),
        releaseDate: release_date.orEmpty(),
        posterPath: poster_path.orEmpty(),
        backdropPath: backdrop_path.orEmpty(),
        voteAverage: vote_average.orZero(),
        voteCount: vote_count.orZero(),
        movieType: movieType,
        isFavourite: false);
  }
}

extension MovieDetail on MovieDetailsResponseDto {
  MovieDetails toDomain() {
    return MovieDetails(
        backdropPath: backdrop_path.orEmpty(),
        id: id.orZero(),
        originalTitle: original_title.orEmpty(),
        overview: overview.orEmpty(),
        popularity: popularity.orZero(),
        posterPath: poster_path.orEmpty(),
        releaseDate: release_date.orEmpty(),
        voteAverage: vote_average.orZero(),
        voteCount: vote_count.orZero(),
        productionCompanies: production_companies
                ?.map((pc) => ProductionCompany(
                    id: pc.id.orZero(),
                    logoPath: pc.logo_path.orEmpty(),
                    name: pc.name.orEmpty(),
                    originCountry: pc.origin_country.orEmpty()))
                .toList() ??
            []);
  }
}
