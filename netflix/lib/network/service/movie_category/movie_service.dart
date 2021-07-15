
import 'dart:convert';
import 'package:http/http.dart';
import 'package:netflix/config/result.dart';
import 'package:netflix/model/home_category.dart';
import 'package:netflix/model/movie.dart';
import 'package:netflix/model/trailer.dart';
import 'package:netflix/network/APIResponse.dart';
import 'package:netflix/network/service/movie_category/movie_target.dart';

import '../../APIClient.dart';
import '../../APIRouteConfigurable.dart';
class MovieService {
  final client = APIClient();

  Future<Result> getListMovie(HomeCategory category) async {
    Router router = Router(Target(null, category.path(), APIMethod.get));
    var result = await client.request<APIListResponse<Movie>>(
        route: router,
        create: () => APIListResponse(create: () => Movie())
    );
    return result;
  }

  Future<Result> getListTrailerMovie(int movieId) async {
      Router router = Router(Target(null, "movie/$movieId/videos", APIMethod.get));
      var result = await client.request<APIListTrailerResponse<TrailerModel>>(
          route: router,
          create: () => APIListTrailerResponse(create: () => TrailerModel())
      );
      return result;
  }
}