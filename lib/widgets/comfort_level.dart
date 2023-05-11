import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:weather_app/models/weather_data_current.dart';
import 'package:weather_app/utils/custom_colors.dart';

class ComforLevel extends StatelessWidget {
  final WeatherDataCurrent weatherDataCurrent;
  const ComforLevel({super.key, required this.weatherDataCurrent});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin:
              const EdgeInsets.only(top: 1, left: 20, right: 20, bottom: 20),
          child: const Text(
            "Comfort Level",
            style: TextStyle(fontSize: 18),
          ),
        ),
        SizedBox(
          height: 180,
          child: Column(children: [
            Center(
              child: SleekCircularSlider(
                min: 0,
                max: 100,
                initialValue: weatherDataCurrent.current.humidity!.toDouble(),
                appearance: CircularSliderAppearance(
                    customWidths: CustomSliderWidths(
                        handlerSize: 0, trackWidth: 12, progressBarWidth: 12),
                    infoProperties: InfoProperties(
                        bottomLabelText: 'Humidity',
                        bottomLabelStyle: const TextStyle(
                            letterSpacing: 0.1, fontSize: 14, height: 1.5)),
                    animationEnabled: true,
                    size: 140,
                    customColors: CustomSliderColors(
                        hideShadow: true,
                        trackColor:
                            CustomColors.firstGradientColor.withAlpha(100),
                        progressBarColors: [
                          CustomColors.firstGradientColor,
                          CustomColors.secondGradientColor
                        ])),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InfoText(
                  title: "Feels Like",
                  text: "${weatherDataCurrent.current.feelsLike}",
                ),
                InfoText(
                  title: "UV Index",
                  text: "${weatherDataCurrent.current.uvi}",
                )
              ],
            )
          ]),
        )
      ],
    );
  }
}

class InfoText extends StatelessWidget {
  const InfoText({
    super.key,
    required this.title,
    required this.text,
  });

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: "$title ",
          style: const TextStyle(
              fontSize: 14,
              height: 0.8,
              color: CustomColors.textColorBlack,
              fontWeight: FontWeight.w400)),
      TextSpan(
          text: text,
          style: const TextStyle(
              fontSize: 14,
              height: 0.8,
              color: CustomColors.textColorBlack,
              fontWeight: FontWeight.w400))
    ]));
  }
}
