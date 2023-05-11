import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_data_current.dart';
import 'package:weather_app/utils/custom_colors.dart';

class CurrentWeather extends StatelessWidget {
  const CurrentWeather({super.key, required this.weatherDataCurrent});
  final WeatherDataCurrent weatherDataCurrent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        tempuratureAreaWidget(),
        const SizedBox(height: 20),
        currentWeatherMoreDetailsWidget(),
      ],
    );
  }

  Widget tempuratureAreaWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset(
            "assets/weather/${weatherDataCurrent.current.weather![0].icon}.png",
            width: 80,
            height: 80),
        Container(
          height: 50,
          width: 1,
          color: CustomColors.dividerLine,
        ),
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text: "${weatherDataCurrent.current.temp!.toInt()}°",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 68,
                color: CustomColors.textColorBlack,
              )),
          TextSpan(
              text: "${weatherDataCurrent.current.weather![0].description}",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.grey,
              ))
        ]))
      ],
    );
  }

  Widget currentWeatherMoreDetailsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InfoBox(
            text: "${weatherDataCurrent.current.windSpeed}km/h",
            imgSrc: "assets/icons/windspeed.png"),
        InfoBox(
            text: "${weatherDataCurrent.current.windSpeed}%",
            imgSrc: "assets/icons/clouds.png"),
        InfoBox(
            text: "${weatherDataCurrent.current.windSpeed}%",
            imgSrc: "assets/icons/humidity.png"),
      ],
    );
  }
}

class InfoBox extends StatelessWidget {
  const InfoBox({
    super.key,
    required this.text,
    required this.imgSrc,
  });

  final String text;
  final String imgSrc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: CustomColors.cardColor,
              borderRadius: BorderRadius.circular(15)),
          child: Image.asset(imgSrc),
        ),
        const SizedBox(height: 10),
        SizedBox(
            height: 20,
            width: 60,
            child: Text(text,
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.center)),
      ],
    );
  }
}
