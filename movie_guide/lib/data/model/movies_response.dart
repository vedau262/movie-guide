import 'package:movie_guide/bloc/movie/movie_state.dart';

import 'movie.dart';

class MoviesResponse {
  String? title;
  String? link;
  int? totalPages;
  int? page=1;
  int? totalResults = 100;
  List<Movie>? results;
  PostStatus? status = PostStatus.initial;

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

  MoviesResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalPages = json['total_pages'] ;

    totalResults = json['total_results'] ;
    if (json['results'] != null) {
      results = [];
      json['results'].forEach((v) {
        results?.add(new Movie.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['totalPages'] = this.totalPages;
    data['total_results'] = this.totalResults;
    if (this.results != null) {
       data['results'] = this.results?.map((movies) => movies.toJson()).toList();
    }
    return data;
  }

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
      return 0;
    }
  }
}