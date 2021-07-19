// import 'package:netflix/Base/extension/base_extension.dart';
import 'package:hive/hive.dart';
import 'package:netflix/config/config_base.dart';
import 'package:netflix/network/TypeDecodable.dart';
import 'package:netflix/utilities.dart';
part 'movie.g.dart';
@HiveType(typeId: 3)
class Movie implements Decodable<Movie> {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? overview;
  @HiveField(3)
  String? posterPath;
  @HiveField(4)
  String? backdropPath;
  @HiveField(5)
  num? voteAvg;
  @HiveField(6)
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
  
  int indexOnList(List<Movie> list){
    int result = -1;
    for(Movie element in list){
      if(element.title==this.title && element.id==id) {
        result = list.indexOf(element);
        break;
      }
    }

    return result;
  }
}