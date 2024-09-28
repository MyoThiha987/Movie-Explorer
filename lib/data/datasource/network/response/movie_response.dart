import 'package:flutter_architecture/data/datasource/dto/movie_dto.dart';
import 'package:flutter_architecture/domain/model/movie.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_response.g.dart';

@JsonSerializable()
class MovieResponseDto {
  int? page;
  int? total_pages;
  String? message;
  List<MovieDto>? results;

  MovieResponseDto({this.page, this.total_pages, this.message, this.results});

  factory MovieResponseDto.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MovieResponseDtoToJson(this);

}