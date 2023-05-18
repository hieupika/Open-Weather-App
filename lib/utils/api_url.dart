const baseURL = "https://openweathermap.org/data/2.5";
const apiKey = "439d4b804bc8187953eb36d2a8c26a02";

Uri oneCallUri(lat, lon) =>
    Uri.parse('$baseURL/onecall').replace(queryParameters: {
      'appid': apiKey,
      'lat': lat.toString(),
      'lon': lon.toString()
    });

Uri searchPlaceUri(String q) =>
    Uri.parse('$baseURL/find').replace(queryParameters: {
      'appid': apiKey,
      'units': 'metric',
      'q': q,
    });
