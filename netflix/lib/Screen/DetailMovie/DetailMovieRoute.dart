import 'package:netflix/Base/BaseRoute.dart';
import 'package:netflix/model/model.dart';

class DetailMovieRoute extends BaseRoute {
  static const String routeId = "DetailMovieRoute";
  final Movie movie;
  DetailMovieRoute(this.movie);
}