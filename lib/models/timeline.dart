import 'package:json_annotation/json_annotation.dart';

part 'timeline.g.dart';

@JsonSerializable()
class TimelineModel {
  @JsonKey(required: true)
  final DateTime date;
  @JsonKey(defaultValue: 0)
  final int confirmed;
  @JsonKey(defaultValue: 0)
  final int deaths;
  @JsonKey(defaultValue: 0)
  final int recovered;

  TimelineModel({this.date, this.confirmed, this.deaths, this.recovered});

  factory TimelineModel.fromJson(Map<String, dynamic> json) =>
      _$TimelineModelFromJson(json);
  Map<String, dynamic> toJson() => _$TimelineModelToJson(this);
}
