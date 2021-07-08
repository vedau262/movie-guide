// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoviesResponse _$MoviesResponseFromJson(Map<String, dynamic> json) {
  return MoviesResponse(
    title: json['title'] as String?,
    link: json['link'] as String?,
    totalPages: json['total_pages'] as int?,
    page: json['page'] as int?,
    totalResults: json['total_results'] as int?,
    results: (json['results'] as List<dynamic>?)
        ?.map((e) => Movie.fromJson(e as Map<String, dynamic>))
        .toList(),
    status: _$enumDecodeNullable(_$LoadingStatusEnumMap, json['status']),
  );
}

Map<String, dynamic> _$MoviesResponseToJson(MoviesResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'link': instance.link,
      'total_pages': instance.totalPages,
      'page': instance.page,
      'total_results': instance.totalResults,
      'results': instance.results,
      'status': _$LoadingStatusEnumMap[instance.status],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$LoadingStatusEnumMap = {
  LoadingStatus.initial: 'initial',
  LoadingStatus.success: 'success',
  LoadingStatus.failure: 'failure',
};
