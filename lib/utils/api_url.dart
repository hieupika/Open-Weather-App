const baseURL = "https://openweathermap.org/data/2.5";
const apiKey = "439d4b804bc8187953eb36d2a8c26a02";

String oneCallApiURL(var lat, var lon) {
  return "$baseURL/onecall?lat=$lat&lon=$lon&appid=$apiKey";
}

String searchApiURL(String q) {
  return "$baseURL/find?q=$q&appid=$apiKey&units=metric";
}
