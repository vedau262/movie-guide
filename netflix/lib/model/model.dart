import 'package:netflix/Config/ConfigBase.dart';
import 'package:netflix/Network/TypeDecodable.dart';

class Movie implements Decodable<Movie> {
  int id = 0;
  String title = '';
  String overview = '';
  String posterPath = '';
  String backdropPath = '';
  num? voteAvg;
  int? voteCount;

  @override
  Movie decode(dynamic data) {
    id = data['id'] ?? 0;
    title = data['title'] ?? '';
    overview = data['overview'] ?? '';
    posterPath = data['poster_path'] ?? '';
    backdropPath = data['backdrop_path'] ?? '';
    print(data['vote_average']);
    voteAvg = data['vote_average'];
    voteCount = data['vote_count'];
    return this;
  }

  String getPosterPath() {
    return this.posterPath!=null ? (ConfigBase.BASE_IMAGE_URL + this.posterPath.toString()) : ConfigBase.posterPathDefault;
  }

  String getBackdropPath() {
    return this.backdropPath!=null ? (ConfigBase.BASE_IMAGE_URL + this.backdropPath.toString()) : ConfigBase.backdropPathDefault;
  }
}