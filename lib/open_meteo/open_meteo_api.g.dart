// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_meteo_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Location _$$_LocationFromJson(Map<String, dynamic> json) => _$_Location(
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      region: json['admin1'] as String,
    );

Map<String, dynamic> _$$_LocationToJson(_$_Location instance) => <String, dynamic>{
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'admin1': instance.region,
    };

_$__LocationResults _$$__LocationResultsFromJson(Map<String, dynamic> json) => _$__LocationResults(
      results: (json['results'] as List<dynamic>).map((e) => Location.fromJson(e as Map<String, dynamic>)).toList(),
    );

Map<String, dynamic> _$$__LocationResultsToJson(_$__LocationResults instance) => <String, dynamic>{
      'results': instance.results,
    };
