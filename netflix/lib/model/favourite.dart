import 'package:hive/hive.dart';
import 'package:netflix/model/movie.dart';
part 'favourite.g.dart';

@HiveType(typeId: 1)
class Favourite extends HiveObject {

  @HiveField(0)
  Movie? movie;

  Favourite(this.movie);
}
