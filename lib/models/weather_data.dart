import 'package:weather_app/models/weather_data_current.dart';
import 'package:weather_app/models/weathger_data_hourly.dart';

class WeatherData {
  final WeatherDataCurrent? current;
  final WeatherDataHourly? hourly;

  WeatherData({this.current, this.hourly});
}
