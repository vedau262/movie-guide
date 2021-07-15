import 'package:netflix/base/base_route.dart';
import 'package:netflix/model/movie.dart';

class DetailMovieRoute extends BaseRoute {
  static const String routeId = "DetailMovieRoute";
  final Movie movie;
  DetailMovieRoute(this.movie);
}