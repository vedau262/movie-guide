import 'movie.dart';

class MoviesResponse {
  int? totalPages;
  int? page;
  int? totalResults;
  List<Movie>? results;
  String? error = '';

  MoviesResponse(
      {
        this.totalPages,
        this.page,
        this.totalResults,
        this.results
      }
  );

  MoviesResponse.error(this.error);

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
}