import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:weather_app/screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: HomeScreen(),
      title: 'Weather',
      debugShowCheckedModeBanner: false,
    );
  }
}
