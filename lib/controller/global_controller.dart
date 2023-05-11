import 'package:geolocator/geolocator.dart';
import 'package:get/state_manager.dart';
import 'package:weather_app/api/fetch_weather.dart';
import 'package:weather_app/models/weather_data.dart';

class GlobalController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxDouble lattitude = 0.0.obs;
  final RxDouble longitude = 0.0.obs;
  final RxInt currentIndex = 0.obs;

  final weatherData = WeatherData().obs;

  RxDouble getLattitude() => lattitude;
  RxDouble getLongitude() => longitude;

  @override
  void onInit() {
    if (isLoading.isTrue) getLocation();
    super.onInit();
  }

  getLocation() async {
    bool isServiceEnabled;
    LocationPermission locationPermission;

    isServiceEnabled = await Geolocator.isLocationServiceEnabled();

    // return if service not enabled
    if (!isServiceEnabled) {
      return Future.error("Location not enable");
    }

    // Status of permission
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location permission are denied forever");
    } else if (locationPermission == LocationPermission.denied) {
      // request permisstion
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error("Location permission is denied");
      }
    }

    // getting the current position
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      lattitude.value = value.latitude;
      longitude.value = value.longitude;

      return FetchWeatherAPI()
          .processData(value.latitude, value.longitude)
          .then((value) {
        weatherData.value = value;
        isLoading.value = false;
      });
    });
  }
}
