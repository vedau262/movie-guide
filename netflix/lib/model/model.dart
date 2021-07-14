import 'package:netflix/Base/extension/string_extension.dart';
import 'package:netflix/config/ConfigBase.dart';
import 'package:netflix/Network/TypeDecodable.dart';

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
    posterPath = DynamicExtension(data['poster_path']).parseToString();
    backdropPath = DynamicExtension(data['backdrop_path']).parseToString();
    voteAvg = DynamicExtension(data['vote_average']).parseToDouble();
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