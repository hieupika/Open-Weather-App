const apiKey = "439d4b804bc8187953eb36d2a8c26a02";

String apiURL(var lat, var lon) {
  return "https://openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lon&appid=$apiKey";
}
