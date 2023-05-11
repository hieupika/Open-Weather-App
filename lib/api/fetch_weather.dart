import 'dart:convert';

import 'package:weather_app/models/weather_data.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_data_current.dart';
import 'package:weather_app/models/weathger_data_daily.dart';
import 'package:weather_app/models/weathger_data_hourly.dart';
import 'package:weather_app/utils/api_url.dart';

class FetchWeatherAPI {
  WeatherData? weatherData;

  Future<WeatherData> processData(lat, lon) async {
    var res = await http.get(Uri.parse(apiURL(lat, lon)));
    var jsonStr = jsonDecode(res.body);
    weatherData = WeatherData(
        current: WeatherDataCurrent.fromJson(jsonStr),
        hourly: WeatherDataHourly.fromJson(jsonStr),
        daily: WeatherDataDaily.fromJson(jsonStr));
    return weatherData!;
  }
}
