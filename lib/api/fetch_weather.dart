import 'dart:convert';

import 'package:weather_app/api/api_key.dart';
import 'package:weather_app/models/weather_data.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_data_current.dart';

class FetchWeatherAPI {
  WeatherData? weatherData;

  Future<WeatherData> processData(lat, lon) async {
    var res = await http.get(Uri.parse(apiURL(lat, lon)));
    var jsonStr = jsonDecode(res.body);
    weatherData = WeatherData(WeatherDataCurrent.fromJson(jsonStr));
    return weatherData!;
  }
}

String apiURL(var lat, var lon) {
  return "https://openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&appid=$apiKey";
}
