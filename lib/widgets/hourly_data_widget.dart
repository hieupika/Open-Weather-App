import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controller/global_controller.dart';
import 'package:weather_app/models/weathger_data_hourly.dart';
import 'package:weather_app/utils/custom_colors.dart';

class HourlyDataWidget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;
  const HourlyDataWidget({super.key, required this.weatherDataHourly});
  static GlobalController c = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          alignment: Alignment.topCenter,
          child: const Text('Today', style: TextStyle(fontSize: 18)),
        ),
        hourlyList()
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 150,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 15),
          child: Row(
              children: List.generate(
                  weatherDataHourly.hourly.length > 12
                      ? 14
                      : weatherDataHourly.hourly.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Obx(() => GestureDetector(
                  onTap: () => c.currentIndex.value = index,
                  child: HourlyDetailsCard(
                    temp: weatherDataHourly.hourly[index].temp!,
                    timeStamp: weatherDataHourly.hourly[index].dt!,
                    weatherIcon:
                        weatherDataHourly.hourly[index].weather![0].icon!,
                    isActive: c.currentIndex.value == index,
                  ))),
            );
          })),
        ),
      ),
    );
  }
}

class HourlyDetailsCard extends StatelessWidget {
  final int temp;
  final int timeStamp;
  final String weatherIcon;
  final bool isActive;

  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String x = DateFormat.jm().format(time);
    return x;
  }

  const HourlyDetailsCard(
      {super.key,
      required this.temp,
      required this.timeStamp,
      required this.weatherIcon,
      this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0.5, 0),
                blurRadius: 30,
                spreadRadius: 1,
                color: CustomColors.dividerLine.withAlpha(150))
          ],
          gradient: isActive
              ? const LinearGradient(colors: [
                  CustomColors.firstGradientColor,
                  CustomColors.secondGradientColor
                ])
              : null),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
              margin: const EdgeInsets.only(top: 10),
              child: Text(
                getTime(timeStamp),
                style: TextStyle(color: isActive ? Colors.white : Colors.black),
              )),
          Container(
              margin: const EdgeInsets.all(5),
              child: Image.asset(
                "assets/weather/$weatherIcon.png",
                height: 40,
                width: 40,
              )),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Text("$temp°",
                style:
                    TextStyle(color: isActive ? Colors.white : Colors.black)),
          )
        ],
      ),
    );
  }
}
