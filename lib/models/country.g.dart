// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryModel _$CountryModelFromJson(Map<String, dynamic> json) {
  return CountryModel(
    name: json['name'] as String,
    timeline: (json['timeline'] as List)
        ?.map((e) => e == null
            ? null
            : TimelineModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  )
    ..confirmed = json['confirmed'] == null
        ? null
        : SummaryModel.fromJson(json['confirmed'] as Map<String, dynamic>)
    ..deaths = json['deaths'] == null
        ? null
        : SummaryModel.fromJson(json['deaths'] as Map<String, dynamic>)
    ..recovered = json['recovered'] == null
        ? null
        : SummaryModel.fromJson(json['recovered'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CountryModelToJson(CountryModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'timeline': instance.timeline,
      'confirmed': instance.confirmed,
      'deaths': instance.deaths,
      'recovered': instance.recovered,
    };
