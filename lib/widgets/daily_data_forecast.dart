import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/weathger_data_daily.dart';
import 'package:weather_app/utils/custom_colors.dart';

class DailyDataForecast extends StatelessWidget {
  final WeatherDataDaily weatherDataDaily;
  const DailyDataForecast({super.key, required this.weatherDataDaily});

  String getDay(final day) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final x = DateFormat.E().format(time);
    return x;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 400,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: CustomColors.dividerLine.withAlpha(150),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.only(bottom: 10),
              child: const Text("Next Days",
                  style: TextStyle(
                      color: CustomColors.textColorBlack, fontSize: 17)),
            ),
            dailyList()
          ],
        ));
  }

  Widget dailyList() {
    int len =
        weatherDataDaily.daily.length > 7 ? 7 : weatherDataDaily.daily.length;
    return SizedBox(
      height: 400,
      child: SingleChildScrollView(
        child: Column(
            children: List.generate(len, (index) {
          final infos = weatherDataDaily.daily[index];
          return Column(
            children: [
              Container(
                  height: 60,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          getDay(infos.dt),
                          style: const TextStyle(
                              color: CustomColors.textColorBlack, fontSize: 13),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: Image.asset(
                            "assets/weather/${infos.weather![0].icon}.png"),
                      ),
                      Expanded(
                          flex: 3,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                  "${infos.temp!.max}°/${infos.temp!.min}")))
                    ],
                  )),
              SizedBox(child: index == len - 1 ? null : const Divider())
            ],
          );
        })),
      ),
    );
  }
}
