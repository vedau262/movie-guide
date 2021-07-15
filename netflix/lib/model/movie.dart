// import 'package:netflix/Base/extension/base_extension.dart';
import 'package:netflix/config/config_base.dart';
import 'package:netflix/network/TypeDecodable.dart';
import 'package:netflix/utilities.dart';

class Movie implements Decodable<Movie> {
  int? id;
  String? title;
  String? overview;
  String? posterPath;
  String? backdropPath;
  num? voteAvg;
  int? voteCount;

  @override
  Movie decode(dynamic data) {
    id = DynamicExtension(data['id']).parseToInt();
    title = DynamicExtension(data['title']).parseToString();
    overview = DynamicExtension(data['overview']).parseToString();
    posterPath = data['poster_path'];
    backdropPath = data['backdrop_path'];
    voteAvg = data['vote_average'];
    voteCount = DynamicExtension(data['vote_count']).parseToInt();
    return this;
  }

  String getPosterPath() {
    return this.posterPath!=null ? (ConfigBase.BASE_IMAGE_URL + this.posterPath.toString()) : ConfigBase.posterPathDefault;
  }

  String getBackdropPath() {
    return this.backdropPath!=null ? (ConfigBase.BASE_IMAGE_URL + this.backdropPath.toString()) : ConfigBase.backdropPathDefault;
  }
}