import 'dart:async';
import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/api/fetch_weather.dart';
import 'package:weather_app/controller/global_controller.dart';
import 'package:weather_app/models/search_place.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        titleSpacing: 20,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: false,
        elevation: 0,
        title: Obx(() => Text(
              c.name.value,
              style:
                  const TextStyle(fontSize: 28, fontWeight: FontWeight.normal),
            )),
        actions: [
          IconButton(
              onPressed: () => c.getLocation(),
              icon: const Icon(Icons.near_me_outlined)),
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: IconButton(
                onPressed: () =>
                    showSearch(context: context, delegate: CustomSearch()),
                icon: const Icon(Icons.search)),
          )
        ],
      ),
      body: SafeArea(
          child: Obx(() => c.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    const HeaderWidget(),
                    const SizedBox(height: 20),
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

class CustomSearch extends SearchDelegate {
  List<PlaceInfo> data = [];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.only(right: 4),
        child: IconButton(
            onPressed: () => query = '', icon: const Icon(Icons.clear)),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back_ios_new));
  }

  Timer? debounce;
  GlobalController c = Get.put(GlobalController(), permanent: true);

  @override
  Widget buildSuggestions(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        if (debounce?.isActive ?? false) debounce?.cancel();
        var queryFormat = query.trim().toLowerCase();
        if (queryFormat.isEmpty) {
          setState(() => data = []);
        } else {
          debounce = Timer(const Duration(seconds: 2), () {
            FetchWeatherAPI().searchPlace(queryFormat).then((value) {
              if (context.mounted) {
                setState(() {
                  data = List<PlaceInfo>.from(value.list);
                });
              }
            });
          });
        }

        return SingleChildScrollView(
          child: Column(
              children: List.generate(data.length, (index) {
            var name = data[index].name;
            var coord = data[index].coord;
            var flag = data[index].sys.country.toLowerCase();
            return ListTile(
                title: Row(children: [
                  CircleFlag(flag, size: 20),
                  const SizedBox(width: 10),
                  Text(name)
                ]),
                onTap: () {
                  c.name.value = name;
                  c.updateLocation(coord.lat, coord.lon);
                  close(context, null);
                });
          })),
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var queryFormat = query.trim().toLowerCase();

    Future<List<PlaceInfo>> searchPlace() async {
      if (queryFormat.isEmpty) return [];
      var place = await FetchWeatherAPI().searchPlace(queryFormat);
      return List<PlaceInfo>.from(place.list);
    }

    return FutureBuilder<List<PlaceInfo>>(
        future: searchPlace(),
        builder: (context, snapshot) {
          List<Widget> children = [];
          if (snapshot.hasData) {
            final result = snapshot.data!;
            children = List.generate(result.length, (index) {
              var name = result[index].name;
              var coord = result[index].coord;
              var flag = result[index].sys.country.toLowerCase();
              return ListTile(
                  title: Row(children: [
                    CircleFlag(flag, size: 20),
                    const SizedBox(width: 10),
                    Text(name)
                  ]),
                  onTap: () {
                    c.name.value = name;
                    c.updateLocation(coord.lat, coord.lon);
                    close(context, null);
                  });
            });
            return SingleChildScrollView(child: Column(children: children));
          }
          return const SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Align(child: CircularProgressIndicator()),
          ));
        });
  }
}
