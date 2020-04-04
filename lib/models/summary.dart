import 'package:json_annotation/json_annotation.dart';

part 'summary.g.dart';

enum SummaryDirection { up, down, flat }

@JsonSerializable()
class SummaryModel {
  @JsonKey(defaultValue: SummaryDirection.flat)
  final SummaryDirection direction;
  final double diff;
  final int total;
  final int today;

  SummaryModel({this.direction, this.diff, this.total, this.today});

  factory SummaryModel.fromJson(Map<String, dynamic> json) =>
      _$SummaryModelFromJson(json);
  Map<String, dynamic> toJson() => _$SummaryModelToJson(this);
}
