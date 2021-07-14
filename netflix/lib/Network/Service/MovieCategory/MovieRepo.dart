

import 'package:netflix/Config/Result.dart';
import 'package:netflix/Model/HomeCategory.dart';

import 'MovieService.dart';

class MovieRepo {
  MovieService service = MovieService();

  Stream<Result> getListMovie(HomeCategory category) {
    return Stream.fromFuture(service.getListMovie(category));
  }

  Stream<Result> getListTrailerMovie(int movieId) {
    return Stream.fromFuture(service.getListTrailerMovie(movieId));
  }

  MovieRepo(){}
}