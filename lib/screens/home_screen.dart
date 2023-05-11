import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/global_controller.dart';
import 'package:weather_app/widgets/comfort_level.dart';
import 'package:weather_app/widgets/current_weather.dart';
import 'package:weather_app/widgets/daily_data_forecast.dart';
import 'package:weather_app/widgets/header_widget.dart';
import 'package:weather_app/widgets/hourly_data_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalController c = Get.put(GlobalController(), permanent: true);
    return Scaffold(
      body: SafeArea(
          child: Obx(() => c.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    const SizedBox(height: 20),
                    const HeaderWidget(),
                    CurrentWeather(
                        weatherDataCurrent: c.weatherData.value.current!),
                    const SizedBox(height: 20),
                    HourlyDataWidget(
                        weatherDataHourly: c.weatherData.value.hourly!),
                    DailyDataForecast(
                        weatherDataDaily: c.weatherData.value.daily!),
                    const Divider(),
                    const SizedBox(height: 10),
                    ComforLevel(
                        weatherDataCurrent: c.weatherData.value.current!)
                  ],
                ))),
    );
  }
}
