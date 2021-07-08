import 'package:movie_guide/strings/strings.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {

  @JsonKey(name: 'vote_average')
  double? voteAverage;

  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'vote_count')
  int? voteCount;

  @JsonKey(name: 'release_date')
  String? releaseDate;

  @JsonKey(name: 'adult')
  bool? adult;

  @JsonKey(name: 'backdrop_path')
  String? backdropPath;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'genre_ids')
  List<int>? genreIds;

  @JsonKey(name: 'popularity')
  double? popularity;

  @JsonKey(name: 'original_language')
  String? originalLanguage;

  @JsonKey(name: 'original_title')
  String? originalTitle;

  @JsonKey(name: 'poster_path')
  String? posterPath;

  @JsonKey(name: 'overview')
  String? overview;

  @JsonKey(name: 'video')
  bool? video;

  Movie(
      {this.voteAverage,
        this.id,
        this.voteCount,
        this.releaseDate,
        this.adult,
        this.backdropPath,
        this.title,
        this.popularity,
        this.originalLanguage,
        this.originalTitle,
        this.posterPath,
        this.overview,
        this.video
      });

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);

  String getPosterPath() {
    return this.posterPath!=null ? (AppStrings.imageHostUrl + this.posterPath.toString()) : AppStrings.posterPathDefault;
  }

  String getBackdropPath() {
    return this.backdropPath!=null ? (AppStrings.imageHostUrl + this.backdropPath.toString()) : AppStrings.backdropPathDefault;
  }


}
