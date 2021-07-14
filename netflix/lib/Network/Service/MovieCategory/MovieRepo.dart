import 'package:netflix/config/Result.dart';
import 'package:netflix/model/home_category.dart';

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