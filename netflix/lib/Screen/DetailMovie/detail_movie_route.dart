import 'package:netflix/Base/BaseRoute.dart';
import 'package:netflix/model/movie.dart';

class DetailMovieRoute extends BaseRoute {
  static const String routeId = "DetailMovieRoute";
  final Movie movie;
  DetailMovieRoute(this.movie);
}