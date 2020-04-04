// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SummaryModel _$SummaryModelFromJson(Map<String, dynamic> json) {
  return SummaryModel(
    direction:
        _$enumDecodeNullable(_$SummaryDirectionEnumMap, json['direction']) ??
            SummaryDirection.flat,
    diff: (json['diff'] as num)?.toDouble(),
    total: json['total'] as int,
    today: json['today'] as int,
  );
}

Map<String, dynamic> _$SummaryModelToJson(SummaryModel instance) =>
    <String, dynamic>{
      'direction': _$SummaryDirectionEnumMap[instance.direction],
      'diff': instance.diff,
      'total': instance.total,
      'today': instance.today,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$SummaryDirectionEnumMap = {
  SummaryDirection.up: 'up',
  SummaryDirection.down: 'down',
  SummaryDirection.flat: 'flat',
};
