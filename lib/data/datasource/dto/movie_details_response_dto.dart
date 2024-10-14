import 'package:json_annotation/json_annotation.dart';

part 'movie_details_response_dto.g.dart';

@JsonSerializable()
class MovieDetailsResponseDto {
  String? backdrop_path;
  int? id;
  String? original_title;
  String? overview;
  double? popularity;
  String? poster_path;
  String? release_date;
  double? vote_average;
  int? vote_count;
  List<ProductionCompanyDto>? production_companies;

  MovieDetailsResponseDto(
      this.backdrop_path,
      this.id,
      this.original_title,
      this.overview,
      this.popularity,
      this.poster_path,
      this.release_date,
      this.vote_average,
      this.vote_count,
      this.production_companies);

  factory MovieDetailsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsResponseDtoToJson(this);
}

@JsonSerializable()
class ProductionCompanyDto {
  int? id;

  String? logo_path;
  String? name;
  String? origin_country;

  ProductionCompanyDto(this.id, this.logo_path, this.name, this.origin_country);

  factory ProductionCompanyDto.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanyDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompanyDtoToJson(this);
}
