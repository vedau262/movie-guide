import 'package:netflix/network/TypeDecodable.dart';

class TrailerModel implements Decodable<TrailerModel> {
  String? id;
  String? iso_639_1;
  String? iso_3166_1;
  String? key;
  String? name;
  String? site;
  int? size;
  String? type;

 /* TrailerModel(
    {
      this.id,
      this.iso_639_1,
      this.iso_3166_1,
      this.key,
      this.name,
      this.site,
      this.size,
      this.type
    });*/
  
  /*TrailerModel(result) {
    id = result['id'];
    iso_639_1 = result['iso_639_1'];
    iso_3166_1 = result['iso_3166_1'];
    key = result['key'];
    name = result['name'];
    site = result['site'];
    size = result['size'];
    type = result['type'];
  }*/

  @override
  TrailerModel decode(data) {
    id = data['id'];
    iso_639_1 = data['iso_639_1'];
    iso_3166_1 = data['iso_3166_1'];
    key = data['key'];
    name = data['name'];
    site = data['site'];
    size = data['size'];
    type = data['type'];
    return this;
  }

  // factory TrailerModel.fromJson(Map<String, dynamic> json)
  // => _$TrailerModelFromJson(json);
  //
  // Map<String, dynamic> toJson()
  // => _$TrailerModelToJson(this);

}