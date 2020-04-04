import 'package:covid19/models/index.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

@JsonSerializable()
class CountryModel {
  final String name;
  final List<TimelineModel> timeline;
  SummaryModel _confirmed;
  SummaryModel _deaths;
  SummaryModel _recovered;

  CountryModel({this.name, this.timeline});

  set confirmed(SummaryModel confirmed) => this._confirmed = confirmed;
  set deaths(SummaryModel deaths) => this._deaths = deaths;
  set recovered(SummaryModel recovered) => this._recovered = recovered;

  SummaryModel get confirmed => this._confirmed;
  SummaryModel get deaths => this._deaths;
  SummaryModel get recovered => this._recovered;

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CountryModelToJson(this);
}
