
import 'dart:convert';
import 'package:http/http.dart';
import 'package:netflix/Config/Result.dart';
import 'package:netflix/Model/HomeCategory.dart';
import 'package:netflix/Model/Movie.dart';
import 'package:netflix/Model/trailer_model.dart';
import 'package:netflix/Network/APIResponse.dart';
import 'package:netflix/Network/Service/MovieCategory/MovieTarget.dart';

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