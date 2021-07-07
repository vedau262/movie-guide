import 'dart:convert';

import 'package:movie_guide/bloc/movie/movie_state.dart';
import 'package:movie_guide/data/model/movies_response.dart';
import 'package:movie_guide/data/model/movie.dart';
import 'package:http/http.dart' as http;
import 'package:movie_guide/strings/strings.dart';

abstract class MoviesRepository {
  Future<MoviesResponse> getMovies(String title, String link, int page);
  Future<MoviesResponse> getPopularMovies();
  Future<MoviesResponse> getUpcomingMovies();
}

class MoviesRepositoryImpl implements MoviesRepository {

  @override
  Future<MoviesResponse> getPopularMovies() async {
    var response = await http.get(Uri.parse(AppStrings.popularMoviesUrl));
    if (response.statusCode == 200) {
      print("response.body ${response.body}");
      var data = json.decode(response.body);

      print("data $data");
      MoviesResponse moviesResponse = MoviesResponse.fromJson(data);
        return moviesResponse;
    } else {
      throw Exception();
    }
  }

  @override
  Future<MoviesResponse> getUpcomingMovies() async {
    var response = await http.get(Uri.parse(AppStrings.upcomingMoviesUrl));
    if (response.statusCode == 200) {
      print("response.body ${response.body}");
      var data = json.decode(response.body);

      print("data $data");
      MoviesResponse moviesResponse = MoviesResponse.fromJson(data);
      return moviesResponse;
    } else {
      throw Exception();
    }
  }

  @override
  Future<MoviesResponse> getMovies(String title, String link, int page) async {
    var response = await http.get(Uri.parse(link + page.toString()));
    if (response.statusCode == 200) {
      // print("response.body ${response.body}");
      var data = json.decode(response.body);

      MoviesResponse moviesResponse = MoviesResponse.fromJson(data);
      moviesResponse.title =title;
      moviesResponse.page = page + 1;
      moviesResponse.link =link;
      moviesResponse.status = PostStatus.success;
      return moviesResponse;
    } else {
      throw Exception();
    }
  }
}