import 'package:movie_guide/strings/strings.dart';

class Movie {
  double? voteAverage;
  int? id;
  int? voteCount;
  String? releaseDate;
  bool? adult;
  String? backdropPath;
  String? title;
  List<int>? genreIds;
  double? popularity;
  String? originalLanguage;
  String? originalTitle;
  String? posterPath;
  String? overview;
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
        this.video});

  Movie.wtf(this.id);

  Movie.fromJson(Map<String, dynamic> json) {
    voteAverage = json['vote_average'].toDouble();
    id = json['id'];
    voteCount = json['vote_count'];
    releaseDate = json['release_date'];
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    title = json['title'];
    genreIds = json['genre_ids'].cast<int>();
    popularity = json['popularity'] as double;
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    posterPath = json['poster_path'];
    overview = json['overview'];
    video = json['video'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['vote_average'] = this.voteAverage;
    data['id'] = this.id;
    data['vote_count'] = this.voteCount;
    data['release_date'] = this.releaseDate;
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['title'] = this.title;
    data['genre_ids'] = this.genreIds;
    data['popularity'] = this.popularity;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['poster_path'] = this.posterPath;
    data['overview'] = this.overview;
    data['video'] = this.video;
    return data;
  }

  String getPosterPath() {
    return this.posterPath!=null ? (AppStrings.imageHostUrl + this.posterPath.toString()) : AppStrings.posterPathDefault;
  }

  String getBackdropPath() {
    return this.backdropPath!=null ? (AppStrings.imageHostUrl + this.backdropPath.toString()) : AppStrings.backdropPathDefault;
  }


}
