import 'package:json_annotation/json_annotation.dart';
import 'package:movie_guide/bloc/movie/movie_state.dart';
import 'movie.dart';

part 'movies_response.g.dart';

@JsonSerializable()
class MoviesResponse {
  String? title;
  String? link;


  @JsonKey(name: 'total_pages')
  int? totalPages;

  int? page=1;

  @JsonKey(name: 'total_results')
  int? totalResults = 100;

  List<Movie>? results;
  LoadingStatus? status = LoadingStatus.initial;

  MoviesResponse(
      {
        this.title,
        this.link,
        this.totalPages,
        this.page,
        this.totalResults,
        this.results,
        this.status
      }
  );

  factory MoviesResponse.fromJson(Map<String, dynamic> json) => _$MoviesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MoviesResponseToJson(this);

  List<Movie> getResult() {
    List<Movie> list = new List.empty();
    if (results!=null) {
      return results!;
    } else {
      return list;
    }
  }

  int getPage(){
    if (page!=null) {
      return page!;
    } else {
      return 1;
    }
  }

  int getTotalPage(){
    if (totalPages!=null) {
      return totalPages!;
    } else {
      return 0;
    }
  }
}