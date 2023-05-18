import 'dart:convert';

import 'package:weather_app/models/search_place.dart';
import 'package:weather_app/models/weather_data.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_data_current.dart';
import 'package:weather_app/models/weathger_data_daily.dart';
import 'package:weather_app/models/weathger_data_hourly.dart';
import 'package:weather_app/utils/api_url.dart';

class FetchWeatherAPI {
  Future<WeatherData> oneCall(lat, lon) async {
    var res = await http.get(oneCallUri(lat, lon));
    var jsonStr = jsonDecode(res.body);
    WeatherData weatherData = WeatherData(
        current: WeatherDataCurrent.fromJson(jsonStr),
        hourly: WeatherDataHourly.fromJson(jsonStr),
        daily: WeatherDataDaily.fromJson(jsonStr));
    return weatherData;
  }

  Future<SearchPlace> searchPlace(String q) async {
    var res = await http.get(searchPlaceUri(q));
    var jsonStr = jsonDecode(res.body);
    SearchPlace place = SearchPlace.fromJson(jsonStr);
    return place;
  }
}
