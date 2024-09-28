import 'package:json_annotation/json_annotation.dart';

part 'movie_dto.g.dart';

@JsonSerializable()
class MovieDto {
  int? id;
  String? original_title;
  String? overview;
  double? popularity;
  String? poster_path;
  String? release_date;
  double? vote_average;
  int? vote_count;

  MovieDto(this.id, this.original_title, this.overview, this.popularity,
      this.release_date, this.poster_path, this.vote_average, this.vote_count);

  factory MovieDto.fromJson(Map<String, dynamic> json) =>
      _$MovieDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDtoToJson(this);
}
