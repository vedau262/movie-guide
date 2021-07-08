// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
    voteAverage: (json['vote_average'] as num?)?.toDouble(),
    id: json['id'] as int?,
    voteCount: json['vote_count'] as int?,
    releaseDate: json['release_date'] as String?,
    adult: json['adult'] as bool?,
    backdropPath: json['backdrop_path'] as String?,
    title: json['title'] as String?,
    popularity: (json['popularity'] as num?)?.toDouble(),
    originalLanguage: json['original_language'] as String?,
    originalTitle: json['original_title'] as String?,
    posterPath: json['poster_path'] as String?,
    overview: json['overview'] as String?,
    video: json['video'] as bool?,
  )..genreIds =
      (json['genre_ids'] as List<dynamic>?)?.map((e) => e as int).toList();
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'vote_average': instance.voteAverage,
      'id': instance.id,
      'vote_count': instance.voteCount,
      'release_date': instance.releaseDate,
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'title': instance.title,
      'genre_ids': instance.genreIds,
      'popularity': instance.popularity,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'poster_path': instance.posterPath,
      'overview': instance.overview,
      'video': instance.video,
    };
