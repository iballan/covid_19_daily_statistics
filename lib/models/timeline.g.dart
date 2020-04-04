// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimelineModel _$TimelineModelFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['date']);
  return TimelineModel(
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    confirmed: json['confirmed'] as int ?? 0,
    deaths: json['deaths'] as int ?? 0,
    recovered: json['recovered'] as int ?? 0,
  );
}

Map<String, dynamic> _$TimelineModelToJson(TimelineModel instance) =>
    <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'confirmed': instance.confirmed,
      'deaths': instance.deaths,
      'recovered': instance.recovered,
    };
