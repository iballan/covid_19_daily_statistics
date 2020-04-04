import 'dart:convert';

import 'package:covid19/models/index.dart';
import 'package:covid19/utils/CustomCacheManager.dart';

import 'base/BaseService.dart';

class AppGeneralService extends BaseService {
  AppGeneralService() : super();

  Future<List<CountryModel>> getAll() async {
    CustomCacheManager cacheManager = CustomCacheManager();

    final timeSeriesJson = await cacheManager
        .getSingleFile("https://pomber.github.io/covid19/timeseries.json");
    final data = timeSeriesJson.readAsStringSync();
    if (data.isNotEmpty) {
      final body = json.decode(data) as Map<String, dynamic>;
      final keys = body.keys;
      final finalList = keys.map((countryName) {
        final timelines = (body[countryName] as List).map((timeLineData) {
          final dates = (timeLineData['date'] as String).split("-");
          timeLineData['date'] =
              "${dates[0].padLeft(4, '0')}-${dates[1].padLeft(2, '0')}-${dates[2].padLeft(2, '0')}";
          return TimelineModel.fromJson(timeLineData as Map<String, dynamic>);
        }).toList();
        return CountryModel(name: countryName, timeline: timelines);
      }).toList();
//      File file = File
      return finalList;
    } else {
      return List();
    }
  }
}
